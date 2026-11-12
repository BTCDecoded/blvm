#!/usr/bin/env bash
# Set the blvm package version in Cargo.toml and the root entry of Cargo.lock.
#
# The release job bumps the version before building, and the tag points at the
# commit before that bump. Anyone rebuilding a release from its tag (for example
# scripts/sign-release.sh) must apply the same bump, or the version string baked
# into the binary differs and the hash will not match. Keep this the only place
# that edits the version so CI and local rebuilds cannot drift.
#
# Usage: release-bump-version.sh <VERSION>   (run from the blvm repo root)
set -euo pipefail

VERSION="${1:?VERSION required (e.g. 0.1.42)}"
if ! echo "$VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "❌ Invalid version: ${VERSION}" >&2
  exit 1
fi

awk -v ver="$VERSION" '
  BEGIN { in_package = 0 }
  /^\[package\]/ { in_package = 1; print; next }
  in_package && /^\[/ { in_package = 0 }
  in_package && /^version = / { print "version = \"" ver "\""; next }
  { print }
' Cargo.toml > Cargo.toml.tmp && mv Cargo.toml.tmp Cargo.toml
ACTUAL=$(grep -A 5 '^\[package\]' Cargo.toml | grep '^version = ' | head -1 | sed -E 's/^version = "([^"]+)".*/\1/')
[ "$ACTUAL" = "$VERSION" ] || { echo "❌ Version bump failed" >&2; exit 1; }

# The release builds use --locked, so the root package entry in
# Cargo.lock must carry the bumped version too.
awk -v ver="$VERSION" '
  /^name = "blvm"$/ { print; is_root = 1; next }
  is_root && /^version = / { print "version = \"" ver "\""; is_root = 0; next }
  { is_root = 0; print }
' Cargo.lock > Cargo.lock.tmp && mv Cargo.lock.tmp Cargo.lock
grep -A 1 '^name = "blvm"$' Cargo.lock | grep -qx "version = \"${VERSION}\"" \
  || { echo "❌ Cargo.lock root version bump failed" >&2; exit 1; }
echo "✅ Cargo.toml and Cargo.lock bumped to ${VERSION}"
