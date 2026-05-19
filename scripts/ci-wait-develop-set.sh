#!/usr/bin/env bash
# Wait until all crates in develop-release-set.txt are published at VERSION on crates.io.
set -euo pipefail

VERSION="${1:?VERSION required}"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SET="${SCRIPTS_DIR}/develop-release-set.txt"

while IFS= read -r crate || [ -n "${crate}" ]; do
  [ -z "${crate}" ] && continue
  [[ "${crate}" =~ ^# ]] && continue
  echo "Checking ${crate} @ ${VERSION}..."
  for i in $(seq 1 40); do
    if curl -sf -H "User-Agent: blvm-ci/1.0" \
      "https://crates.io/api/v1/crates/${crate}/${VERSION}" >/dev/null 2>&1; then
      echo "✅ ${crate}"
      break
    fi
    if [ "${i}" -eq 40 ]; then
      echo "❌ ${crate} ${VERSION} not on index" >&2
      exit 1
    fi
    sleep 15
  done
done < "${SET}"

echo "All develop set crates at ${VERSION}"
