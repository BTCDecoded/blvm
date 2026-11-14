#!/bin/sh
# Build the minimal binary from the same source as blvm.
# The binary cargo produces is still named blvm. This script copies it.
# --locked: the release job has already stripped [patch.crates-io] and selected
# the published blvm-node. A path crate that is not the locked version fails.
set -eu
cd "$(dirname "$0")/../.."
cargo build --release --locked --no-default-features --features minimal
dest="${CARGO_TARGET_DIR:-target}"
mkdir -p "${dest}/release"
cp -f "${dest}/release/blvm" "${dest}/release/blvm-minimal"
echo "${dest}/release/blvm-minimal"
