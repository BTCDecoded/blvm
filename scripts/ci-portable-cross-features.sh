#!/usr/bin/env bash
# Release feature sets: maximize parity across architectures; only omit what cannot link.
#
# Mirrors `blvm/Cargo.toml` `[features] default` (rocksdb stays optional, never in defaults).
# Linux: full default stack. Windows: same minus Unix-only nix/libc.
set -euo pipefail

BLVM_COMMON_FEATURES="heed3,redb,sled,production,utxo-commitments,blvm-node/protocol-verification,blvm-node/sysinfo,iroh,dandelion,sigop,governance,rest-api,bip70-http,compression"
export BLVM_COMMON_FEATURES

# Linux x86_64 native (`cargo build --release`) + Linux aarch64 cross.
BLVM_LINUX_RELEASE_FEATURES="${BLVM_COMMON_FEATURES},blvm-node/nix,blvm-node/libc"
export BLVM_LINUX_RELEASE_FEATURES

# Windows / MinGW: common only (no nix/libc deps on target).
BLVM_PORTABLE_CROSS_FEATURES="${BLVM_COMMON_FEATURES}"
export BLVM_PORTABLE_CROSS_FEATURES
