#!/usr/bin/env bash
# Compute next coordinated develop version V = 0.1.(patch(S)+1)-dev.M from crates.io.
set -euo pipefail

ANCHOR="blvm-consensus"
VERIFY_SET=0
EMIT_SHELL=0
FORCE_VERSION=""
VERSIONS_TOML=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELEASE_SET="${SCRIPT_DIR}/develop-release-set.txt"

usage() {
  echo "Usage: $0 [--anchor CRATE] [--verify-set] [--versions-toml PATH] [--force-version V] [--emit-shell]" >&2
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    --anchor) ANCHOR="${2:?}"; shift 2 ;;
    --verify-set) VERIFY_SET=1; shift ;;
    --versions-toml) VERSIONS_TOML="${2:?}"; shift 2 ;;
    --force-version) FORCE_VERSION="${2:?}"; shift 2 ;;
    --emit-shell) EMIT_SHELL=1; shift ;;
    -h|--help) usage ;;
    *) usage ;;
  esac
done

if [ -n "${FORCE_VERSION}" ]; then
  if ! echo "${FORCE_VERSION}" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+-dev\.[0-9]+$'; then
    echo "❌ --force-version must match X.Y.Z-dev.N (got ${FORCE_VERSION})" >&2
    exit 1
  fi
  echo "Using forced develop version ${FORCE_VERSION}" >&2
  if [ "${EMIT_SHELL}" -eq 1 ]; then
    echo "DEVELOP_VERSION=${FORCE_VERSION}"
    echo "DEVELOP_BASED_ON_STABLE="
    echo "DEVELOP_PREFIX=$(echo "${FORCE_VERSION}" | sed -E 's/\.[0-9]+$//')"
  else
    echo "${FORCE_VERSION}"
  fi
  exit 0
fi

if [ -z "${VERSIONS_TOML}" ]; then
  for candidate in "${SCRIPT_DIR}/../versions.toml" "${SCRIPT_DIR}/../../versions.toml"; do
    if [ -f "${candidate}" ]; then
      VERSIONS_TOML="${candidate}"
      break
    fi
  done
fi

fetch_versions() {
  local crate="$1"
  curl -sf -H "User-Agent: blvm-ci/1.0 (github.com/BTCDecoded)" \
    "https://crates.io/api/v1/crates/${crate}/versions" | jq -r '.versions[].num'
}

max_stable() {
  local crate="$1"
  local versions stable
  versions="$(fetch_versions "${crate}" 2>/dev/null || true)"
  stable="$(printf '%s\n' ${versions} | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1 || true)"
  if [ -z "${stable}" ] && [ -n "${VERSIONS_TOML}" ] && [ -f "${VERSIONS_TOML}" ]; then
    stable="$(grep -E "^${crate} = " "${VERSIONS_TOML}" | head -1 | sed -E 's/.*version = "([^"]+)".*/\1/' || true)"
    echo "⚠️  No stable on crates.io for ${crate}; fallback from versions.toml: ${stable:-none}" >&2
  fi
  if [ -z "${stable}" ]; then
    echo "❌ Could not determine stable version S for ${crate}" >&2
    exit 1
  fi
  echo "${stable}"
}

S="$(max_stable "${ANCHOR}")"
echo "Anchor ${ANCHOR} stable S=${S}" >&2

if [ "${VERIFY_SET}" -eq 1 ] && [ -f "${RELEASE_SET}" ]; then
  while IFS= read -r crate || [ -n "${crate}" ]; do
    [ -z "${crate}" ] && continue
    [[ "${crate}" =~ ^# ]] && continue
    other="$(max_stable "${crate}")"
    if [ "$(echo "${S}" | cut -d. -f1-2)" != "$(echo "${other}" | cut -d. -f1-2)" ] || \
       [ "$(echo "${S}" | cut -d. -f3)" != "$(echo "${other}" | cut -d. -f3)" ]; then
      echo "⚠️  ${crate} stable ${other} differs from anchor ${S}" >&2
    fi
  done < "${RELEASE_SET}"
fi

MAJOR="$(echo "${S}" | cut -d. -f1)"
MINOR="$(echo "${S}" | cut -d. -f2)"
SPATCH="$(echo "${S}" | cut -d. -f3)"
NPATCH=$((SPATCH + 1))
PREFIX="${MAJOR}.${MINOR}.${NPATCH}-dev"

versions="$(fetch_versions "${ANCHOR}" 2>/dev/null || true)"
MAX_M=0
while IFS= read -r ver; do
  [ -z "${ver}" ] && continue
  if [[ "${ver}" =~ ^${PREFIX}\.([0-9]+)$ ]]; then
    m="${BASH_REMATCH[1]}"
    if [ "${m}" -gt "${MAX_M}" ]; then MAX_M="${m}"; fi
  fi
done <<< "${versions}"

M=$((MAX_M + 1))
V="${PREFIX}.${M}"

# Ensure V not already published (re-run safety)
while printf '%s\n' ${versions} | grep -qxF "${V}"; do
  echo "⚠️  ${V} exists on index, incrementing M" >&2
  M=$((M + 1))
  V="${PREFIX}.${M}"
done

echo "dev_prefix=${PREFIX}" >&2
echo "based_on_stable=${S}" >&2
echo "develop_version=${V}" >&2
if [ "${EMIT_SHELL}" -eq 1 ]; then
  echo "DEVELOP_VERSION=${V}"
  echo "DEVELOP_BASED_ON_STABLE=${S}"
  echo "DEVELOP_PREFIX=${PREFIX}"
else
  echo "${V}"
fi
