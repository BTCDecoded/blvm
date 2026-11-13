#!/bin/sh
# Build the minimal-audit-surface binary from the same source as blvm.
# The binary cargo produces is still named blvm. This script copies it.
set -eu
cd "$(dirname "$0")/../.."
cargo build --release --no-default-features --features minimal
mkdir -p target/release
cp -f target/release/blvm target/release/blvm-minimal
echo "target/release/blvm-minimal"
