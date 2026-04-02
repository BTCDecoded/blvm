#!/bin/bash
# Build Linux distribution packages on the self-hosted worker (.deb, Arch-style .pkg.tar.gz, optional .rpm via alien).
# Expects sibling repos already checked out under workspace root (same as release workflow).
# Usage: package-linux-releases.sh <semver-without-v-prefix> <workspace-root>
set -euo pipefail

VERSION="${1:?}"
ROOT="${2:?}"

export RUSTFLAGS="${RUSTFLAGS:--C debuginfo=0}"
export RELEASE_PLATFORM=linux

echo "=== Linux packages for blvm ${VERSION} ==="

chmod +x "${ROOT}/blvm/scripts/rebuild-for-release.sh" 2>/dev/null || true

echo "--- Rebuild base (Linux) ---
"
"${ROOT}/blvm/scripts/rebuild-for-release.sh" base "${ROOT}"

"${ROOT}/blvm/scripts/package-deb.sh" "${VERSION}" amd64 base
"${ROOT}/blvm/scripts/package-arch.sh" "${VERSION}"
"${ROOT}/blvm/scripts/package-rpm-from-deb.sh" "${VERSION}" base

echo "--- Rebuild experimental (Linux) ---
"
"${ROOT}/blvm/scripts/rebuild-for-release.sh" experimental "${ROOT}"

"${ROOT}/blvm/scripts/package-deb.sh" "${VERSION}" amd64 experimental
"${ROOT}/blvm/scripts/package-rpm-from-deb.sh" "${VERSION}" experimental

ART="${ROOT}/blvm/artifacts"
if [ -d "$ART" ]; then
  (
    cd "$ART"
    : > SHA256SUMS-linux-packages.txt
    shopt -s nullglob
    for f in ./*.deb ./*.rpm ./*.pkg.tar.gz; do
      sha256sum "$f" >> SHA256SUMS-linux-packages.txt || true
    done
  )
  echo "✅ Checksums: ${ART}/SHA256SUMS-linux-packages.txt"
fi

echo "✅ Linux packaging complete"
