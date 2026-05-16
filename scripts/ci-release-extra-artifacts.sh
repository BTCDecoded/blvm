#!/usr/bin/env bash
# Run from the blvm repo root during the ci.yml release job, after the main
# Linux + Windows blvm binaries are built into CARGO_TARGET_DIR.
#
# Produces blvm/artifacts/ tarballs/zips + SHA256SUMS-blvm-* (base + experimental),
# RELEASE_NOTES.md, version-suffixed archive names, experimental .deb (scripted),
# experimental .rpm via alien when available, and Arch-style .pkg.tar.gz.
# SHA256SUMS-linux-packages.txt is produced in ci.yml when staging (includes cargo deb/rpm).
#
# Env (required):
#   VERSION       — semver without v (e.g. 0.1.21)
#   VERSION_TAG   — tag with v (e.g. v0.1.21)
#   CARGO_TARGET_DIR — same path ci.yml uses for cargo build
#
# Env (optional):
#   GITHUB_WORKSPACE — blvm repo root (default: pwd)
#
set -euo pipefail

BLVM_ROOT="${GITHUB_WORKSPACE:-$(pwd)}"
PARENT="$(dirname "$BLVM_ROOT")"
VERSION="${VERSION:?}"
VERSION_TAG="${VERSION_TAG:?}"
CARGO_TARGET_DIR="${CARGO_TARGET_DIR:?}"

LINUX_BIN="${CARGO_TARGET_DIR}/release/blvm"
WIN_BIN="${CARGO_TARGET_DIR}/x86_64-pc-windows-gnu/release/blvm.exe"

log() { echo "[ci-release-extra] $*"; }

strip_patches_in() {
  local dir="$1"
  [ -d "$dir" ] || return 0
  (
    cd "$dir" || exit 0
    while IFS= read -r -d '' f; do
      grep -q '^\[patch\.crates-io\]' "$f" 2>/dev/null || continue
      awk '
        /^\[patch\.crates-io\]/ { skip = 1; next }
        skip && /^\[/ { skip = 0 }
        !skip { print }
      ' "$f" > "${f}.tmp" && mv "${f}.tmp" "$f"
      log "Stripped [patch.crates-io] from $f"
    done < <(find . -name Cargo.toml -not -path './target/*' -print0 2>/dev/null)
    while IFS= read -r -d '' f; do
      [ -f "$f" ] || continue
      grep -q '^\[patch\.crates-io\]' "$f" 2>/dev/null || continue
      awk '
        /^\[patch\.crates-io\]/ { skip = 1; next }
        skip && /^\[/ { skip = 0 }
        !skip { print }
      ' "$f" > "${f}.tmp" && mv "${f}.tmp" "$f"
      log "Stripped [patch.crates-io] from $f"
    done < <(find . -path '*/.cargo/config.toml' -not -path './target/*' -print0 2>/dev/null)
  )
}

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
}

clone_sibling() {
  local repo="$1"
  local dest="${PARENT}/${repo}"
  if [[ -d "${dest}/.git" ]]; then
    log "Using existing clone: ${dest}"
    return 0
  fi
  log "Cloning ${repo}…"
  git clone --depth 1 "https://github.com/BTCDecoded/${repo}.git" "${dest}"
}

build_sdk_and_commons_base() {
  unset CC CXX CPP AR || true
  clone_sibling blvm-sdk
  clone_sibling blvm-commons
  strip_patches_in "${PARENT}/blvm-sdk"
  strip_patches_in "${PARENT}/blvm-commons"

  log "Building blvm-sdk (Linux)…"
  (cd "${PARENT}/blvm-sdk" && cargo build --release --bins)

  if rustup target list --installed | grep -q x86_64-pc-windows-gnu; then
    log "Building blvm-sdk (Windows)…"
    (
      cd "${PARENT}/blvm-sdk"
      export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc
      export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc
      export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++
      export PKG_CONFIG_ALLOW_CROSS=1
      cargo build --release --bins --target x86_64-pc-windows-gnu
    )
  else
    log "WARN: x86_64-pc-windows-gnu not installed; skip blvm-sdk Windows"
  fi

  log "Building blvm-commons (Linux, best-effort)…"
  (cd "${PARENT}/blvm-commons" && cargo build --release --bins) || log "WARN: blvm-commons build failed (non-fatal)"
}

collect_base_variants() {
  (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh linux-x86_64 base)
  if [[ -f "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release/blvm.exe" ]]; then
    (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh windows-x86_64 base)
  else
    log "Skipping Windows base collect (no exe)"
  fi
}

experimental_linux_features="production,utxo-commitments,ctv,dandelion,stratum-v2,bip158,sigop,iroh"

# Match ci.yml Windows cross-compile: no default features + portable node backends,
# plus experimental flags enabled on the blvm crate.
win_exp_features="blvm-node/sled,blvm-node/redb,blvm-node/production,blvm-node/protocol-verification,blvm-node/utxo-commitments,utxo-commitments,ctv,dandelion,stratum-v2,bip158,sigop,iroh"

build_experimental_and_collect() {
  unset CC CXX CPP AR || true
  log "Building blvm experimental (Linux)…"
  (cd "${BLVM_ROOT}" && cargo build --release --features "${experimental_linux_features}")

  log "Building blvm-sdk experimental (Linux)…"
  (cd "${PARENT}/blvm-sdk" && cargo build --release --bins --all-features)

  if rustup target list --installed | grep -q x86_64-pc-windows-gnu; then
    log "Building blvm experimental (Windows, best-effort)…"
    (
      cd "${BLVM_ROOT}"
      export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc
      export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc
      export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++
      export PKG_CONFIG_ALLOW_CROSS=1
      cargo build --release --target x86_64-pc-windows-gnu \
        --no-default-features \
        --features "${win_exp_features}" \
        || log "WARN: experimental Windows blvm failed"
    )
    log "Building blvm-sdk experimental (Windows, best-effort)…"
    (
      cd "${PARENT}/blvm-sdk"
      export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc
      export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc
      export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++
      export PKG_CONFIG_ALLOW_CROSS=1
      cargo build --release --bins --all-features --target x86_64-pc-windows-gnu \
        || log "WARN: experimental Windows blvm-sdk failed"
    )
  fi

  (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh linux-x86_64 experimental)
  if [[ -f "${BLVM_ROOT}/target/x86_64-pc-windows-gnu/release/blvm.exe" ]]; then
    (cd "${BLVM_ROOT}" && ./scripts/collect-artifacts.sh windows-x86_64 experimental)
  else
    log "Skipping Windows experimental collect (no exe)"
  fi
}

package_experimental_deb_and_rpm() {
  chmod +x "${BLVM_ROOT}/scripts/package-deb.sh" "${BLVM_ROOT}/scripts/package-rpm-from-deb.sh" 2>/dev/null || true
  (cd "${BLVM_ROOT}" && ./scripts/package-deb.sh "${VERSION}" amd64 experimental)
  (cd "${BLVM_ROOT}" && ./scripts/package-rpm-from-deb.sh "${VERSION}" experimental) || true
}

# SHA256SUMS-linux-packages.txt is written in ci.yml after cargo deb/rpm so it includes
# base + experimental packages and the Arch pkg copied into the release bundle.

# --- main ---
cd "${BLVM_ROOT}"

chmod +x "${BLVM_ROOT}/scripts/collect-artifacts.sh" \
  "${BLVM_ROOT}/scripts/create-release.sh" \
  "${BLVM_ROOT}/scripts/package-arch.sh" \
  "${BLVM_ROOT}/scripts/package-deb.sh" \
  "${BLVM_ROOT}/scripts/package-rpm-from-deb.sh" 2>/dev/null || true

command -v zip >/dev/null 2>&1 || {
  log "ERROR: zip is required for collect-artifacts (Windows .zip)"
  exit 1
}

sync_main_blvm_binaries_to_repo_targets
build_sdk_and_commons_base
collect_base_variants

cp -f "${BLVM_ROOT}/target/release/blvm" /tmp/blvm-ci-release-base-stash.bin

build_experimental_and_collect

if [[ -f "${BLVM_ROOT}/target/release/blvm" ]]; then
  package_experimental_deb_and_rpm
fi

cp -f /tmp/blvm-ci-release-base-stash.bin "${BLVM_ROOT}/target/release/blvm"
chmod +x "${BLVM_ROOT}/target/release/blvm"

(cd "${BLVM_ROOT}" && ./scripts/create-release.sh "${VERSION_TAG}")

chmod +x "${BLVM_ROOT}/scripts/package-arch.sh" || true
(cd "${BLVM_ROOT}" && ./scripts/package-arch.sh "${VERSION}")

log "artifacts/:"
ls -la "${BLVM_ROOT}/artifacts/" 2>/dev/null || true
log "Done."
