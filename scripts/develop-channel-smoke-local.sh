#!/usr/bin/env bash
# Local smoke checks for develop-channel scripts (no publish).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BLVM_SCRIPTS="${ROOT}/blvm/scripts"

echo "=== compute-develop-version ==="
V="$(bash "${BLVM_SCRIPTS}/compute-develop-version.sh")"
echo "V=${V}"

echo "=== resolve (blvm Cargo.toml copy) ==="
TMP="$(mktemp)"
cp "${ROOT}/blvm/Cargo.toml" "${TMP}"
bash "${BLVM_SCRIPTS}/resolve-develop-registry-deps.sh" --mode resolve "${TMP}" || true
grep -E '^blvm-(node|sdk)' "${TMP}" | head -3

echo "=== resolve publish dry-run (temp) ==="
cp "${ROOT}/blvm/Cargo.toml" "${TMP}"
bash "${BLVM_SCRIPTS}/resolve-develop-registry-deps.sh" --mode publish --version "${V}" "${TMP}"
grep -E '^blvm-node' "${TMP}" | head -1

rm -f "${TMP}"
echo "=== OK ==="
