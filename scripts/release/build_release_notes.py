#!/usr/bin/env python3
"""Aggregate crate subjects into project release notes.

The first beta has no previous project version. Notes cover 2026-11-01
through the freeze commits. The differential record id stays a placeholder.
"""

from __future__ import annotations

import argparse
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


def render(version: str, buckets: dict[str, list[str]], manifest: str) -> str:
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
    for key, title in order:
        lines.append(f"## {title}")
        lines.append("")
        rows = buckets[key]
        if not rows:
            lines.append("- None in this range.")
        else:
            lines.extend(rows)
        lines.append("")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--version", required=True)
    parser.add_argument("--since", default="2026-11-01")
    parser.add_argument("--manifest", required=True, type=Path)
    parser.add_argument("--out", required=True, type=Path)
    parser.add_argument(
        "--repos",
        default="blvm,blvm-node,blvm-consensus,blvm-protocol,blvm-spec,blvm-spec-lock,blvm-primitives",
    )
    args = parser.parse_args()
    buckets = collect(args.root, args.since, [name for name in args.repos.split(",") if name])
    text = render(args.version, buckets, args.manifest.read_text().strip())
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(text)
    print(args.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
