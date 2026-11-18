#!/bin/sh
# Image entrypoint. HEALTHCHECK calls this with `health` so both use the same
# config and data directory. BLVM_CONFIG is optional. BLVM_DATA_DIR defaults
# to /var/lib/blvm. Do not add a Docker VOLUME; the operator bind-mounts a
# directory owned by uid 61100.
set -eu
datadir="${BLVM_DATA_DIR:-/var/lib/blvm}"
if [ -n "${BLVM_CONFIG:-}" ]; then
	exec /usr/local/bin/blvm --config "$BLVM_CONFIG" --data-dir "$datadir" "$@"
fi
exec /usr/local/bin/blvm --data-dir "$datadir" "$@"
