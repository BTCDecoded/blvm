#!/bin/bash
# Create verification bundle for the blvm-consensus repo and optionally timestamp it
# Usage:
#   make_verification_bundle.sh --repo /path/to/blvm-consensus [--out /path/to/outdir]
# Environment alternatives:
#   CP_REPO=/path/to/blvm-consensus OUT_DIR=/path/to/outdir ./make_verification_bundle.sh

set -euo pipefail

# Defaults
CP_REPO_DEFAULT="${CP_REPO:-}"
OUT_DIR_DEFAULT="${OUT_DIR:-}"

print_usage() {
  echo "Usage: $0 --repo /path/to/blvm-consensus [--out /path/to/outdir]" >&2
}

CP_REPO="${CP_REPO_DEFAULT}"
OUT_DIR="${OUT_DIR_DEFAULT}"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      CP_REPO="$2"; shift 2 ;;
    --out)
      OUT_DIR="$2"; shift 2 ;;
    -h|--help)
      print_usage; exit 0 ;;
    *)
      echo "Unknown argument: $1" >&2
      print_usage
      exit 2 ;;
  esac
done

if [[ -z "${CP_REPO}" ]]; then
  echo "Error: --repo /path/to/blvm-consensus is required (or CP_REPO env)." >&2
  exit 2
fi

if [[ ! -d "${CP_REPO}" ]]; then
  echo "Error: repo path not found: ${CP_REPO}" >&2
  exit 2
fi

if [[ -z "${OUT_DIR}" ]]; then
  OUT_DIR="${CP_REPO%/}/verify-artifacts"
fi

mkdir -p "${OUT_DIR}"
BUNDLE_DIR="${OUT_DIR}"
BUNDLE_PATH="${CP_REPO%/}/verify-artifacts.tar.gz"

echo "=== Verification Bundle ==="
echo "Repo: ${CP_REPO}"
echo "Out:  ${OUT_DIR}"

# Run tests
echo "=== Running tests (blvm-consensus) ==="
( cd "${CP_REPO}" && cargo test --all-features ) | tee "${OUT_DIR}/tests.log"

# Collect metadata
( cd "${CP_REPO}" && cargo metadata --format-version=1 ) > "${OUT_DIR}/cargo_metadata.json" || true

# Bundle artifacts
echo "=== Creating bundle ==="
# Normalize path to repo root to avoid nesting absolute paths inside the archive
(
  cd "${CP_REPO}" \
  && tar -czf "${BUNDLE_PATH}" "$(realpath --relative-to="${CP_REPO}" "${BUNDLE_DIR}")"
)

# SHA256
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum "${BUNDLE_PATH}" | tee "${BUNDLE_PATH}.sha256"
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 "${BUNDLE_PATH}" | tee "${BUNDLE_PATH}.sha256"
else
  echo "Warning: no sha256 tool available; skipping hash file" >&2
fi

# Optional OpenTimestamps
if command -v ots >/dev/null 2>&1; then
  echo "=== OpenTimestamps stamping ==="
  ots stamp "${BUNDLE_PATH}"
  echo "Stamped: ${BUNDLE_PATH}.ots"
else
  echo "OpenTimestamps (ots) not installed; skipping timestamp."
fi

# Generate bundle metadata JSON
echo "=== Generating bundle metadata ==="
BUNDLE_METADATA="${BUNDLE_PATH%.tar.gz}.json"
SOURCE_HASH=""
if command -v git >/dev/null 2>&1; then
  ( cd "${CP_REPO}" && SOURCE_HASH=$(git rev-parse HEAD) ) || SOURCE_HASH=""
fi

# Create metadata JSON
cat > "${BUNDLE_METADATA}" <<EOF
{
  "version": "1.0",
  "bundle_type": "blvm-consensus",
  "created_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "source_repo": "$(basename "${CP_REPO}")",
  "source_commit": "${SOURCE_HASH}",
  "source_hash": "${SOURCE_HASH}",
  "bundle_hash": "$(grep -o '^[a-f0-9]*' "${BUNDLE_PATH}.sha256" 2>/dev/null || echo "")",
  "verification_results": {
    "tests": {
      "status": "$(grep -q "test result: ok" "${OUT_DIR}/tests.log" 2>/dev/null && echo "passed" || echo "unknown")",
      "log_file": "tests.log"
    }
  },
  "artifacts": {
    "bundle_archive": "$(basename "${BUNDLE_PATH}")",
    "checksum_file": "$(basename "${BUNDLE_PATH}.sha256")"
  }
}
EOF

echo "Bundle metadata: ${BUNDLE_METADATA}"

# Optional: Sign bundle metadata if blvm-sign-binary is available
if command -v blvm-sign-binary >/dev/null 2>&1 && [[ -n "${BLVM_SIGN_KEY:-}" ]]; then
  echo "=== Signing bundle metadata ==="
  BUNDLE_SIG="${BUNDLE_METADATA}.sig"
  if blvm-sign-binary bundle \
    --file "${BUNDLE_PATH}" \
    --source-hash "${SOURCE_HASH}" \
    --key "${BLVM_SIGN_KEY}" \
    --output "${BUNDLE_SIG}" 2>/dev/null; then
    echo "Bundle signed: ${BUNDLE_SIG}"
  else
    echo "Warning: Failed to sign bundle metadata (key may not be set)"
  fi
else
  echo "Note: Bundle metadata not signed (set BLVM_SIGN_KEY to enable signing)"
fi

echo "Done. Bundle: ${BUNDLE_PATH}"
echo "Metadata: ${BUNDLE_METADATA}"
