#!/usr/bin/env bash
# Start mainnet IBD using a release or installed blvm binary (no monorepo build).
#
# Usage:
#   ./scripts/start-ibd-mainnet.sh
#   BLVM_IBD_PEERS=192.168.1.10:8333 ./scripts/start-ibd-mainnet.sh
#   BLVM_BACKGROUND=1 ./scripts/start-ibd-mainnet.sh
#   ./scripts/start-ibd-mainnet.sh --init-config   # copy example to ~/.config/blvm/blvm.toml
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BLVM_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
EXAMPLE_CONFIG="$BLVM_ROOT/blvm-mainnet-ibd.toml.example"
DATA_DIR="${BLVM_DATA_DIR:-$HOME/.local/share/blvm-mainnet}"
CONFIG_FILE="${BLVM_CONFIG:-}"
LOG_FILE="${BLVM_IBD_LOG:-$DATA_DIR/ibd.log}"

if [ "${1:-}" = "--init-config" ]; then
    mkdir -p "$HOME/.config/blvm"
    dest="$HOME/.config/blvm/blvm.toml"
    if [ -f "$dest" ]; then
        echo "Config already exists: $dest (not overwriting)"
        exit 1
    fi
    cp "$EXAMPLE_CONFIG" "$dest"
    echo "Copied example config to $dest — edit persistent_peers / preferred_peers if you have a LAN Core."
    exit 0
fi

BINARY=""
if [ -n "${BLVM_BINARY:-}" ] && [ -x "$BLVM_BINARY" ]; then
    BINARY="$BLVM_BINARY"
elif [ -x "$BLVM_ROOT/blvm" ]; then
    BINARY="$BLVM_ROOT/blvm"
elif command -v blvm >/dev/null 2>&1; then
    BINARY="$(command -v blvm)"
else
    echo "blvm binary not found. Set BLVM_BINARY or run from extracted release tarball."
    exit 1
fi

if [ -z "$CONFIG_FILE" ]; then
    if [ -f "$HOME/.config/blvm/blvm.toml" ]; then
        CONFIG_FILE="$HOME/.config/blvm/blvm.toml"
    elif [ -f "$EXAMPLE_CONFIG" ]; then
        CONFIG_FILE="$EXAMPLE_CONFIG"
    else
        echo "No config found. Run: $0 --init-config"
        exit 1
    fi
fi

mkdir -p "$DATA_DIR"
if [ -d "$DATA_DIR/rocksdb" ]; then
    echo "Existing chain data found — resuming sync (keep the same data dir; do not wipe rocksdb/)."
fi
export RUST_LOG="${RUST_LOG:-blvm=info}"

echo "Binary:  $BINARY"
echo "Config:  $CONFIG_FILE"
echo "Data:    $DATA_DIR"
echo "Log:     $LOG_FILE"
[ -n "${BLVM_IBD_PEERS:-}" ] && echo "IBD peers: $BLVM_IBD_PEERS"

if [ -n "${BLVM_BACKGROUND:-}" ]; then
    IBD_ENV=()
    [ -n "${BLVM_IBD_PEERS:-}" ] && IBD_ENV+=(BLVM_IBD_PEERS="$BLVM_IBD_PEERS")
    [ -n "${BLVM_IBD_MODE:-}" ] && IBD_ENV+=(BLVM_IBD_MODE="$BLVM_IBD_MODE")
    nohup env "${IBD_ENV[@]}" \
        "$BINARY" \
        --config "$CONFIG_FILE" \
        --network mainnet \
        --data-dir "$DATA_DIR" \
        --verbose \
        >> "$LOG_FILE" 2>&1 &
    echo "PID: $! (background; tail -f $LOG_FILE)"
    disown 2>/dev/null || true
else
    IBD_ENV=()
    [ -n "${BLVM_IBD_PEERS:-}" ] && IBD_ENV+=(BLVM_IBD_PEERS="$BLVM_IBD_PEERS")
    [ -n "${BLVM_IBD_MODE:-}" ] && IBD_ENV+=(BLVM_IBD_MODE="$BLVM_IBD_MODE")
    env "${IBD_ENV[@]}" \
        "$BINARY" \
        --config "$CONFIG_FILE" \
        --network mainnet \
        --data-dir "$DATA_DIR" \
        --verbose \
        2>&1 | tee "$LOG_FILE"
fi
