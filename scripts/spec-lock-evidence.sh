#!/usr/bin/env bash
# Produce spec-lock evidence for the blvm-consensus code linked into this release.
#
# The release binary links blvm-consensus from crates.io at the version pinned in
# Cargo.lock. This script checks that exact crate: it confirms the downloaded
# .crate matches the Cargo.lock checksum, then runs `cargo spec-lock verify`
# (and check-drift) on its source against the blvm-spec checkout. The result says
# what was checked and how it came out. A passing check is not a proof of
# conformance; the counts in spec_lock_verify.json say how much is covered.
#
# Usage: spec-lock-evidence.sh <BLVM_SPEC_DIR> <OUT_DIR>   (run from the blvm repo root)
#
# Env (optional):
#   SPEC_LOCK_VERSION        cargo-spec-lock version to install (default 0.1.45, the
#                            verifier blvm-consensus pins for its release gate)
#   SPEC_LOCK_Z3_TIMEOUT_SECS per-obligation Z3 timeout (default 120)
#
# Exit: non-zero if the crate checksum does not match or `verify` fails.
# check-drift is recorded in the evidence but does not fail this script.
set -euo pipefail

SPEC_DIR="${1:?BLVM_SPEC_DIR required}"
OUT_DIR="${2:?OUT_DIR required}"
SPEC_LOCK_VERSION="${SPEC_LOCK_VERSION:-0.1.45}"
export SPEC_LOCK_Z3_TIMEOUT_SECS="${SPEC_LOCK_Z3_TIMEOUT_SECS:-120}"

command -v jq >/dev/null 2>&1 || { echo "❌ jq required" >&2; exit 1; }
SPEC_DIR="$(cd "$SPEC_DIR" && pwd)"
mkdir -p "$OUT_DIR"
OUT_DIR="$(cd "$OUT_DIR" && pwd)"

lock_field() { # crate field
  awk -v crate="$1" -v field="$2" '
    $0 == "[[package]]" { in_pkg = 1; name = ""; next }
    in_pkg && $1 == "name" { name = $3; gsub(/"/, "", name); next }
    in_pkg && name == crate && $1 == field { v = $3; gsub(/"/, "", v); print v; exit }
  ' Cargo.lock
}

CONSENSUS_VERSION="$(lock_field blvm-consensus version)"
CONSENSUS_CHECKSUM="$(lock_field blvm-consensus checksum)"
if [[ -z "$CONSENSUS_VERSION" || -z "$CONSENSUS_CHECKSUM" ]]; then
  echo "❌ blvm-consensus (with a registry checksum) not found in Cargo.lock" >&2
  exit 1
fi
echo "📦 Linked blvm-consensus ${CONSENSUS_VERSION} (Cargo.lock checksum ${CONSENSUS_CHECKSUM})"

# Fetch exactly what the release build links, then check the bytes.
cargo fetch --locked >/dev/null
CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
CRATE_FILE="$(ls "$CARGO_HOME"/registry/cache/*/blvm-consensus-"${CONSENSUS_VERSION}".crate 2>/dev/null | head -1)"
[[ -f "$CRATE_FILE" ]] || { echo "❌ .crate not in cargo cache for ${CONSENSUS_VERSION}" >&2; exit 1; }
CRATE_SHA="$(sha256sum "$CRATE_FILE" | cut -d' ' -f1)"
if [[ "$CRATE_SHA" != "$CONSENSUS_CHECKSUM" ]]; then
  echo "❌ cached blvm-consensus-${CONSENSUS_VERSION}.crate sha256 ${CRATE_SHA} != Cargo.lock ${CONSENSUS_CHECKSUM}" >&2
  exit 1
fi
echo "✅ .crate matches Cargo.lock"
# Unpack the checked .crate itself (not cargo's src cache) into a path with no
# hidden components; spec-lock skips files under dot-directories such as ~/.cargo.
UNPACK_DIR="$(mktemp -d /tmp/blvm-spec-evidence-XXXXXX)"
trap 'rm -rf "$UNPACK_DIR"' EXIT
tar -xzf "$CRATE_FILE" -C "$UNPACK_DIR"
CRATE_SRC="$UNPACK_DIR/blvm-consensus-${CONSENSUS_VERSION}"
[[ -d "$CRATE_SRC/src" ]] || { echo "❌ unexpected .crate layout for ${CONSENSUS_VERSION}" >&2; exit 1; }

# Spec inputs, in the same order blvm-consensus CI passes them.
SPEC_FILES=()
if [[ -f "$SPEC_DIR/PROTOCOL.md" && -f "$SPEC_DIR/ARCHITECTURE.md" ]]; then
  SPEC_FILES=("$SPEC_DIR/PROTOCOL.md" "$SPEC_DIR/ARCHITECTURE.md")
  [[ -f "$SPEC_DIR/VERIFIED_FORMULAS.md" ]] && SPEC_FILES+=("$SPEC_DIR/VERIFIED_FORMULAS.md")
elif [[ -f "$SPEC_DIR/THE_ORANGE_PAPER.md" ]]; then
  SPEC_FILES=("$SPEC_DIR/THE_ORANGE_PAPER.md")
else
  echo "❌ No spec found in ${SPEC_DIR}" >&2
  exit 1
fi
SPEC_GIT_SHA="$(git -C "$SPEC_DIR" rev-parse HEAD 2>/dev/null || echo unknown)"
SPEC_META_VERSION=""
[[ -f "$SPEC_DIR/SPEC_META.json" ]] && SPEC_META_VERSION="$(jq -r '.version // empty' "$SPEC_DIR/SPEC_META.json")"
# spec_hash: sha256 over "<sha256>  <basename>\n" lines in argument order.
SPEC_LINES=""
for f in "${SPEC_FILES[@]}"; do
  SPEC_LINES+="$(sha256sum "$f" | cut -d' ' -f1)  $(basename "$f")"$'\n'
done
printf '%s' "$SPEC_LINES" > "$OUT_DIR/spec_files.sha256"
SPEC_HASH="$(sha256sum "$OUT_DIR/spec_files.sha256" | cut -d' ' -f1)"

# Pinned verifier, built with Z3. Install outside the repo so its toolchain file does not apply.
if ! cargo-spec-lock --version 2>/dev/null | grep -q " ${SPEC_LOCK_VERSION}$"; then
  (cd /tmp && cargo install --force blvm-spec-lock --version "${SPEC_LOCK_VERSION}" --locked --features z3 --quiet)
fi
TOOL_VERSION="$(cargo-spec-lock --version | awk '{print $2}')"

SPEC_ARGS=(--crate-path "$CRATE_SRC" --spec-path "${SPEC_FILES[@]}")
export BLVM_SPEC_DIR="$SPEC_DIR"
export BLVM_ASSUME_VALID_HEIGHT=0

echo "📎 check-drift (recorded, not gating)"
set +e
cargo-spec-lock check-drift "${SPEC_ARGS[@]}" --scoped-unparseables > "$OUT_DIR/spec_lock_drift.txt" 2>&1
DRIFT_EXIT=$?
echo "🔒 verify"
SPEC_LOCK_STRICT=1 cargo-spec-lock verify "${SPEC_ARGS[@]}" --timeout "$SPEC_LOCK_Z3_TIMEOUT_SECS" \
  --json-out "$OUT_DIR/spec_lock_verify.json" --format human > "$OUT_DIR/spec_lock_output.txt" 2>&1
VERIFY_EXIT=$?
set -e
tail -20 "$OUT_DIR/spec_lock_output.txt"

[[ -s "$OUT_DIR/spec_lock_verify.json" ]] || { echo "❌ spec_lock_verify.json missing" >&2; exit 1; }

jq -n \
  --arg consensus_version "$CONSENSUS_VERSION" \
  --arg consensus_crate_sha256 "$CRATE_SHA" \
  --arg tool_version "$TOOL_VERSION" \
  --arg spec_git_sha "$SPEC_GIT_SHA" \
  --arg spec_meta_version "$SPEC_META_VERSION" \
  --arg spec_hash "$SPEC_HASH" \
  --argjson drift_exit "$DRIFT_EXIT" \
  --argjson verify_exit "$VERIFY_EXIT" \
  --arg verify_json_sha256 "$(sha256sum "$OUT_DIR/spec_lock_verify.json" | cut -d' ' -f1)" \
  --arg verify_output_sha256 "$(sha256sum "$OUT_DIR/spec_lock_output.txt" | cut -d' ' -f1)" \
  --slurpfile verify "$OUT_DIR/spec_lock_verify.json" \
  --rawfile spec_files "$OUT_DIR/spec_files.sha256" \
  '{
    checked_crate: { name: "blvm-consensus", version: $consensus_version, crate_sha256: $consensus_crate_sha256 },
    tool: { name: "blvm-spec-lock", version: $tool_version },
    spec: {
      repository: "BTCDecoded/blvm-spec",
      git_sha: $spec_git_sha,
      spec_meta_version: $spec_meta_version,
      spec_hash: $spec_hash,
      spec_hash_rule: "sha256 of spec_files.sha256 (one \"<sha256>  <file>\" line per spec file, in --spec-path order)",
      files: ($spec_files | split("\n") | map(select(length > 0) | split("  ") | {sha256: .[0], file: .[1]}))
    },
    check_drift: { exit_code: $drift_exit, gating: false },
    verify: {
      exit_code: $verify_exit,
      strict: true,
      summary: $verify[0].summary,
      report_sha256: $verify_json_sha256,
      log_sha256: $verify_output_sha256
    },
    note: "A passing spec-lock check is not a proof of conformance. summary.evidence says which kind of evidence backs each row."
  }' > "$OUT_DIR/spec_lock_evidence.json"

echo "spec_hash=${SPEC_HASH}"
jq '.verify.summary' "$OUT_DIR/spec_lock_evidence.json"
if [[ "$VERIFY_EXIT" -ne 0 ]]; then
  echo "❌ cargo spec-lock verify failed (exit ${VERIFY_EXIT}) for blvm-consensus ${CONSENSUS_VERSION}" >&2
  exit "$VERIFY_EXIT"
fi
echo "✅ spec-lock evidence written to ${OUT_DIR}"
