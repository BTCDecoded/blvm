#!/usr/bin/env python3
"""Build a Keep a Changelog file from git tags.

History from before Conventional Commits were enforced is grouped by tag and
labeled reconstructed. Merge commits are left in git rather than copied here.
"""

from __future__ import annotations

import argparse
import subprocess
from pathlib import Path

GITHUB = "https://github.com/BTCDecoded"


def git(repo: Path, *args: str) -> str:
    return subprocess.check_output(["git", *args], cwd=repo, text=True)


def tags(repo: Path) -> list[tuple[str, str]]:
    raw = git(
        repo,
        "for-each-ref",
        "refs/tags",
        "--sort=creatordate",
        "--format=%(refname:short)%09%(creatordate:short)",
    )
    found = []
    for line in raw.splitlines():
        if not line.strip():
            continue
        name, date = line.split("\t", 1)
        found.append((name, date))
    return found


def subjects(repo: Path, revision: str) -> list[tuple[str, str]]:
    raw = git(repo, "log", "--reverse", "--pretty=%H\t%s", revision)
    rows = []
    for line in raw.splitlines():
        if not line.strip():
            continue
        sha, subject = line.split("\t", 1)
        if subject.startswith("Merge "):
            continue
        rows.append((sha, subject))
    return rows


def render(repo: Path, name: str) -> str:
    lines = [
        f"# Changelog",
        "",
        f"All notable changes to `{name}` are documented in this file.",
        "",
        "The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).",
        "Every section below is reconstructed from git history. Conventional Commits",
        "were not enforced when those commits were written. Merge commits are omitted.",
        "",
        "## [Unreleased]",
        "",
    ]
    history = tags(repo)
    previous = None
    remote = repo.name
    for name_tag, date in history:
        revision = name_tag if previous is None else f"{previous}..{name_tag}"
        rows = subjects(repo, revision)
        lines.append(f"## [{name_tag}] - {date}")
        lines.append("")
        lines.append("### Reconstructed")
        lines.append("")
        if not rows:
            lines.append("- No non-merge commits in this tag range.")
        for sha, subject in rows:
            url = f"{GITHUB}/{remote}/commit/{sha}"
            lines.append(f"- {subject} ([{sha[:12]}]({url}))")
        lines.append("")
        previous = name_tag
    return "\n".join(lines).rstrip() + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--name", required=True)
    parser.add_argument("--out", required=True, type=Path)
    args = parser.parse_args()
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(render(args.repo, args.name))
    print(args.out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
