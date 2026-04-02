#!/bin/bash
# Wrapper for bump-release-set.py (versions.toml + blvm/Cargo.toml).
# Usage: bump-release-set.sh [--dry-run] patch|minor|major
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
exec python3 "${SCRIPT_DIR}/bump-release-set.py" "$@"
