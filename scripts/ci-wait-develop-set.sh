#!/usr/bin/env bash
# Wait until all crates in develop-release-set.txt are published at VERSION on crates.io.
# With --allow-stable-fallback, succeed even when the set is missing (caller uses main/stable crates).
set -euo pipefail

VERSION="${1:?VERSION required}"
shift || true

ALLOW_FALLBACK=0
EMIT_SHELL=0
while [ $# -gt 0 ]; do
  case "$1" in
    --allow-stable-fallback) ALLOW_FALLBACK=1; shift ;;
    --emit-shell) EMIT_SHELL=1; shift ;;
    -h|--help)
      echo "Usage: $0 VERSION [--allow-stable-fallback] [--emit-shell]" >&2
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SET="${SCRIPTS_DIR}/develop-release-set.txt"

MAX_ATTEMPTS=40
SLEEP_SECS=15
if [ "${ALLOW_FALLBACK}" -eq 1 ]; then
  MAX_ATTEMPTS=1
fi

missing=()

while IFS= read -r crate || [ -n "${crate}" ]; do
  [ -z "${crate}" ] && continue
  [[ "${crate}" =~ ^# ]] && continue
  echo "Checking ${crate} @ ${VERSION}..."
  found=0
  for i in $(seq 1 "${MAX_ATTEMPTS}"); do
    if curl -sf -H "User-Agent: blvm-ci/1.0" \
      "https://crates.io/api/v1/crates/${crate}/${VERSION}" >/dev/null 2>&1; then
      echo "✅ ${crate}"
      found=1
      break
    fi
    if [ "${i}" -eq "${MAX_ATTEMPTS}" ]; then
      missing+=("${crate}")
    else
      sleep "${SLEEP_SECS}"
    fi
  done
done < "${SET}"

USE_DEVELOP=1
if [ ${#missing[@]} -gt 0 ]; then
  if [ "${ALLOW_FALLBACK}" -eq 1 ]; then
    USE_DEVELOP=0
    echo "::notice::Develop set ${VERSION} not fully on crates.io (missing: ${missing[*]}) — falling back to main/stable crates"
  else
    echo "❌ Develop set incomplete at ${VERSION}; missing: ${missing[*]}" >&2
    exit 1
  fi
else
  echo "All develop set crates at ${VERSION}"
fi

if [ "${EMIT_SHELL}" -eq 1 ]; then
  echo "USE_DEVELOP=${USE_DEVELOP}"
  if [ "${USE_DEVELOP}" -eq 1 ]; then
    echo "DEVELOP_VERSION=${VERSION}"
  fi
  exit 0
fi

[ "${USE_DEVELOP}" -eq 1 ]
