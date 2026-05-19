#!/usr/bin/env bash
# Publish one crate to crates.io as develop pre-release version V.
# Usage: ci-publish-develop.sh [--wait-for CRATE,...] [--scripts-dir DIR] [VERSION]
set -euo pipefail

WAIT_FOR=""
SCRIPTS_DIR=""
VERSION=""

while [ $# -gt 0 ]; do
  case "$1" in
    --wait-for) WAIT_FOR="${2:?}"; shift 2 ;;
    --scripts-dir) SCRIPTS_DIR="${2:?}"; shift 2 ;;
    -h|--help)
      echo "Usage: $0 [--wait-for blvm-consensus,...] [--scripts-dir DIR] [VERSION]" >&2
      exit 0
      ;;
    *)
      VERSION="$1"
      shift
      ;;
  esac
done

if [ -z "${SCRIPTS_DIR}" ]; then
  SCRIPTS_DIR="$(bash "$(dirname "${BASH_SOURCE[0]}")/ci-develop-scripts-dir.sh")"
fi

if [ -z "${VERSION}" ]; then
  VERSION="$(bash "${SCRIPTS_DIR}/compute-develop-version.sh")"
fi

echo "Develop publish version V=${VERSION}"

CRATE_NAME="$(grep -A 5 '^\[package\]' Cargo.toml | grep '^name = ' | head -1 | sed -E 's/^name = "([^"]+)".*/\1/')"
echo "Crate: ${CRATE_NAME}"

wait_for_crate() {
  local dep="$1"
  local want="${VERSION}"
  echo "Waiting for ${dep} @ ${want} on crates.io..."
  for i in $(seq 1 40); do
    if curl -sf -H "User-Agent: blvm-ci/1.0" \
      "https://crates.io/api/v1/crates/${dep}/${want}" >/dev/null 2>&1; then
      echo "✅ ${dep} ${want} available"
      return 0
    fi
    sleep 15
  done
  echo "❌ Timeout waiting for ${dep} ${want}" >&2
  return 1
}

IFS=',' read -r -a wait_crates <<< "${WAIT_FOR}"
for dep in "${wait_crates[@]}"; do
  [ -n "${dep}" ] || continue
  wait_for_crate "${dep}"
done

export VERSION
awk -v ver="${VERSION}" '
  /^\[package\]/ { in_package = 1; print; next }
  /^\[/ { in_package = 0 }
  in_package && /^version = / {
    print "version = \"" ver "\""
    next
  }
  { print }
' Cargo.toml > Cargo.toml.tmp && mv Cargo.toml.tmp Cargo.toml

bash "${SCRIPTS_DIR}/resolve-develop-registry-deps.sh" \
  --mode publish --version "${VERSION}" Cargo.toml

cargo metadata --format-version 1 --no-deps >/dev/null
cargo publish --dry-run --allow-dirty

if curl -sf -H "User-Agent: blvm-ci/1.0" \
  "https://crates.io/api/v1/crates/${CRATE_NAME}/${VERSION}" >/dev/null 2>&1; then
  echo "⚠️  ${CRATE_NAME} ${VERSION} already on crates.io — skipping publish"
else
  cargo publish --allow-dirty
  sleep 30
fi

echo "published_version=${VERSION}"
