#!/bin/bash
#
# Create Arch Linux package for blvm binary
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMONS_DIR="$(dirname "$SCRIPT_DIR")"
PARENT_DIR="$(dirname "$COMMONS_DIR")"
VERSION="${1:-0.1.0}"
ARCH="${2:-x86_64}"
BIN_PATH="${3:-${PARENT_DIR}/blvm/target/release/blvm}"

PACKAGE_NAME="blvm"
PKGBUILD_DIR="${COMMONS_DIR}/artifacts/${PACKAGE_NAME}-arch-${ARCH}"
PKG_DIR="${PKGBUILD_DIR}/pkg"

log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[SUCCESS] $1"
}

log_info "Creating Arch Linux package for ${PACKAGE_NAME} ${VERSION}..."

# Create package structure
mkdir -p "${PKGBUILD_DIR}"
mkdir -p "${PKG_DIR}/${PACKAGE_NAME}/usr/bin"

# Copy binary
if [ -f "${BIN_PATH}" ]; then
    cp "${BIN_PATH}" "${PKG_DIR}/${PACKAGE_NAME}/usr/bin/blvm"
    chmod +x "${PKG_DIR}/${PACKAGE_NAME}/usr/bin/blvm"
    log_success "Copied binary"
else
    echo "Error: Binary not found at ${BIN_PATH}"
    exit 1
fi

# Same three files as cargo-deb. The tarball does not enable the unit.
UNIT_SRC="${COMMONS_DIR}/contrib/init"
PKG_ROOT="${PKG_DIR}/${PACKAGE_NAME}"
install_unit() {
    local src="$1" dest="$2"
    if [ ! -f "${UNIT_SRC}/${src}" ]; then
        echo "Error: missing ${UNIT_SRC}/${src}" >&2
        exit 1
    fi
    mkdir -p "${PKG_ROOT}/$(dirname "${dest}")"
    cp "${UNIT_SRC}/${src}" "${PKG_ROOT}/${dest}"
    chmod 644 "${PKG_ROOT}/${dest}"
    cp "${UNIT_SRC}/${src}" "${PKGBUILD_DIR}/${src}"
}
install_unit blvm.service usr/lib/systemd/system/blvm.service
install_unit blvm.sysusers usr/lib/sysusers.d/blvm.conf
install_unit blvm.toml.example usr/share/doc/blvm/blvm.toml.example
log_success "Installed blvm.service, sysusers, and the example TOML"

# Create PKGBUILD
cat > "${PKGBUILD_DIR}/PKGBUILD" <<EOF
# Maintainer: Bitcoin Commons Team <team@btcdecoded.org>
pkgname=${PACKAGE_NAME}
pkgver=${VERSION}
pkgrel=1
pkgdesc="Bitcoin Commons BLVM - Bitcoin node"
arch=('${ARCH}')
url="https://btcdecoded.org"
license=('MIT')
source=("blvm" "blvm.service" "blvm.sysusers" "blvm.toml.example")
sha256sums=('SKIP' 'SKIP' 'SKIP' 'SKIP')

package() {
    install -Dm755 "\${srcdir}/blvm" "\${pkgdir}/usr/bin/blvm"
    install -Dm644 "\${srcdir}/blvm.service" "\${pkgdir}/usr/lib/systemd/system/blvm.service"
    install -Dm644 "\${srcdir}/blvm.sysusers" "\${pkgdir}/usr/lib/sysusers.d/blvm.conf"
    install -Dm644 "\${srcdir}/blvm.toml.example" "\${pkgdir}/usr/share/doc/blvm/blvm.toml.example"
}
EOF

# Arch-style payload tarball (gzip); suitable for manual pacman -U or mirrors
log_info "Building Arch-style .pkg.tar.gz package..."
cd "${PKGBUILD_DIR}"
OUT="${COMMONS_DIR}/artifacts/${PACKAGE_NAME}-${VERSION}-${ARCH}.pkg.tar.gz"
tar -czf "${OUT}" -C "${PKG_DIR}/${PACKAGE_NAME}" .

log_success "Created: ${OUT}"

