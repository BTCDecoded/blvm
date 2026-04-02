#!/bin/bash
# Rebuild blvm / blvm-sdk / (optional) blvm-commons for a release variant so
# target/ trees match the variant before collect-artifacts or packaging.
# Usage: rebuild-for-release.sh <base|experimental> <workspace-root>
# Env: RELEASE_PLATFORM = linux | windows | both (default: both)
set -euo pipefail

VARIANT="${1:?}"
ROOT="${2:?}"
PLATFORM="${RELEASE_PLATFORM:-both}"

if [ "$VARIANT" != "base" ] && [ "$VARIANT" != "experimental" ]; then
  echo "Usage: $0 <base|experimental> <workspace-root>" >&2
  exit 1
fi

WANT_LINUX=false
WANT_WIN=false
case "$PLATFORM" in
  linux) WANT_LINUX=true ;;
  windows) WANT_WIN=true ;;
  both) WANT_LINUX=true; WANT_WIN=true ;;
  *) WANT_LINUX=true; WANT_WIN=true ;;
esac

export RUSTFLAGS="${RUSTFLAGS:--C debuginfo=0}"

echo "=== Rebuild ${VARIANT} variant (platform=${PLATFORM}) ==="

if [ "$VARIANT" = "base" ]; then
  if [ "$WANT_LINUX" = true ]; then
    echo "--- blvm (base, Linux) ---"
    cd "${ROOT}/blvm"
    cargo build --release --locked --features production
    echo "--- blvm-sdk (base, Linux) ---"
    cd "${ROOT}/blvm-sdk"
    cargo build --release --locked --bins
    echo "--- blvm-commons (base, best-effort) ---"
    cd "${ROOT}/blvm-commons"
    cargo build --release --locked --bins || echo "⚠️  blvm-commons base build skipped"
  fi
  if [ "$WANT_WIN" = true ] && rustup target list --installed | grep -q x86_64-pc-windows-gnu; then
    echo "--- blvm Windows (base) ---"
    cd "${ROOT}/blvm"
    cargo build --release --locked --target x86_64-pc-windows-gnu --features production
    echo "--- blvm-sdk Windows (base) ---"
    cd "${ROOT}/blvm-sdk"
    cargo build --release --locked --target x86_64-pc-windows-gnu --bins
  elif [ "$WANT_WIN" = true ]; then
    echo "ℹ️  x86_64-pc-windows-gnu not installed; skipping Windows base rebuild"
  fi
else
  if [ "$WANT_LINUX" = true ]; then
    echo "--- blvm (experimental, Linux) ---"
    cd "${ROOT}/blvm"
    cargo build --release --locked --features production,utxo-commitments,ctv,dandelion,stratum-v2,bip158,sigop,iroh
    echo "--- blvm-sdk (experimental, Linux) ---"
    cd "${ROOT}/blvm-sdk"
    cargo build --release --locked --bins --all-features
    echo "--- blvm-commons (experimental, best-effort) ---"
    cd "${ROOT}/blvm-commons"
    cargo build --release --locked --bins --all-features || echo "⚠️  blvm-commons experimental build skipped"
  fi
  if [ "$WANT_WIN" = true ] && rustup target list --installed | grep -q x86_64-pc-windows-gnu; then
    echo "--- blvm Windows (experimental) ---"
    cd "${ROOT}/blvm"
    cargo build --release --locked --target x86_64-pc-windows-gnu --features production,utxo-commitments,ctv,dandelion,stratum-v2,bip158,sigop,iroh
    echo "--- blvm-sdk Windows (experimental) ---"
    cd "${ROOT}/blvm-sdk"
    cargo build --release --locked --target x86_64-pc-windows-gnu --bins --all-features
  elif [ "$WANT_WIN" = true ]; then
    echo "ℹ️  x86_64-pc-windows-gnu not installed; skipping Windows experimental rebuild"
  fi
fi

echo "✅ Rebuild ${VARIANT} complete"
