#!/usr/bin/env bash
# Feature set for Windows / Linux aarch64 cross-release builds.
# heed3 (bundled LMDB via lmdb-master3-sys) + redb/sled fallbacks; omits rocksdb/nix/libc
# and other native-heavy deps that complicate MinGW / cross sysroots.
set -euo pipefail

BLVM_PORTABLE_CROSS_FEATURES="blvm-node/heed3,blvm-node/sled,blvm-node/redb,blvm-node/production,blvm-node/protocol-verification,blvm-node/utxo-commitments"
export BLVM_PORTABLE_CROSS_FEATURES
