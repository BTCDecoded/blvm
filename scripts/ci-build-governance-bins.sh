#!/usr/bin/env bash
# Build governance release binaries into each sibling repo's own target/ tree.
#
# Must NOT inherit BLVM_RELEASE_TARGET_DIR / CARGO_TARGET_DIR from the main blvm
# release build. Sharing that directory causes librocksdb-sys rebuild races (missing
# rocksdb/*.cc) when blvm-sdk is built after blvm with default features (rocksdb).
#
# collect-artifacts.sh reads ${PARENT}/blvm-sdk/target/... and
# ${PARENT}/blvm-commons/target/..., not the release target dir.
#
# Usage: ci-build-governance-bins.sh <parent-dir>
#   parent-dir — directory containing blvm/, blvm-sdk/, blvm-commons/ checkouts
#
# Env (optional):
#   CARGO_BUILD_JOBS — parallel rustc jobs (default 4)
#
set -euo pipefail

PARENT="${1:?parent directory (contains blvm-sdk and blvm-commons)}"
SDK_DIR="${PARENT}/blvm-sdk"
COMMONS_DIR="${PARENT}/blvm-commons"
JOBS="${CARGO_BUILD_JOBS:-4}"

log() { echo "[ci-build-governance-bins] $*"; }

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
      log "Stripped [patch.crates-io] from ${dir#$PARENT/}/$f"
    done < <(find . -name Cargo.toml -not -path './target/*' -print0 2>/dev/null)
    while IFS= read -r -d '' f; do
      [ -f "$f" ] || continue
      grep -q '^\[patch\.crates-io\]' "$f" 2>/dev/null || continue
      awk '
        /^\[patch\.crates-io\]/ { skip = 1; next }
        skip && /^\[/ { skip = 0 }
        !skip { print }
      ' "$f" > "${f}.tmp" && mv "${f}.tmp" "$f"
      log "Stripped [patch.crates-io] from ${dir#$PARENT/}/$f"
    done < <(find . -path '*/.cargo/config.toml' -not -path './target/*' -print0 2>/dev/null)
  )
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

# Governance CLIs are pure crypto; --no-default-features skips blvm-node (and rocksdb).
SDK_RELEASE_BINS=(
  --bin blvm-keygen
  --bin blvm-sign
  --bin blvm-verify
)

COMMONS_RELEASE_BINS=(
  --bin blvm-commons
  --bin key-manager
  --bin test-content-hash
  --bin test-content-hash-standalone
)

run_cargo_in_repo() {
  local repo_dir="$1"
  shift
  (
    cd "$repo_dir"
    unset CARGO_TARGET_DIR
    export CARGO_BUILD_JOBS="$JOBS"
    unset CC CXX CPP AR || true
    cargo "$@"
  )
}

clone_sibling blvm-sdk
clone_sibling blvm-commons
strip_patches_in "$SDK_DIR"
strip_patches_in "$COMMONS_DIR"

log "Building blvm-sdk governance CLIs (Linux, isolated target/, no default features)…"
run_cargo_in_repo "$SDK_DIR" build --release --no-default-features "${SDK_RELEASE_BINS[@]}"

if rustup target list --installed | grep -q x86_64-pc-windows-gnu; then
  log "Building blvm-sdk governance CLIs (Windows cross)…"
  (
    cd "$SDK_DIR"
    unset CARGO_TARGET_DIR
    export CARGO_BUILD_JOBS="$JOBS"
    unset CC CXX CPP AR || true
    export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc
    export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc
    export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++
    export PKG_CONFIG_ALLOW_CROSS=1
    cargo build --release --no-default-features "${SDK_RELEASE_BINS[@]}" \
      --target x86_64-pc-windows-gnu
  )
else
  log "WARN: x86_64-pc-windows-gnu not installed; skip blvm-sdk Windows"
fi

log "Building blvm-commons release bins (Linux, isolated target/, best-effort)…"
run_cargo_in_repo "$COMMONS_DIR" build --release "${COMMONS_RELEASE_BINS[@]}" \
  || log "WARN: blvm-commons build failed (non-fatal)"

log "Done."
