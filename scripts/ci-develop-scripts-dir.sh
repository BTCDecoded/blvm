#!/usr/bin/env bash
# Print absolute path to blvm/scripts (for develop CI in sibling repos).
set -euo pipefail

if [ -n "${BLVM_SCRIPTS_DIR:-}" ] && [ -f "${BLVM_SCRIPTS_DIR}/compute-develop-version.sh" ]; then
  echo "${BLVM_SCRIPTS_DIR}"
  exit 0
fi

for candidate in \
  "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
  "../blvm/scripts" \
  "../../blvm/scripts" \
  "/mnt/data/bitcoin/blvm/blvm/scripts"; do
  resolved="$(cd "${candidate}" 2>/dev/null && pwd)" || continue
  if [ -f "${resolved}/compute-develop-version.sh" ]; then
    echo "${resolved}"
    exit 0
  fi
done

tmpdir="${RUNNER_TEMP:-/tmp}/blvm-develop-scripts-$$"
mkdir -p "${tmpdir}"
git clone --depth 1 --branch develop \
  https://github.com/BTCDecoded/blvm.git "${tmpdir}/repo" 2>/dev/null || \
  git clone --depth 1 --branch main \
    https://github.com/BTCDecoded/blvm.git "${tmpdir}/repo"
echo "${tmpdir}/repo/scripts"
