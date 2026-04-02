#!/bin/bash
#
# Create Debian package for blvm binary (base or experimental variant).
#
# Usage: package-deb.sh <semver> <deb-arch e.g. amd64> [base|experimental]
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMONS_DIR="$(dirname "$SCRIPT_DIR")"
PARENT_DIR="$(dirname "$COMMONS_DIR")"
VERSION="${1:-0.1.0}"
ARCH="${2:-amd64}"
VARIANT="${3:-base}"

if [ "$VARIANT" != "base" ] && [ "$VARIANT" != "experimental" ]; then
  echo "ERROR: variant must be base or experimental" >&2
  exit 1
fi

if [ "$VARIANT" = "base" ]; then
  PACKAGE_NAME="blvm"
  DESC_TITLE="Bitcoin Commons BLVM node (production feature set)"
else
  PACKAGE_NAME="blvm-experimental"
  DESC_TITLE="Bitcoin Commons BLVM node (experimental features)"
fi

PACKAGE_DIR="${COMMONS_DIR}/artifacts/${PACKAGE_NAME}-${VERSION}-${ARCH}"
DEBIAN_DIR="${PACKAGE_DIR}/DEBIAN"
BINARY_DIR="${PACKAGE_DIR}/usr/bin"
BIN_DEST_NAME="blvm"

log_info() {
  echo "[INFO] $1"
}

log_success() {
  echo "[SUCCESS] $1"
}

log_info "Creating Debian package ${PACKAGE_NAME} ${VERSION} (${ARCH}, ${VARIANT})..."

rm -rf "${PACKAGE_DIR}"
mkdir -p "${DEBIAN_DIR}"
mkdir -p "${BINARY_DIR}"

if [ -f "${PARENT_DIR}/blvm/target/release/blvm" ]; then
  cp "${PARENT_DIR}/blvm/target/release/blvm" "${BINARY_DIR}/${BIN_DEST_NAME}"
  chmod +x "${BINARY_DIR}/${BIN_DEST_NAME}"
  log_success "Copied binary"
else
  echo "Error: Binary not found at ${PARENT_DIR}/blvm/target/release/blvm"
  exit 1
fi

cat > "${DEBIAN_DIR}/control" <<EOF
Package: ${PACKAGE_NAME}
Version: ${VERSION}
Section: net
Priority: optional
Architecture: ${ARCH}
Maintainer: Bitcoin Commons Team <team@btcdecoded.org>
Description: ${DESC_TITLE}
 Bitcoin Commons BLVM is a minimal Bitcoin node implementation using
 blvm-consensus for consensus. This package installs the \`blvm\` binary.
Homepage: https://btcdecoded.org
EOF

OUT_DEB="${COMMONS_DIR}/artifacts/${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"
log_info "Building .deb package..."
dpkg-deb --build "${PACKAGE_DIR}" "${OUT_DEB}"

log_success "Created: ${OUT_DEB}"
