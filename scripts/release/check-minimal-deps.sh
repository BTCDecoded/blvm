#!/bin/sh
# Dependency boundary for the minimal feature set.
# Fails if a forbidden crate appears in `cargo tree`, and fails if the
# committed direct-dependency allowlist does not match the tree.
set -eu
cd "$(dirname "$0")/../.."
tree="$(mktemp)"
cargo tree --prefix none --no-default-features --features minimal --all-targets > "$tree"
forbidden='blvm-sdk iroh blvm-stratum-v2 blvm-index blvm-fees blvm-wallet-index blvm-monitor blvm-miningos blvm-governance'
for name in $forbidden; do
  if grep -F " $name " "$tree" >/dev/null || grep -E "^${name} " "$tree" >/dev/null; then
    echo "minimal build pulled in excluded crate: $name"
    rm -f "$tree"
    exit 1
  fi
done
allowlist="release/minimal-direct-deps.txt"
if [ ! -s "$allowlist" ]; then
  echo "missing $allowlist. Generate it with BLVM_WRITE_ALLOWLIST=1 after reviewing the tree."
  rm -f "$tree"
  exit 1
fi
# Direct dependencies are the lines cargo tree prints with a single crate name
# at depth 0. `cargo tree -e normal --depth 1` is the reviewed surface.
direct="$(mktemp)"
cargo tree --prefix none --depth 1 --no-default-features --features minimal \
  | awk 'NR>1 {print $1}' | sort -u > "$direct"
if ! diff -u "$allowlist" "$direct"; then
  echo "minimal direct dependencies differ from $allowlist"
  rm -f "$tree" "$direct"
  exit 1
fi
rm -f "$tree" "$direct"
echo "minimal dependency boundary matches $allowlist"
