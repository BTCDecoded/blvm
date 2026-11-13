#!/bin/sh
# Compare a source build, a prebuilt binary, and a Docker image on one smoke.
# The smoke is: start regtest with the minimal-hardened profile, call
# getblockcount, and stop. Missing artifacts exit 2. A mismatch exits 1.
set -eu
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PROFILE="${BLVM_PROFILE:-$ROOT/../blvm-node/config/minimal-hardened.toml}"
echo "artifact parity smoke"
echo "profile=$PROFILE"
echo "source_binary=${BLVM_SOURCE_BIN:-unset}"
echo "prebuilt_binary=${BLVM_PREBUILT_BIN:-unset}"
echo "docker_image=${BLVM_DOCKER_IMAGE:-unset}"
missing=0
for item in "${BLVM_SOURCE_BIN:-}" "${BLVM_PREBUILT_BIN:-}" "${BLVM_DOCKER_IMAGE:-}"; do
  if [ -z "$item" ]; then
    missing=1
  fi
done
if [ "$missing" -ne 0 ]; then
  echo "parity: source, prebuilt, and docker image are not all present. Exit 2."
  exit 2
fi
# Names being set is not a comparison. Exit 0 only after getblockcount matches.
echo "parity: the three names are set, and this script does not start the node or compare RPC results yet."
echo "parity: refusing to report success. Exit 2."
exit 2
