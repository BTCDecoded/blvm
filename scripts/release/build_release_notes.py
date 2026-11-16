#!/usr/bin/env python3
"""Accumulate project release notes from git tags.

Each project tag gets one section: commits in this repository since the
previous tag, crate versions from Cargo.lock at that tag, checksums when the
tag has them, and the advisory JSON at that tag. A later run leaves a
published section as it was and rewrites only Unreleased.

Security lines come from the advisory JSON files. The generator copies the
id, severity, state, crate release, and fix commit. It does not invent an id
or a project release for an unfixed advisory.
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
from pathlib import Path

GITHUB = "https://github.com/BTCDecoded"


def git(repo: Path, *args: str, quiet: bool = False) -> str:
    err = subprocess.DEVNULL if quiet else None
    return subprocess.check_output(["git", "-C", str(repo), *args], text=True, stderr=err)


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
        "DIFFERENTIAL_RECORD_ID: pending",
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


HEADER = """# BLVM release notes

Each section is generated from the previous git tag, `Cargo.lock` at that tag, and the advisory JSON. Unreleased is rewritten from commits after the latest tag. A published section is left as it was.
"""

PROJECT_TAG = re.compile(r"^v(?:0\.[2-9]\.|[1-9])")
LINKED = (
    "blvm-node",
    "blvm-consensus",
    "blvm-protocol",
    "blvm-sdk",
    "blvm-spec-lock",
    "blvm-primitives",
    "blvm-secp256k1",
)


def github_name(repo: Path) -> str:
    url = git(repo, "remote", "get-url", "origin").strip()
    name = url.removesuffix(".git").split("/")[-1]
    if ":" in name:
        name = name.split(":")[-1]
    return name


def collect_range(repo: Path, revision: str) -> dict[str, list[str]]:
    buckets = {key: [] for key in ("consensus", "breaking", "security", "features", "fixes", "internal")}
    name = github_name(repo)
    try:
        raw = git(repo, "log", "--reverse", revision, "--pretty=%H\t%s", "--name-only")
    except subprocess.CalledProcessError as exc:
        raise SystemExit(f"git log {revision} failed: {exc}") from exc
    sha = ""
    subject = ""
    files: list[str] = []

    def flush() -> None:
        if not sha or subject.startswith("Merge "):
            return
        kind = classify(name, subject, files)
        url = f"{GITHUB}/{name}/commit/{sha}"
        buckets[kind].append(f"- {subject} ([{sha[:12]}]({url}))")

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


def lock_versions(lock_text: str) -> dict[str, str]:
    found: dict[str, str] = {}
    name = ""
    version = ""
    for line in lock_text.splitlines():
        if line.strip() == "[[package]]":
            if name in LINKED and name not in found and version:
                found[name] = version
            name = ""
            version = ""
            continue
        if line.startswith("name = "):
            name = line.split("=", 1)[1].strip().strip('"')
        elif line.startswith("version = ") and not version:
            version = line.split("=", 1)[1].strip().strip('"')
    if name in LINKED and name not in found and version:
        found[name] = version
    return found


def show_file(repo: Path, rev: str, path: str) -> str | None:
    try:
        return git(repo, "show", f"{rev}:{path}", quiet=True)
    except subprocess.CalledProcessError:
        return None


def advisories_at(repo: Path, rev: str) -> list[dict]:
    try:
        listing = git(repo, "ls-tree", "-r", "--name-only", rev, "docs/security/advisories")
    except subprocess.CalledProcessError:
        return []
    records = []
    for path in sorted(line for line in listing.splitlines() if line.endswith(".json")):
        text = show_file(repo, rev, path)
        if text is None:
            continue
        record = json.loads(text)
        if record.get("id") != Path(path).stem:
            raise SystemExit(f"{path} id does not match the file name")
        records.append(record)
    return records


def section_body(
    repo: Path,
    revision: str,
    previous: str,
    lock_text: str | None,
    records: list[dict],
    checksums: str | None,
    differential: str,
) -> str:
    buckets = collect_range(repo, revision) if previous else {key: [] for key in ("consensus", "breaking", "security", "features", "fixes", "internal")}
    lines = [
        f"Previous tag: {previous or 'none'}",
        f"DIFFERENTIAL_RECORD_ID: {differential}",
        "",
        "### Linked crates",
        "",
        "Versions read from `Cargo.lock` at this revision.",
        "",
    ]
    versions = lock_versions(lock_text or "")
    if not versions:
        lines.append("- Cargo.lock has none of the linked crates.")
    for name in LINKED:
        if name in versions:
            lines.append(f"- `{name}` {versions[name]}")
    lines.append("")
    lines.append("### Checksums")
    lines.append("")
    if checksums and checksums.strip():
        lines.append("```")
        lines.append(checksums.strip())
        lines.append("```")
    else:
        lines.append("- No checksum file at this revision.")
    lines.append("")
    order = [
        ("consensus", "Consensus"),
        ("breaking", "Breaking changes"),
        ("security", "Security"),
        ("features", "Features"),
        ("fixes", "Fixes"),
        ("internal", "Internal"),
    ]
    closed, opened = advisory_sections(records)
    for key, title in order:
        lines.append(f"### {title}")
        lines.append("")
        if key == "security":
            lines.append("Ids copied from the advisory JSON at this revision.")
            lines.append("")
            lines.append("#### Closed")
            lines.append("")
            lines.extend(closed or ["- None in the advisory record."])
            lines.append("")
            lines.append("#### Open")
            lines.append("")
            lines.extend(opened or ["- None in the advisory record."])
            lines.append("")
            continue
        rows = buckets[key]
        lines.extend(rows or ["- None in this range."])
        lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def parse_notes(text: str) -> tuple[str, dict[str, str]]:
    sections: dict[str, str] = {}
    current = None
    chunk: list[str] = []
    header: list[str] = []
    for line in text.splitlines(keepends=True):
        if line.startswith("## ["):
            if current is None:
                header_text = "".join(header).rstrip() + "\n"
            else:
                sections[current] = "".join(chunk)
            name = line.split("]", 1)[0][4:]
            current = name
            chunk = [line if line.endswith("\n") else line + "\n"]
            continue
        if current is None:
            header.append(line)
        else:
            chunk.append(line if line.endswith("\n") else line + "\n")
    if current is None:
        header_text = "".join(header).rstrip() + "\n"
    else:
        sections[current] = "".join(chunk)
    return header_text, sections


def assemble(sections: dict[str, str], order: list[str]) -> str:
    parts = [HEADER.rstrip(), ""]
    for name in order:
        body = sections.get(name)
        if body:
            parts.append(body.rstrip())
            parts.append("")
    return "\n".join(parts).rstrip() + "\n"


def project_tags(repo: Path, head: str) -> list[str]:
    raw = git(repo, "tag", "--merged", head, "--sort=creatordate")
    found = []
    for name in raw.splitlines():
        if PROJECT_TAG.match(name) and "prerelease" not in name:
            found.append(name)
    return found


def previous_tag(repo: Path, rev: str) -> str:
    try:
        return git(repo, "describe", "--tags", "--abbrev=0", f"{rev}^").strip()
    except subprocess.CalledProcessError as exc:
        raise SystemExit(f"no previous tag before {rev}") from exc


def tag_date(repo: Path, rev: str) -> str:
    return git(repo, "log", "-1", "--format=%cs", rev).strip()


def differential_at(repo: Path, rev: str) -> str:
    text = show_file(repo, rev, "docs/release/DIFFERENTIAL_RECORD_ID")
    if not text:
        return "pending"
    token = text.strip().split()
    return token[0] if token else "pending"


def accumulate(repo: Path) -> str:
    head = git(repo, "rev-parse", "HEAD").strip()
    existing = ""
    path = repo / "docs" / "release" / "RELEASE_NOTES.md"
    if path.is_file():
        existing = path.read_text()
    _, kept = parse_notes(existing) if existing else ("", {})
    tags = project_tags(repo, head)
    order = ["Unreleased"]
    sections: dict[str, str] = {}
    for tag in reversed(tags):
        version = tag[1:] if tag.startswith("v") else tag
        order.append(version)
        if version in kept:
            sections[version] = kept[version]
            continue
        prev = previous_tag(repo, tag)
        lock = show_file(repo, tag, "Cargo.lock")
        sums_path = f"docs/release/{version}/SHA256SUMS"
        body = section_body(
            repo,
            f"{prev}..{tag}",
            prev,
            lock,
            advisories_at(repo, tag),
            show_file(repo, tag, sums_path),
            differential_at(repo, tag),
        )
        heading = f"## [{version}] - {tag_date(repo, tag)}\n\n"
        sections[version] = heading + body
    latest = tags[-1] if tags else ""
    unreleased_rev = f"{latest}..HEAD" if latest else "HEAD"
    unreleased = section_body(
        repo,
        unreleased_rev,
        latest,
        show_file(repo, "HEAD", "Cargo.lock"),
        advisories_at(repo, "HEAD"),
        None,
        differential_at(repo, "HEAD"),
    )
    sections["Unreleased"] = "## [Unreleased]\n\n" + unreleased
    return assemble(sections, order)


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
    if "dry run" in text or "person reviews" in text:
        print("generated notes still ask for a hand rewrite")
        return 1
    first = "## [0.2.0-beta.1] - 2026-11-15\n\nkept\n"
    notes = HEADER + "\n" + "## [Unreleased]\n\nold\n\n" + first
    _, parsed = parse_notes(notes)
    if parsed.get("0.2.0-beta.1") != first:
        print("published section was not kept intact")
        return 1
    parsed["Unreleased"] = "## [Unreleased]\n\nnew\n"
    again = assemble(parsed, ["Unreleased", "0.2.0-beta.1"])
    _, parsed_again = parse_notes(again)
    if parsed_again.get("0.2.0-beta.1") != first:
        print("assembling Unreleased rewrote a published section")
        return 1
    if "new" not in parsed_again["Unreleased"] or "old" in parsed_again["Unreleased"]:
        print("Unreleased was not replaced")
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
    parser.add_argument(
        "--accumulate",
        action="store_true",
        help="Rewrite Unreleased and add any missing project-tag section. Leave published sections as they are.",
    )
    parser.add_argument("--repo", type=Path, help="Repository whose tags and Cargo.lock are the source. Used with --accumulate.")
    args = parser.parse_args()
    if args.self_test:
        return self_test()
    if args.accumulate:
        repo = args.repo or Path.cwd()
        text = accumulate(repo)
        out = repo / "docs" / "release" / "RELEASE_NOTES.md"
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(text)
        print(out)
        return 0
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
