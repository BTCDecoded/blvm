#!/usr/bin/env python3
"""Aggregate crate subjects into project release notes.

The first beta has no previous project version. Notes cover 2026-11-01
through the freeze commits. The differential record id stays a placeholder.

Security lines come from the advisory JSON files. The generator copies the
id, severity, state, crate release, and fix commit. It does not invent an id
or a project release for an unfixed advisory.
"""

from __future__ import annotations

import argparse
import json
import subprocess
from pathlib import Path

GITHUB = "https://github.com/BTCDecoded"


def git(repo: Path, *args: str) -> str:
    return subprocess.check_output(["git", "-C", str(repo), *args], text=True)


def classify(repo_name: str, subject: str, files: list[str]) -> str:
    lower = subject.lower()
    joined = "\n".join(files)
    consensus_repo = repo_name in {"blvm-consensus", "blvm-spec"}
    consensus_path = any(
        name.startswith("src/validation") or name in {"src/genesis.rs", "src/economic.rs", "src/network_params.rs"}
        or name.startswith("src/utxo_commitments/")
        for name in files
    )
    if consensus_repo or consensus_path or "validation_loop.rs" in joined:
        if lower.startswith("docs") or lower.startswith("style") or lower.startswith("chore") or lower.startswith("ci"):
            return "internal"
        return "consensus"
    if any(word in lower for word in ("rustsec", "security", "secret", "auth", "dos")):
        return "security"
    if lower.startswith("feat!") or "breaking" in lower:
        return "breaking"
    if lower.startswith("feat"):
        return "features"
    if lower.startswith("fix"):
        return "fixes"
    return "internal"


def collect(root: Path, since: str, names: list[str]) -> dict[str, list[str]]:
    buckets = {key: [] for key in ("consensus", "breaking", "security", "features", "fixes", "internal")}
    for name in names:
        repo = root / name
        if not (repo / ".git").exists():
            continue
        try:
            raw = git(repo, "log", f"--since={since}", "--pretty=%H\t%s", "--name-only")
        except subprocess.CalledProcessError:
            continue
        sha = ""
        subject = ""
        files: list[str] = []

        def flush() -> None:
            if not sha or subject.startswith("Merge "):
                return
            kind = classify(repo.name, subject, files)
            url = f"{GITHUB}/{repo.name}/commit/{sha}"
            buckets[kind].append(f"- {repo.name}: {subject} ([{sha[:12]}]({url}))")

        for line in raw.splitlines():
            if "\t" in line and len(line.split("\t", 1)[0]) == 40:
                flush()
                sha, subject = line.split("\t", 1)
                files = []
            elif line.strip():
                files.append(line.strip())
            else:
                flush()
                sha = ""
        flush()
    return buckets


def load_advisories(directory: Path) -> list[dict]:
    if not directory.is_dir():
        return []
    records = []
    for path in sorted(directory.glob("BLVM-*.json")):
        record = json.loads(path.read_text())
        if record.get("id") != path.stem:
            raise SystemExit(f"{path.name} id does not match the file name")
        records.append(record)
    return records


def format_advisory(record: dict) -> str:
    extra = record.get("database_specific") or {}
    advisory_id = str(record.get("id") or "")
    severity = extra.get("blvm_severity") or "unset"
    state = extra.get("state") or "unset"
    crates = ", ".join(extra.get("blvm_crates") or []) or "unset"
    fixed = extra.get("fixed_version") or "unset"
    crate_release = extra.get("release") or "unset"
    summary = " ".join(str(record.get("summary") or "").split())
    commit = extra.get("fix_commit") or ""
    fix_url = ""
    for ref in record.get("references") or []:
        if ref.get("type") == "FIX" and ref.get("url"):
            fix_url = str(ref["url"])
            break
    link = ""
    if fix_url and commit:
        link = f" ([{commit[:12]}]({fix_url}))"
    elif fix_url:
        link = f" ([fix]({fix_url}))"
    return (
        f"- {advisory_id} ({severity}, {state}, {crates}, "
        f"fixed version {fixed}, crate release {crate_release}): {summary}{link}"
    )


def advisory_sections(records: list[dict]) -> tuple[list[str], list[str]]:
    closed = []
    opened = []
    for record in records:
        extra = record.get("database_specific") or {}
        line = format_advisory(record)
        if extra.get("state") == "closed":
            closed.append(line)
        else:
            opened.append(line)
    return closed, opened


def render(
    version: str,
    buckets: dict[str, list[str]],
    manifest: str,
    advisories: list[dict] | None = None,
) -> str:
    order = [
        ("consensus", "Consensus"),
        ("breaking", "Breaking changes"),
        ("security", "Security"),
        ("features", "Features"),
        ("fixes", "Fixes"),
        ("internal", "Internal"),
    ]
    lines = [
        f"# BLVM {version}",
        "",
        "AI-drafted summary: not produced. No Cloudflare Workers AI credentials were",
        "available, and the summary is not allowed to invent claims. A person reviews",
        "the aggregate below before publishing.",
        "",
        f"DIFFERENTIAL_RECORD_ID: pending",
        "",
        "This is a dry run. It was not tagged and it was not published.",
        "",
        manifest,
        "",
    ]
    closed, opened = advisory_sections(advisories or [])
    for key, title in order:
        lines.append(f"## {title}")
        lines.append("")
        if key == "security":
            lines.append("Ids below are copied from the advisory record.")
            lines.append("")
            lines.append("### Closed")
            lines.append("")
            lines.extend(closed or ["- None in the advisory record."])
            lines.append("")
            lines.append("### Open")
            lines.append("")
            lines.extend(opened or ["- None in the advisory record."])
            lines.append("")
            lines.append("### Commits classified as security")
            lines.append("")
            rows = buckets[key]
            lines.extend(rows or ["- None in this range."])
            lines.append("")
            continue
        rows = buckets[key]
        if not rows:
            lines.append("- None in this range.")
        else:
            lines.extend(rows)
        lines.append("")
    return "\n".join(lines)


def self_test() -> int:
    closed = {
        "id": "BLVM-2026-0001",
        "summary": "An overflowing output sum was an internal error instead of an invalid block",
        "references": [
            {
                "type": "FIX",
                "url": "https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1",
            }
        ],
        "database_specific": {
            "blvm_severity": "consensus",
            "state": "closed",
            "blvm_crates": ["blvm-consensus"],
            "fixed_version": "0.1.80",
            "release": "0.1.80",
            "fix_commit": "e58e0ad2003a0474d0bb7d9751af29f6b426d3c1",
        },
    }
    opened = {
        "id": "BLVM-2026-0109",
        "summary": "RUSTSEC-2026-0491 still applies to the dependency tree",
        "references": [],
        "database_specific": {
            "blvm_severity": "resource exhaustion",
            "state": "open",
            "blvm_crates": ["blvm", "blvm-node"],
            "fixed_version": None,
            "release": None,
            "fix_commit": None,
        },
    }
    buckets = {key: [] for key in ("consensus", "breaking", "security", "features", "fixes", "internal")}
    text = render("0.2.0-beta.1", buckets, "manifest", [closed, opened])
    security = text.split("## Security", 1)[1].split("## Features", 1)[0]
    if "BLVM-2026-0001" not in security or "e58e0ad2003a" not in security:
        print("closed advisory id or fix commit missing")
        return 1
    if "BLVM-2026-0109" not in security or "fixed version unset" not in security:
        print("open advisory was dropped or marked fixed")
        return 1
    open_line = next(line for line in security.splitlines() if "BLVM-2026-0109" in line)
    if "0.2.0-beta.1" in open_line or "BLVM-2026-9999" in text:
        print("open advisory claimed a project release, or an unknown id appeared")
        return 1
    if "DIFFERENTIAL_RECORD_ID: pending" not in text:
        print("differential placeholder missing")
        return 1
    print("self-test passed")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path)
    parser.add_argument("--version")
    parser.add_argument("--since", default="2026-11-01")
    parser.add_argument("--manifest", type=Path)
    parser.add_argument("--out", type=Path)
    parser.add_argument(
        "--repos",
        default="blvm,blvm-node,blvm-consensus,blvm-protocol,blvm-spec,blvm-spec-lock,blvm-primitives",
    )
    parser.add_argument(
        "--advisories",
        type=Path,
        help="Directory of BLVM-*.json advisory files. Missing directory leaves the section empty.",
    )
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()
    if args.self_test:
        return self_test()
    if not args.root or not args.version or not args.manifest or not args.out:
        parser.error("--root, --version, --manifest, and --out are required")
    advisories = load_advisories(args.advisories) if args.advisories else []
    buckets = collect(args.root, args.since, [name for name in args.repos.split(",") if name])
    text = render(args.version, buckets, args.manifest.read_text().strip(), advisories)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(text)
    print(args.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
