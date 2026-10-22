#!/usr/bin/env bash
# Set [package] version in Cargo.toml (release job and GHCR image job share this,
# so the image binary reports the same version as the release binaries).
# Usage: scripts/set-cargo-version.sh <version> [Cargo.toml]
set -euo pipefail
VERSION="${1:?usage: set-cargo-version.sh <version> [Cargo.toml]}"
MANIFEST="${2:-Cargo.toml}"
awk -v ver="$VERSION" '
  BEGIN { in_package = 0 }
  /^\[package\]/ { in_package = 1; print; next }
  in_package && /^\[/ { in_package = 0 }
  in_package && /^version = / { print "version = \"" ver "\""; next }
  { print }
' "$MANIFEST" > "$MANIFEST.tmp" && mv "$MANIFEST.tmp" "$MANIFEST"
ACTUAL=$(grep -A 5 '^\[package\]' "$MANIFEST" | grep '^version = ' | head -1 | sed -E 's/^version = "([^"]+)".*/\1/')
[ "$ACTUAL" = "$VERSION" ] || { echo "❌ Version bump failed: $MANIFEST has '$ACTUAL', wanted '$VERSION'" >&2; exit 1; }
echo "✅ $MANIFEST version set to $VERSION"
