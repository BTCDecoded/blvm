#!/usr/bin/env python3
"""Rewrite sibling blvm crate deps in Cargo.toml for develop channel CI."""
from __future__ import annotations

import argparse
import json
import re
import sys
import urllib.request
from pathlib import Path

RELEASE_SET_SIBLINGS = (
    "blvm-consensus",
    "blvm-protocol",
    "blvm-node",
    "blvm-sdk",
)

DEP_SECTIONS = frozenset({"dependencies", "dev-dependencies", "build-dependencies"})


def fetch_versions(crate: str) -> list[str]:
    req = urllib.request.Request(
        f"https://crates.io/api/v1/crates/{crate}/versions",
        headers={"User-Agent": "blvm-ci/1.0 (github.com/BTCDecoded)"},
    )
    with urllib.request.urlopen(req, timeout=30) as resp:
        data = json.load(resp)
    return [v["num"] for v in data.get("versions", [])]


def patch_num(ver: str) -> int:
    core = ver.split("-", 1)[0]
    parts = core.split(".")
    if len(parts) < 3:
        raise ValueError(f"bad version: {ver}")
    return int(parts[2])


def max_stable(versions: list[str]) -> str | None:
    stable = [v for v in versions if re.fullmatch(r"\d+\.\d+\.\d+", v)]
    if not stable:
        return None
    return sorted(stable, key=lambda s: [int(x) for x in s.split(".")])[-1]


def max_dev_on_prefix(versions: list[str], prefix: str) -> str | None:
    pat = re.compile(rf"^{re.escape(prefix)}\.(\d+)$")
    best = None
    best_m = -1
    for v in versions:
        m = pat.match(v)
        if m:
            n = int(m.group(1))
            if n > best_m:
                best_m = n
                best = v
    return best


def latest_dev_after_stable(versions: list[str], s: str) -> str | None:
    parts = s.split(".")
    major, minor, spatch = int(parts[0]), int(parts[1]), int(parts[2])
    prefix = f"{major}.{minor}.{spatch + 1}-dev"
    return max_dev_on_prefix(versions, prefix)


def is_sibling_line(line: str, crate: str) -> bool:
    return bool(re.match(rf"^{re.escape(crate)}\s*=", line))


def rewrite_version_in_line(line: str, new_ver: str) -> str:
    crate = line.split("=", 1)[0].strip()
    # inline table
    if "{" in line:
        if re.search(r'version\s*=\s*"[^"]*"', line):
            return re.sub(
                r'version\s*=\s*"[^"]*"',
                f'version = "={new_ver}"',
                line,
                count=1,
            )
        return re.sub(r"\{\s*", f'{{ version = "={new_ver}", ', line, count=1)
    # simple string dep
    return re.sub(
        rf"^({re.escape(crate)}\s*=\s*)\"[^\"]*\"",
        rf'\1"={new_ver}"',
        line,
    )


def should_rewrite_line(line: str, siblings: set[str]) -> str | None:
    stripped = line.strip()
    for crate in siblings:
        if is_sibling_line(stripped, crate):
            return crate
    return None


def process_file(
    path: Path,
    mode: str,
    publish_version: str | None,
    siblings: set[str],
) -> bool:
    lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    section: str | None = None
    changed = False
    out: list[str] = []

    for line in lines:
        header = line.strip()
        if header.startswith("[") and header.endswith("]"):
            name = header[1:-1].strip()
            if name in DEP_SECTIONS:
                section = name
            else:
                section = None
            out.append(line)
            continue

        if section in DEP_SECTIONS:
            crate = should_rewrite_line(line, siblings)
            if crate:
                if mode == "publish":
                    assert publish_version
                    new_line = rewrite_version_in_line(line, publish_version)
                    if new_line != line:
                        changed = True
                    out.append(new_line)
                    continue
                if mode == "resolve":
                    versions = fetch_versions(crate)
                    s = max_stable(versions)
                    d = latest_dev_after_stable(versions, s) if s else None
                    if s and d and patch_num(d) > patch_num(s):
                        new_line = rewrite_version_in_line(line, d)
                        if new_line != line:
                            print(
                                f"{path}: {crate} patch-ahead → ={d} (stable {s})",
                                file=sys.stderr,
                            )
                            changed = True
                        out.append(new_line)
                        continue

        out.append(line)

    if changed:
        path.write_text("".join(out), encoding="utf-8")
    return changed


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mode", choices=("resolve", "publish"), required=True)
    parser.add_argument("--version", help="Coordinated develop version V (publish mode)")
    parser.add_argument(
        "--sibling",
        action="append",
        help="Sibling crate name (default: release set)",
    )
    parser.add_argument("cargo_tomls", nargs="+", type=Path)
    args = parser.parse_args()

    if args.mode == "publish" and not args.version:
        parser.error("publish mode requires --version")

    siblings = set(args.sibling or RELEASE_SET_SIBLINGS)
    any_changed = False
    for path in args.cargo_tomls:
        if not path.is_file():
            print(f"skip missing {path}", file=sys.stderr)
            continue
        if process_file(path, args.mode, args.version, siblings):
            any_changed = True
    return 0 if any_changed or args.mode == "publish" else 0


if __name__ == "__main__":
    sys.exit(main())
