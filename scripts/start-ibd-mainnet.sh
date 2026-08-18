#!/usr/bin/env bash
# Start mainnet IBD using a release or installed blvm binary.
#
# Usage:
#   ./scripts/start-ibd-mainnet.sh                     # use most recent binary
#   ./scripts/start-ibd-mainnet.sh --build             # cargo build --release first, then run
#   ./scripts/start-ibd-mainnet.sh --restart           # gracefully stop running blvm then start
#   ./scripts/start-ibd-mainnet.sh --build --restart   # build + restart
#   BLVM_IBD_PEERS=192.168.1.10:8333 ./scripts/start-ibd-mainnet.sh
#   BLVM_BACKGROUND=1 ./scripts/start-ibd-mainnet.sh
#   ./scripts/start-ibd-mainnet.sh --init-config       # copy example to ~/.config/blvm/blvm.toml
#
# Binary resolution order (first match wins):
#   1. $BLVM_BINARY env var (explicit override)
#   2. target/release/blvm  (cargo build --release output — always fresh if it exists)
#   3. $BLVM_ROOT/blvm      (static installed binary — legacy fallback)
#   4. command -v blvm      (PATH lookup)
#
# Log rotation: the previous ibd.log is renamed to ibd-YYYYMMDD-HHMMSS.log before each run.
# Old rotated logs beyond BLVM_LOG_KEEP (default 5) are pruned automatically.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BLVM_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
EXAMPLE_CONFIG="$BLVM_ROOT/blvm-mainnet-ibd.toml.example"
DATA_DIR="${BLVM_DATA_DIR:-$HOME/.local/share/blvm-mainnet}"
CONFIG_FILE="${BLVM_CONFIG:-}"
LOG_FILE="${BLVM_IBD_LOG:-$DATA_DIR/ibd.log}"

# Parse flags (--build, --restart, --init-config) before positional args.
DO_BUILD=0
DO_RESTART=0
POSITIONAL_ARGS=()
for arg in "$@"; do
    case "$arg" in
        --build)   DO_BUILD=1 ;;
        --restart) DO_RESTART=1 ;;
        *)         POSITIONAL_ARGS+=("$arg") ;;
    esac
done
set -- "${POSITIONAL_ARGS[@]+"${POSITIONAL_ARGS[@]}"}"

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

# --restart: kill any running blvm and wait for full process exit before relaunching.
# This prevents the new process from seeing artificially low MemAvailable caused by
# the dying process's file-backed LMDB pages still resident in the page cache,
# which would mis-classify workload as Shared and cause a UTXO cache size oscillation.
if [ "$DO_RESTART" = "1" ]; then
    if pgrep -x blvm > /dev/null 2>&1; then
        echo "Stopping existing blvm process..."
        pkill -TERM blvm 2>/dev/null || true
        # Give it up to 60s for graceful shutdown (engine sidecar + block flush); then SIGKILL.
        for i in $(seq 1 120); do
            pgrep -x blvm > /dev/null 2>&1 || break
            sleep 0.5
        done
        if pgrep -x blvm > /dev/null 2>&1; then
            echo "blvm still running after 60s, sending SIGKILL..."
            pkill -KILL blvm 2>/dev/null || true
        fi
        # Wait for the kernel to fully reclaim process pages (especially large LMDB mmaps).
        # Without this, MemAvailable is temporarily reduced and MemoryGuard may mis-classify
        # the workload as Shared, allocating a smaller UTXO cache that surges on the next
        # segment and triggers an OOM.
        echo "Waiting for process exit and page-cache stabilization..."
        for i in $(seq 1 20); do
            pgrep -x blvm > /dev/null 2>&1 || break
            sleep 0.5
        done
        # Extra 3s for kernel to unmap large LMDB file-backed pages.
        sleep 3
        echo "Previous blvm process exited; starting new run."
    else
        echo "No running blvm found; starting fresh."
    fi
fi

# --build: compile from source before running so we never run a stale binary.
if [ "$DO_BUILD" = "1" ]; then
    CARGO_MANIFEST="$BLVM_ROOT/Cargo.toml"
    if [ ! -f "$CARGO_MANIFEST" ]; then
        echo "--build: Cargo.toml not found at $BLVM_ROOT — cannot build from source."
        exit 1
    fi
    echo "Building blvm from source (cargo build --release)..."
    cargo build --release --manifest-path "$CARGO_MANIFEST"
    echo "Build complete."
fi

# Binary resolution: prefer the cargo output (always fresh after a build) over
# the static installed binary, so 'cargo build --release' is automatically picked up.
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
    echo "blvm binary not found. Run with --build, set BLVM_BINARY, or place a binary at $BLVM_ROOT/blvm."
    exit 1
fi

# Warn if the static installed binary is newer than target/release/blvm — this
# means source changes were not built yet.
if [ -x "$BLVM_ROOT/target/release/blvm" ] && [ -x "$BLVM_ROOT/blvm" ]; then
    rel_time=$(stat -c %Y "$BLVM_ROOT/target/release/blvm" 2>/dev/null || echo 0)
    inst_time=$(stat -c %Y "$BLVM_ROOT/blvm" 2>/dev/null || echo 0)
    if [ "$inst_time" -gt "$rel_time" ]; then
        echo "WARNING: $BLVM_ROOT/blvm is newer than target/release/blvm — source may have un-built changes."
        echo "         Run with --build to rebuild, or set BLVM_BINARY to override."
    fi
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
if [ -d "$DATA_DIR/heed3" ] || [ -d "$DATA_DIR/rocksdb" ] || [ -d "$DATA_DIR/redb" ] || [ -d "$DATA_DIR/sled" ]; then
    echo "Existing chain data found — resuming sync (keep the same data dir; do not wipe the active backend directory)."
fi
export RUST_LOG="${RUST_LOG:-blvm=info}"
# jemalloc: background purge threads return cross-thread freed pages to OS automatically.
# The IBD pipeline allocates Arc<Block> on the download thread and frees it on validation
# worker threads (cross-thread free). mimalloc v3 accumulates these as "abandoned" pages
# that can't be purged, filling 32 GB swap by h=450k. jemalloc background_threads option
# runs a dedicated purge thread applying MADV_DONTNEED after dirty_decay_ms milliseconds.
# dirty_decay_ms=1000: pages idle for 1s are returned to OS. muzzy_decay_ms=30000: huge pages
# decay after 30s. background_thread:true: enables the background purge thread.
# Enable jemalloc heap profiling if BLVM_JEMALLOC_PROF=1 (requires profiling feature compiled in).
# Profiles are written to /tmp/blvm_heap_{h}.jep and analyzed with: jeprof /path/to/blvm /tmp/blvm_heap_{h}.jep
if [ "${BLVM_JEMALLOC_PROF:-0}" = "1" ]; then
    export MALLOC_CONF="${MALLOC_CONF:-background_thread:true,dirty_decay_ms:1000,muzzy_decay_ms:30000,prof:true,prof_active:true,lg_prof_sample:19}"
    echo "jemalloc heap profiling ENABLED (lg_prof_sample=19 = ~512KB sampling). Profiles → /tmp/blvm_heap_*.jep"
else
    export MALLOC_CONF="${MALLOC_CONF:-background_thread:true,dirty_decay_ms:1000,muzzy_decay_ms:30000}"
fi
# Cap validation workers to 8. Default for 32+ GiB hosts scales to cpus-1 (up to 24), which
# creates 24 mimalloc thread-local heaps, each accumulating ~100-200 MB of free-page caches
# that show up as UNEXPLAINED_ANON (~3-4 GB from validation workers alone). With BLVM_IBD_MAX_PARALLEL=8,
# the thread cache footprint drops to ~800 MB-1.2 GB. At h=400k+ the bottleneck is disk I/O
# (engine disk evictions), not CPU, so reducing workers does not significantly impact BPS.
export BLVM_IBD_MAX_PARALLEL="${BLVM_IBD_MAX_PARALLEL:-8}"
# Phase A (IBD_BPS_OPTIMIZATION_PLAN): widen LOCAL_GAP inject/persist lookahead for crawl supply.
export BLVM_IBD_GAP_INJECT_LOOKAHEAD="${BLVM_IBD_GAP_INJECT_LOOKAHEAD:-64}"
export BLVM_IBD_GAP_PERSIST_LOOKAHEAD="${BLVM_IBD_GAP_PERSIST_LOOKAHEAD:-64}"
# Cap Rayon global thread pool for script verification. Default uses num_cpus() (35 on
# this machine). Capping to 12 threads is sufficient for 8 concurrent validation workers
# while reducing per-thread memory overhead (each Rayon thread has its own jemalloc tcache).
# Use BLVM_SCRIPT_THREADS to override; set to 0 to use Rayon default (RAYON_NUM_THREADS).
export BLVM_SCRIPT_THREADS="${BLVM_SCRIPT_THREADS:-12}"
# F-C4: extend effective_end during soak so G0 gets ≥15 min WAN after long replay (RC-B).
export BLVM_IBD_FOLLOW_TIP="${BLVM_IBD_FOLLOW_TIP:-1}"

# Never inherit a stale BLVM_HEED3_MAP_SIZE_MB from parent shells — soak/testing should
# use auto-tune (70% free disk + data.mdb+128GiB headroom). Opt in explicitly:
#   BLVM_ALLOW_HEED3_MAP_SIZE_OVERRIDE=1 BLVM_HEED3_MAP_SIZE_MB=N ./scripts/start-ibd-mainnet.sh
if [ -n "${BLVM_HEED3_MAP_SIZE_MB:-}" ]; then
    if [ "${BLVM_ALLOW_HEED3_MAP_SIZE_OVERRIDE:-0}" = "1" ]; then
        echo "WARNING: BLVM_HEED3_MAP_SIZE_MB=${BLVM_HEED3_MAP_SIZE_MB} allowed (BLVM_ALLOW_HEED3_MAP_SIZE_OVERRIDE=1)"
    else
        echo "WARNING: stripping inherited BLVM_HEED3_MAP_SIZE_MB=${BLVM_HEED3_MAP_SIZE_MB} (set BLVM_ALLOW_HEED3_MAP_SIZE_OVERRIDE=1 to keep)"
        unset BLVM_HEED3_MAP_SIZE_MB
    fi
fi

# Never inherit a stale BLVM_IBD_EXPORT_HEIGHT_OVERRIDE from parent shells (Cursor agent
# recovery pins). An override *below* the durable export_h seeds the current ckpt labeled
# as an older tip → UTXO miss death-loop (2026-07-12). Opt in explicitly:
#   BLVM_ALLOW_EXPORT_HEIGHT_OVERRIDE=1 BLVM_IBD_EXPORT_HEIGHT_OVERRIDE=N ./scripts/start-ibd-mainnet.sh
if [ -n "${BLVM_IBD_EXPORT_HEIGHT_OVERRIDE:-}" ]; then
    if [ "${BLVM_ALLOW_EXPORT_HEIGHT_OVERRIDE:-0}" = "1" ]; then
        echo "WARNING: BLVM_IBD_EXPORT_HEIGHT_OVERRIDE=${BLVM_IBD_EXPORT_HEIGHT_OVERRIDE} allowed (BLVM_ALLOW_EXPORT_HEIGHT_OVERRIDE=1)"
    else
        echo "WARNING: stripping inherited BLVM_IBD_EXPORT_HEIGHT_OVERRIDE=${BLVM_IBD_EXPORT_HEIGHT_OVERRIDE} (set BLVM_ALLOW_EXPORT_HEIGHT_OVERRIDE=1 to keep)"
        unset BLVM_IBD_EXPORT_HEIGHT_OVERRIDE
    fi
fi

# Log rotation: rename existing log to ibd-YYYYMMDD-HHMMSS.log so each run has its
# own file. Old rotated logs beyond BLVM_LOG_KEEP are pruned (default: keep 5).
BLVM_LOG_KEEP="${BLVM_LOG_KEEP:-5}"
if [ -f "$LOG_FILE" ] && [ -s "$LOG_FILE" ]; then
    rotated="${LOG_FILE%.log}-$(date '+%Y%m%d-%H%M%S').log"
    mv "$LOG_FILE" "$rotated"
    echo "Rotated previous log → $(basename "$rotated")"
    # Prune oldest rotated logs beyond the keep count.
    log_dir="$(dirname "$LOG_FILE")"
    log_base="$(basename "${LOG_FILE%.log}")"
    mapfile -t old_logs < <(ls -t "$log_dir/${log_base}"-????????-??????.log 2>/dev/null)
    if [ "${#old_logs[@]}" -gt "$BLVM_LOG_KEEP" ]; then
        for f in "${old_logs[@]:$BLVM_LOG_KEEP}"; do
            rm -f "$f"
            echo "Pruned old log: $(basename "$f")"
        done
    fi
fi

echo "Binary:  $BINARY  ($(stat -c '%y' "$BINARY" 2>/dev/null | cut -d'.' -f1))"
echo "Config:  $CONFIG_FILE"
echo "Data:    $DATA_DIR"
echo "Log:     $LOG_FILE"
[ -n "${BLVM_IBD_PEERS:-}" ] && echo "IBD peers: $BLVM_IBD_PEERS"

if [ -n "${BLVM_BACKGROUND:-}" ]; then
    IBD_ENV=()
    [ -n "${BLVM_IBD_PEERS:-}" ] && IBD_ENV+=(BLVM_IBD_PEERS="$BLVM_IBD_PEERS")
    [ -n "${BLVM_IBD_MODE:-}" ] && IBD_ENV+=(BLVM_IBD_MODE="$BLVM_IBD_MODE")
    # Pass OVERRIDE only when explicitly allowed (already filtered above).
    [ -n "${BLVM_IBD_EXPORT_HEIGHT_OVERRIDE:-}" ] && IBD_ENV+=(BLVM_IBD_EXPORT_HEIGHT_OVERRIDE="$BLVM_IBD_EXPORT_HEIGHT_OVERRIDE")
    nohup env -u BLVM_IBD_EXPORT_HEIGHT_OVERRIDE -u BLVM_HEED3_MAP_SIZE_MB "${IBD_ENV[@]}" \
        "$BINARY" \
        --config "$CONFIG_FILE" \
        --network mainnet \
        --data-dir "$DATA_DIR" \
        --verbose \
        >> "$LOG_FILE" 2>&1 &
    BLVM_PID=$!
    echo "PID: $BLVM_PID (background; tail -f $LOG_FILE)"
    disown 2>/dev/null || true
    # External memory monitor: kills blvm before OOM. Runs outside the binary.
    # Disable with BLVM_NO_MEM_MONITOR=1.
    if [ -z "${BLVM_NO_MEM_MONITOR:-}" ]; then
        MONITOR_SCRIPT="$SCRIPT_DIR/ibd-mem-monitor.sh"
        MONITOR_LOG="${BLVM_MONITOR_LOG:-$DATA_DIR/mem-monitor.log}"
        if [ -x "$MONITOR_SCRIPT" ]; then
            nohup "$MONITOR_SCRIPT" "$BLVM_PID" "$MONITOR_LOG" >> "$MONITOR_LOG" 2>&1 &
            echo "Monitor: PID $! (swap kill at ${BLVM_SWAP_KILL_PCT:-85}%; log: $MONITOR_LOG)"
            disown 2>/dev/null || true
        else
            echo "WARNING: $MONITOR_SCRIPT not found/executable — no external OOM protection"
        fi
    fi
else
    IBD_ENV=()
    [ -n "${BLVM_IBD_PEERS:-}" ] && IBD_ENV+=(BLVM_IBD_PEERS="$BLVM_IBD_PEERS")
    [ -n "${BLVM_IBD_MODE:-}" ] && IBD_ENV+=(BLVM_IBD_MODE="$BLVM_IBD_MODE")
    [ -n "${BLVM_IBD_EXPORT_HEIGHT_OVERRIDE:-}" ] && IBD_ENV+=(BLVM_IBD_EXPORT_HEIGHT_OVERRIDE="$BLVM_IBD_EXPORT_HEIGHT_OVERRIDE")
    env -u BLVM_IBD_EXPORT_HEIGHT_OVERRIDE -u BLVM_HEED3_MAP_SIZE_MB "${IBD_ENV[@]}" \
        "$BINARY" \
        --config "$CONFIG_FILE" \
        --network mainnet \
        --data-dir "$DATA_DIR" \
        --verbose \
        2>&1 | tee "$LOG_FILE"
fi
