#!/usr/bin/env bash
# Develop-branch nightly: same artifact naming as main release with VERSION=nightly / VERSION_TAG=nightly.
# Run from blvm repo root after Linux + Windows release builds in CARGO_TARGET_DIR.
#
# Env (required):
#   CARGO_TARGET_DIR — blvm release binary target (governance builds use sibling target/)
#   GITHUB_SHA         — commit being released (release notes only)
#
# Env (optional):
#   GITHUB_WORKSPACE   — blvm repo root (default: pwd)
#   CARGO_BUILD_JOBS   — rustc parallelism for governance builds (default 4)
#
set -euo pipefail

BLVM_ROOT="${GITHUB_WORKSPACE:-$(pwd)}"
PARENT="$(dirname "$BLVM_ROOT")"
CARGO_TARGET_DIR="${CARGO_TARGET_DIR:?}"
GITHUB_SHA="${GITHUB_SHA:?}"
VERSION="nightly"
VERSION_TAG="nightly"
RELEASE_DIR="${BLVM_ROOT}/release-artifacts"
ARTIFACTS_DIR="${BLVM_ROOT}/artifacts"

LINUX_BIN="${CARGO_TARGET_DIR}/release/blvm"
WIN_BIN="${CARGO_TARGET_DIR}/x86_64-pc-windows-gnu/release/blvm.exe"

log() { echo "[ci-nightly-artifacts] $*"; }

stage_release_artifacts() {
  # Same layout as ci.yml release job "Stage release artifacts and checksums"
  mkdir -p "${RELEASE_DIR}"
  rm -rf "${RELEASE_DIR:?}"/* 2>/dev/null || true

  for f in \
    "blvm-${VERSION}-linux-x86_64" \
    "blvm-${VERSION}-windows-x86_64.exe" \
    "blvm_${VERSION}_amd64.deb" \
    "blvm-${VERSION}-1.x86_64.rpm"; do
    if [[ -f "${BLVM_ROOT}/${f}" ]]; then
      cp -f "${BLVM_ROOT}/${f}" "${RELEASE_DIR}/"
    fi
  done

  if [[ -d "${ARTIFACTS_DIR}" ]]; then
    cp -a "${ARTIFACTS_DIR}/." "${RELEASE_DIR}/"
  fi

  (
    cd "${RELEASE_DIR}"
    : > SHA256SUMS-linux-packages.txt
    shopt -s nullglob
    for f in ./*.deb ./*.rpm ./*.pkg.tar.gz; do
      sha256sum "$f" >> SHA256SUMS-linux-packages.txt || true
    done
  )
  ( cd "${RELEASE_DIR}" && sha256sum * | LC_ALL=C sort > "${BLVM_ROOT}/checksums.sha256" )
  cp "${BLVM_ROOT}/checksums.sha256" "${RELEASE_DIR}/"

  log "Staged (same names as stable release with version=nightly):"
  ls -lh "${RELEASE_DIR}/"
}

# --- main ---
cd "${BLVM_ROOT}"

if [[ ! -f "$LINUX_BIN" ]]; then
  log "ERROR: Linux binary missing: $LINUX_BIN"
  exit 1
fi

command -v zip >/dev/null 2>&1 || { log "ERROR: zip required for Windows archives"; exit 1; }

mkdir -p "${BLVM_ROOT}/target/release" "${ARTIFACTS_DIR}"
cp -f "$LINUX_BIN" "${BLVM_ROOT}/target/release/blvm"
chmod +x "${BLVM_ROOT}/target/release/blvm"

cp -f "$LINUX_BIN" "${BLVM_ROOT}/blvm-${VERSION}-linux-x86_64"
chmod +x "${BLVM_ROOT}/blvm-${VERSION}-linux-x86_64"

if [[ -f "$WIN_BIN" ]]; then
  cp -f "$WIN_BIN" "${BLVM_ROOT}/blvm-${VERSION}-windows-x86_64.exe"
fi

chmod +x "${BLVM_ROOT}/scripts/collect-artifacts.sh" \
  "${BLVM_ROOT}/scripts/create-release.sh" \
  "${BLVM_ROOT}/scripts/package-arch.sh" \
  "${BLVM_ROOT}/scripts/package-deb.sh" \
  "${BLVM_ROOT}/scripts/package-rpm-from-deb.sh" \
  "${BLVM_ROOT}/scripts/ci-build-governance-bins.sh" 2>/dev/null || true

"${BLVM_ROOT}/scripts/ci-build-governance-bins.sh" "$PARENT"
"${BLVM_ROOT}/scripts/collect-artifacts.sh" linux-x86_64 base

if [[ -f "$WIN_BIN" ]]; then
  mkdir -p "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release"
  cp -f "$WIN_BIN" "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release/blvm.exe"
  "${BLVM_ROOT}/scripts/collect-artifacts.sh" windows-x86_64 base
else
  log "WARN: Windows blvm.exe missing — Linux-only nightly"
fi

export PATH="${HOME}/.cargo/bin:${PATH}"
"${BLVM_ROOT}/scripts/package-deb.sh" "${VERSION}" amd64 base
"${BLVM_ROOT}/scripts/package-arch.sh" "${VERSION}"
"${BLVM_ROOT}/scripts/package-rpm-from-deb.sh" "${VERSION}" base || log "WARN: alien rpm skipped"

if command -v cargo-deb >/dev/null 2>&1; then
  cargo deb --no-build 2>&1 || log "WARN: cargo deb failed"
  deb=$(find target/debian -name '*.deb' 2>/dev/null | head -1)
  if [[ -n "$deb" ]]; then
    cp -f "$deb" "${BLVM_ROOT}/blvm_${VERSION}_amd64.deb"
    cp -f "$deb" "${ARTIFACTS_DIR}/blvm_${VERSION}_amd64.deb"
  fi
fi
if command -v cargo-generate-rpm >/dev/null 2>&1; then
  cargo generate-rpm --target-dir "${CARGO_TARGET_DIR}" 2>&1 || log "WARN: cargo generate-rpm failed"
  rpm=$(find "${CARGO_TARGET_DIR}" -name '*.rpm' 2>/dev/null | head -1)
  if [[ -n "$rpm" ]]; then
    cp -f "$rpm" "${BLVM_ROOT}/blvm-${VERSION}-1.x86_64.rpm"
    cp -f "$rpm" "${ARTIFACTS_DIR}/blvm-${VERSION}-1.x86_64.rpm"
  fi
fi

"${BLVM_ROOT}/scripts/create-release.sh" "${VERSION_TAG}"

stage_release_artifacts
log "Done (commit ${GITHUB_SHA})."
