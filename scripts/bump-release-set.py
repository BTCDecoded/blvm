#!/usr/bin/env python3
"""
Bump the coordinated release-set version in blvm/versions.toml and blvm/Cargo.toml.

The node binary does not use crates.io as the single source of truth for the ecosystem;
versions.toml is the manifest. This script keeps [package].version in Cargo.toml aligned.

Usage:
  bump-release-set.py [--dry-run] patch|minor|major

Exit codes: 0 on success, 1 on error.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("kind", choices=("patch", "minor", "major"), help="Semver bump kind")
    p.add_argument("--dry-run", action="store_true", help="Print changes only")
    return p.parse_args()


def bump_semver(current: str, kind: str) -> str:
    parts = current.split(".")
    if len(parts) < 3:
        raise ValueError(f"Expected X.Y.Z, got {current!r}")
    major, minor, patch = int(parts[0]), int(parts[1]), int(parts[2])
    if kind == "patch":
        patch += 1
    elif kind == "minor":
        minor += 1
        patch = 0
    else:
        major += 1
        minor = patch = 0
    return f"{major}.{minor}.{patch}"


def extract_blvm_version(text: str) -> str:
    for line in text.splitlines():
        line = line.strip()
        if not line.startswith("blvm ") and not line.startswith("blvm="):
            continue
        if "version" in line:
            m = re.search(r'version\s*=\s*"([^"]+)"', line)
            if m:
                return m.group(1)
    raise ValueError('Could not find blvm entry with version = "..." in versions.toml')


def replace_version_in_versions_toml(text: str, old: str, new: str) -> str:
    """Replace monorepo-wide semver old -> new in the [versions] block only (before [metadata])."""
    if "[metadata]" in text:
        head, tail = text.split("[metadata]", 1)
        head = head.replace(old, new)
        return head + "[metadata]" + tail
    return text.replace(old, new)


def update_cargo_toml_package_version(text: str, new_version: str) -> str:
    """Set [package] version = \"...\" in Cargo.toml."""
    return re.sub(
        r"(?m)^(\s*version\s*=\s*)\"[^\"]+\"",
        rf'\1"{new_version}"',
        text,
        count=1,
    )


def main() -> int:
    args = parse_args()
    repo_root = Path(__file__).resolve().parent.parent
    versions_path = repo_root / "versions.toml"
    cargo_path = repo_root / "Cargo.toml"

    if not versions_path.is_file():
        print(f"ERROR: {versions_path} not found", file=sys.stderr)
        return 1
    if not cargo_path.is_file():
        print(f"ERROR: {cargo_path} not found", file=sys.stderr)
        return 1

    versions_text = versions_path.read_text(encoding="utf-8")
    try:
        current = extract_blvm_version(versions_text)
    except ValueError as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return 1

    try:
        new_ver = bump_semver(current, args.kind)
    except ValueError as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return 1

    if current == new_ver:
        print("ERROR: bump produced same version", file=sys.stderr)
        return 1

    new_versions = replace_version_in_versions_toml(versions_text, current, new_ver)
    cargo_text = cargo_path.read_text(encoding="utf-8")
    new_cargo = update_cargo_toml_package_version(cargo_text, new_ver)

    # Sanity: blvm line should show new version
    if f'version = "{new_ver}"' not in new_versions.split("[metadata]")[0]:
        print("ERROR: versions.toml bump sanity check failed", file=sys.stderr)
        return 1

    print(f"Bump ({args.kind}): {current} -> {new_ver}")
    if args.dry_run:
        print("--- versions.toml (excerpt) ---")
        for line in new_versions.splitlines()[:25]:
            print(line)
        print("--- Cargo.toml [package].version ---")
        m = re.search(r"(?m)^version\s*=\s*\"[^\"]+\"", new_cargo)
        print(m.group(0) if m else "(not found)")
        return 0

    versions_path.write_text(new_versions, encoding="utf-8")
    cargo_path.write_text(new_cargo, encoding="utf-8")
    print(f"Wrote {versions_path} and {cargo_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
