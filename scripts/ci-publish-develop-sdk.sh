#!/usr/bin/env bash
# Publish blvm-sdk-macros then blvm-sdk at coordinated develop version V.
set -euo pipefail

SCRIPTS_DIR=""
VERSION=""
WAIT_FOR="blvm-node"

while [ $# -gt 0 ]; do
  case "$1" in
    --wait-for) WAIT_FOR="${2:?}"; shift 2 ;;
    --scripts-dir) SCRIPTS_DIR="${2:?}"; shift 2 ;;
    -h|--help)
      echo "Usage: $0 [--scripts-dir DIR] [--wait-for CRATES] VERSION" >&2
      exit 0
      ;;
    *)
      VERSION="$1"
      shift
      ;;
  esac
done

[ -n "${VERSION}" ] || { echo "VERSION required" >&2; exit 1; }

if [ -z "${SCRIPTS_DIR}" ]; then
  SCRIPTS_DIR="$(bash "$(dirname "${BASH_SOURCE[0]}")/ci-develop-scripts-dir.sh")"
fi

IFS=',' read -r -a wait_crates <<< "${WAIT_FOR}"
for dep in "${wait_crates[@]}"; do
  [ -n "${dep}" ] || continue
  echo "Waiting for ${dep} @ ${VERSION}..."
  for i in $(seq 1 40); do
    if curl -sf -H "User-Agent: blvm-ci/1.0" \
      "https://crates.io/api/v1/crates/${dep}/${VERSION}" >/dev/null 2>&1; then
      break
    fi
    [ "${i}" -eq 40 ] && { echo "❌ timeout ${dep}"; exit 1; }
    sleep 15
  done
done

bump() {
  local file="$1"
  awk -v ver="${VERSION}" '
    /^\[package\]/ { in_package = 1; print; next }
    /^\[/ { in_package = 0 }
    in_package && /^version = / { print "version = \"" ver "\""; next }
    { print }
  ' "${file}" > "${file}.tmp" && mv "${file}.tmp" "${file}"
}

bump Cargo.toml
[ -f crates/blvm-sdk-macros/Cargo.toml ] && bump crates/blvm-sdk-macros/Cargo.toml

bash "${SCRIPTS_DIR}/resolve-develop-registry-deps.sh" \
  --mode publish --version "${VERSION}" Cargo.toml

if grep -q '^blvm-sdk-macros = ' Cargo.toml; then
  sed -i "s|^blvm-sdk-macros = .*|blvm-sdk-macros = { version = \"=${VERSION}\", path = \"crates/blvm-sdk-macros\" }|" Cargo.toml
fi

cargo metadata --format-version 1 --no-deps >/dev/null

publish_crate() {
  local dir="${1:-.}"
  local name
  name="$(grep -A 5 '^\[package\]' "${dir}/Cargo.toml" | grep '^name = ' | head -1 | sed -E 's/^name = "([^"]+)".*/\1/')"
  if curl -sf -H "User-Agent: blvm-ci/1.0" \
    "https://crates.io/api/v1/crates/${name}/${VERSION}" >/dev/null 2>&1; then
    echo "⚠️  ${name} ${VERSION} already published"
    return 0
  fi
  (cd "${dir}" && cargo publish --dry-run --allow-dirty --no-verify)
  (cd "${dir}" && cargo publish --allow-dirty --no-verify)
  sleep 30
}

publish_crate crates/blvm-sdk-macros
publish_crate .

echo "published_version=${VERSION}"
