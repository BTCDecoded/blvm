#!/usr/bin/env bash
# Build a fully static blvm for Linux musl (x86_64 or aarch64) with cargo-zigbuild.
#
# A static musl binary runs unmodified on any Linux, including NixOS (no FHS
# loader path) and Alpine (musl libc). It is also the build that maintainers
# rebuild locally before signing a release (scripts/sign-release.sh), so it
# avoids host-dependent inputs. No CUDA kernels (BLVM_SECP256K1_NO_GPU=1), path
# prefixes remapped, toolchain pinned by rust-toolchain.toml, zig pinned below.
#
# Usage: ci-build-musl.sh <CARGO_TARGET_DIR> <VERSION> <x86_64|aarch64>
# Writes ./blvm-${VERSION}-linux-<arch>-musl in the current directory (blvm repo root).
#
# Env (optional):
#   ZIGLANG_VERSION        pip ziglang version (default 0.17.1)
#   CARGO_ZIGBUILD_VERSION cargo-zigbuild version (default 0.24.1)
set -euo pipefail

CARGO_TARGET_DIR="${1:?CARGO_TARGET_DIR required}"
VERSION="${2:?VERSION required}"
ARCH="${3:?arch required (x86_64 or aarch64)}"

case "$ARCH" in
  x86_64|aarch64) ;;
  *) echo "ERROR: unsupported arch '$ARCH' (x86_64 or aarch64)" >&2; exit 2 ;;
esac
TARGET="${ARCH}-unknown-linux-musl"

ZIGLANG_VERSION="${ZIGLANG_VERSION:-0.17.1}"
CARGO_ZIGBUILD_VERSION="${CARGO_ZIGBUILD_VERSION:-0.24.1}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

ensure_zig() {
  if python3 -m ziglang version >/dev/null 2>&1; then
    local have
    have="$(python3 -m ziglang version)"
    if [[ "$have" == "$ZIGLANG_VERSION" ]]; then
      return 0
    fi
    echo "zig ${have} found, pinning ${ZIGLANG_VERSION}"
  fi
  python3 -m pip install --user --quiet "ziglang==${ZIGLANG_VERSION}" 2>/dev/null \
    || python3 -m pip install --user --quiet --break-system-packages "ziglang==${ZIGLANG_VERSION}"
  python3 -m ziglang version
}

ensure_zigbuild() {
  if command -v cargo-zigbuild >/dev/null 2>&1 \
    && cargo-zigbuild --help >/dev/null 2>&1 \
    && cargo install --list 2>/dev/null | grep -q "^cargo-zigbuild v${CARGO_ZIGBUILD_VERSION}:"; then
    return 0
  fi
  # Install outside the repo so rust-toolchain.toml does not constrain the tool's MSRV.
  (cd /tmp && cargo install cargo-zigbuild --version "${CARGO_ZIGBUILD_VERSION}" --locked --quiet)
}

ensure_zig
ensure_zigbuild
rustup target add "$TARGET" >/dev/null 2>&1 || true

unset CC CXX CPP AR || true
export BLVM_SECP256K1_NO_GPU=1
SYSROOT="$(rustc --print sysroot)"
CARGO_HOME_DIR="$(cd "${CARGO_HOME:-$HOME/.cargo}" && pwd)"
mkdir -p "$CARGO_TARGET_DIR"
CARGO_TARGET_DIR="$(cd "$CARGO_TARGET_DIR" && pwd)"
# Every host-specific path is remapped so a maintainer's rebuild can match CI byte for byte.
# rustc uses the last matching --remap-path-prefix, so list the most specific paths last
# (the repo and target dir can sit under $HOME).
export RUSTFLAGS="-C target-feature=+crt-static --remap-path-prefix=${HOME}=/build --remap-path-prefix=${CARGO_HOME_DIR}=/cargo --remap-path-prefix=${SYSROOT}=/rustlib --remap-path-prefix=${REPO_ROOT}=/src --remap-path-prefix=${CARGO_TARGET_DIR}=/target"
export CARGO_TARGET_DIR
# Same remaps for C dependencies (jemalloc, lmdb, zstd, vendored OpenSSL) built by zig cc.
TARGET_ENV_KEY="${TARGET//-/_}"
export "CFLAGS_${TARGET_ENV_KEY}=-ffile-prefix-map=${HOME}=/build -ffile-prefix-map=${CARGO_HOME_DIR}=/cargo -ffile-prefix-map=${REPO_ROOT}=/src -ffile-prefix-map=${CARGO_TARGET_DIR}=/target"
export "CXXFLAGS_${TARGET_ENV_KEY}=-ffile-prefix-map=${HOME}=/build -ffile-prefix-map=${CARGO_HOME_DIR}=/cargo -ffile-prefix-map=${REPO_ROOT}=/src -ffile-prefix-map=${CARGO_TARGET_DIR}=/target"
export PKG_CONFIG_ALLOW_CROSS=1
# Static OpenSSL for iroh/native-tls (Cargo.toml vendors openssl for musl targets).
export OPENSSL_STATIC=1
export SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-$(git -C "$REPO_ROOT" log -1 --format=%ct 2>/dev/null || echo 0)}"

# shellcheck source=ci-portable-cross-features.sh
source "${SCRIPT_DIR}/ci-portable-cross-features.sh"

echo "=== ${TARGET} static build (zig ${ZIGLANG_VERSION}, cargo-zigbuild ${CARGO_ZIGBUILD_VERSION}) ==="
(cd "$REPO_ROOT" && cargo zigbuild --release --locked \
  --target "$TARGET" \
  --no-default-features \
  --features "${BLVM_LINUX_RELEASE_FEATURES}")

BIN="${CARGO_TARGET_DIR}/${TARGET}/release/blvm"
if [[ ! -f "$BIN" ]]; then
  echo "ERROR: ${TARGET} binary missing: $BIN" >&2
  exit 1
fi

OUT="./blvm-${VERSION}-linux-${ARCH}-musl"
cp -f "$BIN" "$OUT"
chmod +x "$OUT"

# The point of this artifact is that it needs nothing from the host.
if readelf -l "$OUT" | grep -q 'INTERP'; then
  echo "ERROR: ${OUT} has a dynamic loader (INTERP); expected a static binary" >&2
  exit 1
fi
if readelf -d "$OUT" 2>/dev/null | grep -q 'NEEDED'; then
  echo "ERROR: ${OUT} has NEEDED shared libraries; expected a static binary" >&2
  readelf -d "$OUT" | grep NEEDED >&2
  exit 1
fi
if strings "$OUT" | grep -q '/var/lib/github-runner'; then
  echo "ERROR: ${OUT} still names the runner home" >&2
  exit 1
fi
echo "✅ ${TARGET} binary: $(file "$OUT")"
sha256sum "$OUT"
