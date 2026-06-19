#!/usr/bin/env bash
# Run from the blvm repo root during the ci.yml release job, after the main
# Linux + Windows blvm binaries are built into CARGO_TARGET_DIR.
#
# Produces blvm/artifacts/ tarballs/zips + SHA256SUMS-blvm-* (base only),
# RELEASE_NOTES.md, version-suffixed archive names, and Arch-style .pkg.tar.gz.
# SHA256SUMS-linux-packages.txt is produced in ci.yml when staging (includes cargo deb/rpm).
#
# Env (required):
#   VERSION       — semver without v (e.g. 0.1.21)
#   VERSION_TAG   — tag with v (e.g. v0.1.21)
#   CARGO_TARGET_DIR — blvm release binary target (read-only here; governance builds
#                      use each sibling repo's own target/ via ci-build-governance-bins.sh)
#
# Env (optional):
#   GITHUB_WORKSPACE — blvm repo root (default: pwd)
#   CARGO_BUILD_JOBS — rustc parallelism for governance builds (default 4)
#
set -euo pipefail

BLVM_ROOT="${GITHUB_WORKSPACE:-$(pwd)}"
PARENT="$(dirname "$BLVM_ROOT")"
VERSION="${VERSION:?}"
VERSION_TAG="${VERSION_TAG:?}"
CARGO_TARGET_DIR="${CARGO_TARGET_DIR:?}"

LINUX_BIN="${CARGO_TARGET_DIR}/release/blvm"
WIN_BIN="${CARGO_TARGET_DIR}/x86_64-pc-windows-gnu/release/blvm.exe"
AARCH64_BIN="${CARGO_TARGET_DIR}/aarch64-unknown-linux-gnu/release/blvm"

log() { echo "[ci-release-extra] $*"; }

sync_main_blvm_binaries_to_repo_targets() {
  if [[ ! -f "$LINUX_BIN" ]]; then
    log "ERROR: Linux blvm binary missing: $LINUX_BIN"
    exit 1
  fi
  mkdir -p "${BLVM_ROOT}/target/release"
  cp -f "$LINUX_BIN" "${BLVM_ROOT}/target/release/blvm"
  chmod +x "${BLVM_ROOT}/target/release/blvm"
  if [[ -f "$WIN_BIN" ]]; then
    mkdir -p "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release"
    cp -f "$WIN_BIN" "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release/blvm.exe"
  else
    log "WARN: Windows blvm.exe missing: $WIN_BIN"
  fi
  if [[ ! -f "$AARCH64_BIN" ]]; then
    log "ERROR: aarch64 blvm required for release but missing: $AARCH64_BIN"
    exit 1
  fi
  mkdir -p "${BLVM_ROOT}/target/aarch64-unknown-linux-gnu/release"
  cp -f "$AARCH64_BIN" "${BLVM_ROOT}/target/aarch64-unknown-linux-gnu/release/blvm"
  chmod +x "${BLVM_ROOT}/target/aarch64-unknown-linux-gnu/release/blvm"
}

collect_base_variants() {
  (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh linux-x86_64 base)
  if [[ -f "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release/blvm.exe" ]]; then
    (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh windows-x86_64 base)
  else
    log "Skipping Windows base collect (no exe)"
  fi
  (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh linux-aarch64 base)
}

# --- main ---
cd "${BLVM_ROOT}"

chmod +x "${BLVM_ROOT}/scripts/collect-artifacts.sh" \
  "${BLVM_ROOT}/scripts/create-release.sh" \
  "${BLVM_ROOT}/scripts/package-arch.sh" \
  "${BLVM_ROOT}/scripts/package-deb.sh" \
  "${BLVM_ROOT}/scripts/package-rpm-from-deb.sh" \
  "${BLVM_ROOT}/scripts/ci-build-governance-bins.sh" 2>/dev/null || true

command -v zip >/dev/null 2>&1 || {
  log "ERROR: zip is required for collect-artifacts (Windows .zip)"
  exit 1
}

sync_main_blvm_binaries_to_repo_targets
"${BLVM_ROOT}/scripts/ci-build-governance-bins.sh" "$PARENT"
collect_base_variants

(cd "${BLVM_ROOT}" && ./scripts/create-release.sh "${VERSION_TAG}")

chmod +x "${BLVM_ROOT}/scripts/package-arch.sh" || true
(cd "${BLVM_ROOT}" && ./scripts/package-arch.sh "${VERSION}")

log "artifacts/:"
ls -la "${BLVM_ROOT}/artifacts/" 2>/dev/null || true
log "Done."
