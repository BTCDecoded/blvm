#!/usr/bin/env python3
"""Write the minimal-build audit surface report.

The report records hashes and counts it measured. A missing input stays
"not measured". It does not decide that the beta gate is met.
"""

from __future__ import annotations

import argparse
import hashlib
import re
import subprocess
import tomllib
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WORKSPACE = ROOT.parent
FIRST_PARTY = (
    "blvm",
    "blvm-node",
    "blvm-consensus",
    "blvm-protocol",
    "blvm-primitives",
    "blvm-secp256k1",
    "blvm-muhash",
)
FORBIDDEN = (
    "blvm-sdk",
    "iroh",
    "blvm-stratum-v2",
    "blvm-index",
    "blvm-fees",
    "blvm-wallet-index",
    "blvm-monitor",
    "blvm-miningos",
    "blvm-governance",
    "hickory-proto",
    "hickory-resolver",
)
GEIGER_TOTAL = re.compile(
    r"^(\d+/\d+)\s+(\d+/\d+)\s+(\d+/\d+)\s+(\d+/\d+)\s+(\d+/\d+)\s*$"
)
GEIGER_ROW = re.compile(
    r"^\s*(\d+/\d+)\s+(\d+/\d+)\s+(\d+/\d+)\s+(\d+/\d+)\s+(\d+/\d+)\s+(\S+)\s+(.*)$"
)
TREE_PKG = re.compile(r"^(\S+) v(\S+)")


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def git_head(repo: Path) -> str:
    if not (repo / ".git").exists():
        return "not a git checkout"
    try:
        return subprocess.check_output(
            ["git", "-C", str(repo), "rev-parse", "HEAD"], text=True
        ).strip()
    except subprocess.CalledProcessError:
        return "git rev-parse failed"


def dirty(repo: Path, path: str) -> str:
    try:
        out = subprocess.check_output(
            ["git", "-C", str(repo), "status", "--porcelain", "--", path], text=True
        )
    except subprocess.CalledProcessError:
        return "unknown"
    return "dirty" if out.strip() else "clean"


def rust_lines(crate: Path) -> int | None:
    src = crate / "src"
    if not src.is_dir():
        return None
    total = 0
    for path in src.rglob("*.rs"):
        if "target" in path.parts:
            continue
        total += sum(1 for _ in path.open("rb"))
    return total


def parse_geiger(text: str) -> tuple[str | None, str | None, dict[str, str]]:
    total = None
    warnings = None
    rows: dict[str, str] = {}
    for line in text.splitlines():
        if line.startswith("{") or "Failed to match" in line:
            continue
        found = re.search(r"Found (\d+) warnings", line)
        if found:
            warnings = found.group(1)
        if GEIGER_TOTAL.match(line.strip()):
            total = line.strip()
            continue
        match = GEIGER_ROW.match(line)
        if not match:
            continue
        tail = match.group(7).strip()
        parts = tail.split()
        if len(parts) < 2:
            continue
        name, version = parts[-2], parts[-1]
        if name not in FIRST_PARTY or name in rows:
            continue
        marker = match.group(6)
        if marker == "?":
            measured = "unknown to the scanner"
        else:
            measured = f"functions {match.group(1)}, expressions {match.group(2)}"
        rows[name] = f"{measured}, version {version}, marker {marker}"
    return total, warnings, rows


def parse_tree(text: str) -> list[tuple[str, str]]:
    found = []
    seen = set()
    for line in text.splitlines():
        match = TREE_PKG.match(line.strip())
        if not match:
            continue
        key = (match.group(1), match.group(2))
        if key in seen:
            continue
        seen.add(key)
        found.append(key)
    return found


def cargo_tree(target_dir: Path) -> tuple[str, str]:
    env = dict(**{k: v for k, v in __import__("os").environ.items()})
    env["CARGO_TARGET_DIR"] = str(target_dir)
    commands = [
        ["cargo", "tree", "--prefix", "none", "-e", "normal", "--offline",
         "--no-default-features", "--features", "minimal", "--target=all"],
        ["cargo", "tree", "--prefix", "none", "--depth", "1", "-e", "normal",
         "--offline", "--no-default-features", "--features", "minimal"],
    ]
    chunks = []
    for command in commands:
        result = subprocess.run(
            command, cwd=ROOT, env=env, text=True, capture_output=True
        )
        chunks.append("$ " + " ".join(command))
        chunks.append(f"exit {result.returncode}")
        chunks.append(result.stdout)
        if result.returncode != 0:
            chunks.append(result.stderr[-2000:])
            break
    full, _, direct = "\n".join(chunks).partition("$ cargo tree --prefix none --depth")
    return full, "$ cargo tree --prefix none --depth" + direct


def minimal_features() -> str:
    cargo = tomllib.loads((ROOT / "Cargo.toml").read_text())
    features = cargo.get("features") or {}
    minimal = features.get("minimal")
    if minimal is None:
        return "not measured"
    return json_dumps(minimal)


def json_dumps(value: object) -> str:
    import json
    return json.dumps(value)


def self_test() -> int:
    total, warnings, rows = parse_geiger(
        "\n".join(
            [
                "0/0        2/2          0/0    0/0     0/0      !  blvm 0.1.0",
                "0/0        0/0          0/0    0/0     0/0      ?  |-- blvm-protocol 0.1.48",
                "347/558    30150/38245  764/855 84/89   1027/1488",
                "error: Found 237 warnings",
            ]
        )
    )
    if total is None or warnings != "237" or "blvm" not in rows:
        print("geiger parse failed", total, warnings, rows)
        return 1
    if "unknown to the scanner" not in rows["blvm-protocol"]:
        print("unknown geiger row was treated as a zero count", rows)
        return 1
    packages = parse_tree("blvm v0.1.0\nblvm-node v0.1.92\nblvm-node v0.1.92\n")
    if packages != [("blvm", "0.1.0"), ("blvm-node", "0.1.92")]:
        print("tree parse failed", packages)
        return 1
    if any(name == "iroh" for name, _ in packages):
        print("tree invented iroh")
        return 1
    print("self-test passed")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path)
    parser.add_argument(
        "--geiger",
        type=Path,
        default=WORKSPACE / "docs/stability/geiger-minimal-2026-11-13.txt",
    )
    parser.add_argument(
        "--binary",
        type=Path,
        default=ROOT / "target/release/blvm-minimal",
    )
    parser.add_argument(
        "--profile",
        type=Path,
        default=WORKSPACE / "blvm-node/config/minimal-hardened.toml",
    )
    parser.add_argument(
        "--cargo-target-dir",
        type=Path,
        default=Path("/tmp/blvm-audit-surface-target"),
    )
    parser.add_argument("--skip-cargo", action="store_true")
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()
    if args.self_test:
        return self_test()
    if args.out is None:
        parser.error("--out is required")

    measured = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    lines = [
        "# Minimal build audit surface",
        "",
        f"Measured {measured}. This is a dry-run report. It is not a published release artifact.",
        "",
        f"blvm HEAD: `{git_head(ROOT)}`. `Cargo.toml` is {dirty(ROOT, 'Cargo.toml')}.",
        f"`Cargo.lock` is {dirty(ROOT, 'Cargo.lock')}.",
        "`src/bin/main.rs` is "
        + dirty(ROOT, "src/bin/main.rs")
        + ". A dirty `main.rs` means the binary hash below is not a commit hash.",
        "",
        "## Feature flag",
        "",
        f"`minimal` = `{minimal_features()}`.",
        "",
        "## Hardened profile",
        "",
    ]
    if args.profile.is_file():
        lines.append(
            f"`{args.profile.name}` sha256 `{sha256(args.profile)}` "
            f"({args.profile.stat().st_size} bytes)."
        )
    else:
        lines.append("Profile hash: not measured. The file was absent.")
    lines.extend(["", "## Binary", ""])
    if args.binary.is_file():
        lines.append(
            f"`{args.binary.name}` sha256 `{sha256(args.binary)}` "
            f"({args.binary.stat().st_size} bytes)."
        )
    else:
        lines.append("Binary hash: not measured. The file was absent.")

    lines.extend(["", "## Lines of Rust under src", ""])
    for name in FIRST_PARTY:
        crate = WORKSPACE / name
        count = rust_lines(crate)
        head = git_head(crate)
        if count is None:
            lines.append(f"- {name}: not measured. No `src/` directory. HEAD `{head}`.")
        else:
            lines.append(f"- {name}: {count} lines. HEAD `{head}`.")

    lines.extend(["", "## cargo-geiger", ""])
    if args.geiger.is_file():
        total, warnings, rows = parse_geiger(args.geiger.read_text(errors="replace"))
        lines.append(f"Source file: `{args.geiger.name}`.")
        lines.append(
            "Totals are unsafe/total for functions, expressions, impls, traits, and methods."
        )
        lines.append(f"Total line: `{total or 'not measured'}`." )
        lines.append(f"Warnings: `{warnings or 'not measured'}`.")
        if not rows:
            lines.append("First-party rows: not measured. The log had no matching crate lines.")
        for name in FIRST_PARTY:
            if name in rows:
                lines.append(f"- {name}: {rows[name]}")
            else:
                lines.append(f"- {name}: not in the geiger log")
    else:
        lines.append("cargo-geiger: not measured. No log file was passed.")

    lines.extend(["", "## Dependencies", ""])
    if args.skip_cargo:
        lines.append("Dependency tree: not measured. `--skip-cargo` was set.")
        packages = []
    else:
        full, direct = cargo_tree(args.cargo_target_dir)
        packages = parse_tree(full)
        direct_packages = parse_tree(direct)
        lines.append(
            "The tree is the working copy. It is not HEAD. "
            "`Cargo.toml` and `Cargo.lock` were already dirty when this ran."
        )
        lines.append(f"Unique normal packages in the `--target=all` tree: {len(packages)}.")
        lines.append("Direct normal dependencies:")
        if direct_packages:
            for name, version in direct_packages:
                if name == "blvm":
                    continue
                lines.append(f"- {name} {version}")
        else:
            lines.append("- not measured. `cargo tree` produced no package lines.")
        lines.append("")
        if not packages:
            lines.append(
                "Forbidden-name scan: not measured. An empty tree is not evidence that a crate is absent."
            )
        else:
            lines.append("Forbidden names in that tree:")
            names = {name for name, _ in packages}
            for forbidden in FORBIDDEN:
                state = "present" if forbidden in names else "absent"
                lines.append(f"- {forbidden}: {state}")

    lines.extend(
        [
            "",
            "## What this report is not",
            "",
            "It is not the three-artifact parity run, the 50+50 crash gate, or a differential record.",
            "Criterion 11 stays Not met until one binary hash is the candidate for the freeze commit.",
            "",
        ]
    )
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text("\n".join(lines))
    print(args.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
