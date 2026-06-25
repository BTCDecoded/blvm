#!/usr/bin/env bash
# Cross-compile blvm for aarch64-unknown-linux-gnu (Raspberry Pi 4/5, 64-bit OS).
# Uses Linux release features (common + nix/libc); same parity target as x86_64 native.
# OpenSSL: Cargo.toml enables vendored openssl for linux/aarch64 (iroh native-tls).
#
# Usage: ci-build-aarch64.sh <CARGO_TARGET_DIR> <VERSION>
# Writes ./blvm-${VERSION}-linux-aarch64 in the current directory (blvm repo root).
set -euo pipefail

CARGO_TARGET_DIR="${1:?CARGO_TARGET_DIR required}"
VERSION="${2:?VERSION required}"

if ! command -v aarch64-linux-gnu-gcc >/dev/null 2>&1; then
  echo "ERROR: aarch64-linux-gnu-gcc not found (install gcc-aarch64-linux-gnu or aarch64-linux-gnu-gcc)" >&2
  exit 1
fi

rustup target add aarch64-unknown-linux-gnu >/dev/null 2>&1 || true

unset CC CXX CPP AR || true
export CARGO_TARGET_DIR
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
export CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc
export CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++
export AR_aarch64_unknown_linux_gnu=aarch64-linux-gnu-ar
export PKG_CONFIG_ALLOW_CROSS=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ci-portable-cross-features.sh
source "${SCRIPT_DIR}/ci-portable-cross-features.sh"

echo "=== aarch64 cross-compile (Raspberry Pi 64-bit; Linux release feature set) ==="
cargo build --release \
  --target aarch64-unknown-linux-gnu \
  --no-default-features \
  --features "${BLVM_LINUX_RELEASE_FEATURES}"

BIN="${CARGO_TARGET_DIR}/aarch64-unknown-linux-gnu/release/blvm"
if [[ ! -f "$BIN" ]]; then
  echo "ERROR: aarch64 binary missing: $BIN" >&2
  exit 1
fi

OUT="./blvm-${VERSION}-linux-aarch64"
cp -f "$BIN" "$OUT"
chmod +x "$OUT"
echo "✅ aarch64 binary: $(file "$OUT")"
echo "✅ $(ls -lh "$OUT")"
