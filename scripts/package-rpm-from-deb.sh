#!/bin/bash
# Build .rpm from an existing .deb using alien (works on Debian/Ubuntu hosts).
# Usage: package-rpm-from-deb.sh <semver> <base|experimental>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMONS_DIR="$(dirname "$SCRIPT_DIR")"
VERSION="${1:?}"
VARIANT="${2:-base}"

if [ "$VARIANT" = "base" ]; then
  DEB_NAME="blvm_${VERSION}_amd64.deb"
else
  DEB_NAME="blvm-experimental_${VERSION}_amd64.deb"
fi

DEB="${COMMONS_DIR}/artifacts/${DEB_NAME}"
if [ ! -f "$DEB" ]; then
  echo "[WARN] No $DEB — skip RPM (build .deb first)" >&2
  exit 0
fi

if ! command -v alien >/dev/null; then
  echo "[INFO] alien not installed; skipping RPM (apt install alien to enable)"
  exit 0
fi

log_info() { echo "[INFO] $1"; }

log_info "Converting ${DEB_NAME} to RPM with alien..."
cd "${COMMONS_DIR}/artifacts"
# alien writes RPM in cwd; may need fakeroot
if command -v fakeroot >/dev/null; then
  fakeroot alien --to-rpm --scripts "$DEB" || {
    echo "[WARN] alien failed (non-fatal)"
    exit 0
  }
else
  sudo alien --to-rpm --scripts "$DEB" || {
    echo "[WARN] alien failed (non-fatal)"
    exit 0
  }
fi

echo "[SUCCESS] RPM conversion attempted for ${VARIANT}"
