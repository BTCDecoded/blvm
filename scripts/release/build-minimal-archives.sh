#!/usr/bin/env bash
# Build the three minimal release archives into a private CARGO_TARGET_DIR.
# Linux x86_64 and Linux aarch64 are tar.gz. Windows x86_64 is zip.
# The default release binaries are left where the earlier job steps put them.
#
# Env (required):
#   VERSION_TAG
#   CARGO_TARGET_DIR  must not be the default release target directory
set -euo pipefail
cd "$(dirname "$0")/../.."

: "${VERSION_TAG:?VERSION_TAG is required}"
: "${CARGO_TARGET_DIR:?CARGO_TARGET_DIR is required}"
export CARGO_TARGET_DIR
export BLVM_SECP256K1_NO_GPU=1
unset CC CXX CPP AR || true

python3 - <<'PY'
import json, subprocess, sys
raw = subprocess.check_output(
    ["cargo", "metadata", "--format-version", "1", "--locked"],
)
meta = json.loads(raw)
nodes = [pkg for pkg in meta["packages"] if pkg["name"] == "blvm-node"]
if len(nodes) != 1:
    sys.exit(f"expected one blvm-node in the lock, found {len(nodes)}")
node = nodes[0]
if "minimal" not in node.get("features", {}):
    sys.exit(
        f"blvm-node {node.get('version')} has no feature minimal. "
        "Publish that feature and update Cargo.lock before this release."
    )
print(f"minimal feature present on blvm-node {node.get('version')}")
PY

sh scripts/release/check-minimal-deps.sh

pack() {
  sh scripts/release/package-minimal.sh "$1" "$2"
}

echo "=== minimal linux-x86_64 ==="
cargo build --release --locked --no-default-features --features minimal
linux_bin="${CARGO_TARGET_DIR}/release/blvm"
if readelf -d "$linux_bin" | grep -q 'libcudart'; then
  echo "minimal linux binary needs libcudart" >&2
  exit 1
fi
pack "$linux_bin" linux-x86_64

echo "=== minimal linux-aarch64 ==="
if ! command -v aarch64-linux-gnu-gcc >/dev/null 2>&1; then
  echo "aarch64-linux-gnu-gcc is required" >&2
  exit 1
fi
rustup target add aarch64-unknown-linux-gnu
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
export CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc
export CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++
export AR_aarch64_unknown_linux_gnu=aarch64-linux-gnu-ar
export PKG_CONFIG_ALLOW_CROSS=1
cargo build --release --locked --target aarch64-unknown-linux-gnu \
  --no-default-features --features minimal
arm_bin="${CARGO_TARGET_DIR}/aarch64-unknown-linux-gnu/release/blvm"
if readelf -d "$arm_bin" | grep -q 'libcudart'; then
  echo "minimal aarch64 binary needs libcudart" >&2
  exit 1
fi
pack "$arm_bin" linux-aarch64

echo "=== minimal windows-x86_64 ==="
if ! command -v x86_64-w64-mingw32-gcc >/dev/null 2>&1; then
  echo "x86_64-w64-mingw32-gcc is required" >&2
  exit 1
fi
rustup target add x86_64-pc-windows-gnu
export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc
export CC_x86_64_pc_windows_gnu=x86_64-w64-mingw32-gcc
export CXX_x86_64_pc_windows_gnu=x86_64-w64-mingw32-g++
cargo build --release --locked --target x86_64-pc-windows-gnu \
  --no-default-features --features minimal
pack "${CARGO_TARGET_DIR}/x86_64-pc-windows-gnu/release/blvm.exe" windows-x86_64

for f in \
  "artifacts/blvm-minimal-${VERSION_TAG}-linux-x86_64.tar.gz" \
  "artifacts/blvm-minimal-${VERSION_TAG}-linux-aarch64.tar.gz" \
  "artifacts/blvm-minimal-${VERSION_TAG}-windows-x86_64.zip"
do
  if [ ! -f "$f" ]; then
    echo "missing $f" >&2
    exit 1
  fi
  echo "packed $f"
done
