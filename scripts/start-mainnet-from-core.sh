#!/usr/bin/env bash
# Start mainnet BLVM against a synced Bitcoin Core datadir.
#
# - Migrates chainstate/index into <CORE_DATADIR>/blvm/ on first run (auto_migrate_core)
# - Reads block bodies from Core blocks/ in place (reuse_core_block_files)
# - Resumes catch-up IBD to network tip via run-loop [CATCH_UP] (see blvm-node)
#
# Usage:
#   ./scripts/start-mainnet-from-core.sh
#   BLVM_CORE_DATADIR=/home/josh/bitcoin-core-data BLVM_BACKGROUND=1 ./scripts/start-mainnet-from-core.sh
#   BLVM_SKIP_MIGRATE=1 ./scripts/start-mainnet-from-core.sh   # store already migrated
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BLVM_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CORE_DATADIR="${BLVM_CORE_DATADIR:-/home/josh/bitcoin-core-data}"
CONFIG_FILE="${BLVM_CONFIG:-$BLVM_ROOT/blvm-mainnet-core.toml.example}"
LOG_FILE="${BLVM_IBD_LOG:-$CORE_DATADIR/blvm-sync.log}"
BLVM_STORE="$CORE_DATADIR/blvm"
# BLVM RPC on :8334 so Core can keep :8332 when both are used locally.
RPC_ADDR="${BLVM_RPC_ADDR:-127.0.0.1:8334}"

BINARY=""
if [ -n "${BLVM_BINARY:-}" ] && [ -x "$BLVM_BINARY" ]; then
    BINARY="$BLVM_BINARY"
elif [ -x "$BLVM_ROOT/target/release/blvm" ]; then
    BINARY="$BLVM_ROOT/target/release/blvm"
elif [ -x "$BLVM_ROOT/blvm" ]; then
    BINARY="$BLVM_ROOT/blvm"
elif command -v blvm >/dev/null 2>&1; then
    BINARY="$(command -v blvm)"
else
    echo "blvm binary not found. Set BLVM_BINARY or cargo build --release in blvm/." >&2
    exit 1
fi

if [ ! -d "$CORE_DATADIR/chainstate" ] || [ ! -d "$CORE_DATADIR/blocks" ]; then
    echo "Not a Bitcoin Core datadir (need chainstate/ and blocks/): $CORE_DATADIR" >&2
    exit 1
fi

if pgrep -x bitcoind >/dev/null 2>&1; then
    echo "bitcoind is running — stop it before migrate/start against $CORE_DATADIR" >&2
    exit 1
fi

export RUST_LOG="${RUST_LOG:-blvm=info}"

echo "Binary:      $BINARY"
echo "Core datadir: $CORE_DATADIR"
echo "BLVM store:   $BLVM_STORE"
echo "Config:       $CONFIG_FILE"
echo "RPC:          $RPC_ADDR"
echo "Log:          $LOG_FILE"

if [ -z "${BLVM_SKIP_MIGRATE:-}" ] && [ ! -f "$BLVM_STORE/blvm_meta/migration.json" ]; then
    echo "Running one-time Core migrate (UTXO/index only; blocks stay in Core blocks/)..."
    mkdir -p "$BLVM_STORE"
    MIGRATE_ENV=()
    # Core blocks/index may be LevelDB+RocksDB mixed after unclean stop; chainstate migrate still works.
    MIGRATE_ENV+=(BLVM_SKIP_BLOCK_INDEX="${BLVM_SKIP_BLOCK_INDEX:-1}")
    env "${MIGRATE_ENV[@]}" "$BINARY" migrate core \
        --source "$CORE_DATADIR" \
        --destination "$BLVM_STORE" \
        --network mainnet \
        --verify
    echo "Migrate complete."
elif [ -f "$BLVM_STORE/blvm_meta/migration.json" ]; then
    echo "Using existing migrated store at $BLVM_STORE"
else
    echo "BLVM_SKIP_MIGRATE=1 and no migration marker — starting without migrate"
fi

run_blvm() {
    env "$@" \
        "$BINARY" \
        --config "$CONFIG_FILE" \
        --network mainnet \
        --data-dir "$CORE_DATADIR" \
        --rpc-addr "$RPC_ADDR" \
        --verbose
}

if [ -n "${BLVM_BACKGROUND:-}" ]; then
    IBD_ENV=()
    [ -n "${BLVM_IBD_PEERS:-}" ] && IBD_ENV+=(BLVM_IBD_PEERS="$BLVM_IBD_PEERS")
    [ -n "${BLVM_IBD_MODE:-}" ] && IBD_ENV+=(BLVM_IBD_MODE="$BLVM_IBD_MODE")
    nohup run_blvm "${IBD_ENV[@]}" >> "$LOG_FILE" 2>&1 &
    echo "PID: $! (background; tail -f $LOG_FILE)"
    disown 2>/dev/null || true
else
    IBD_ENV=()
    [ -n "${BLVM_IBD_PEERS:-}" ] && IBD_ENV+=(BLVM_IBD_PEERS="$BLVM_IBD_PEERS")
    [ -n "${BLVM_IBD_MODE:-}" ] && IBD_ENV+=(BLVM_IBD_MODE="$BLVM_IBD_MODE")
    run_blvm "${IBD_ENV[@]}" 2>&1 | tee "$LOG_FILE"
fi
