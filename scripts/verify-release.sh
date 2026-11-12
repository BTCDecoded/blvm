#!/usr/bin/env bash
# Operator release check: verify a downloaded blvm release before running it.
#
# Usage:
#   scripts/verify-release.sh --tag v0.1.42 [--file blvm-0.1.42-linux-x86_64-musl ...] [--dir DIR] [--policy release-keys/policy.json]
#
# Checks, in order:
#   1. sha256 of each requested file against checksums.sha256
#   2. Sigstore build provenance (gh attestation verify) for each file, the bundle and the attestation
#   3. the verification bundle agrees with the published attestation and checksums
#   4. maintainer signatures on the bundle meet the threshold in the LOCAL policy file
# and prints the spec-lock result recorded for the release.
#
# Requires: gh, jq, sha256sum; blvm-verify-binary when the policy threshold is above 0.
set -euo pipefail

REPO="${BLVM_REPO:-BTCDecoded/blvm}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POLICY="$(dirname "$SCRIPT_DIR")/release-keys/policy.json"
TAG="" DIR="" FILES=()
usage() { sed -n '2,15p' "$0" >&2; exit 2; }
while [[ $# -gt 0 ]]; do
  case "$1" in
    --tag) TAG="$2"; shift 2 ;;
    --file) FILES+=("$2"); shift 2 ;;
    --dir) DIR="$2"; shift 2 ;;
    --policy) POLICY="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown argument: $1" >&2; usage ;;
  esac
done
[[ -n "$TAG" ]] || usage
for tool in gh jq sha256sum; do
  command -v "$tool" >/dev/null 2>&1 || { echo "❌ ${tool} not found on PATH" >&2; exit 1; }
done
[[ -f "$POLICY" ]] || { echo "❌ policy file not found: $POLICY" >&2; exit 1; }
POLICY="$(cd "$(dirname "$POLICY")" && pwd)/$(basename "$POLICY")"
POLICY_DIR="$(dirname "$POLICY")"

fail() { echo "❌ $*" >&2; exit 1; }
ok() { echo "✅ $*"; }

VERSION="${TAG#v}"
VERSION="${VERSION%-unverified}"
PREFIX="blvm-${TAG}"
BUNDLE="${PREFIX}-verification-bundle.tar.gz"
DIR="${DIR:-$(mktemp -d "/tmp/blvm-verify-${TAG}-XXXX")}"
mkdir -p "$DIR"
DIR="$(cd "$DIR" && pwd)"
[[ ${#FILES[@]} -gt 0 ]] || FILES=("blvm-${VERSION}-linux-x86_64-musl")

PATTERNS=(--pattern checksums.sha256 --pattern "$BUNDLE" --pattern "${PREFIX}-attestation.json" --pattern "${PREFIX}-verification-bundle.*.sig.json")
for f in "${FILES[@]}"; do PATTERNS+=(--pattern "$f"); done
gh release download "$TAG" --repo "$REPO" --dir "$DIR" --clobber "${PATTERNS[@]}"
cd "$DIR"

[[ "$TAG" != *-unverified ]] || echo "⚠️  ${TAG} was released with CI gates skipped"

# 1. checksums
for f in "${FILES[@]}"; do
  [[ -f "$f" ]] || fail "release has no file named $f"
  line="$(awk -v f="$f" '{ n=$2; sub(/^\*?\.?\/?/, "", n); if (n == f) print }' checksums.sha256)"
  [[ -n "$line" ]] || fail "$f is not listed in checksums.sha256"
  echo "$line" | sha256sum -c --quiet - || fail "$f does not match checksums.sha256"
done
ok "checksums match"

# 2. provenance
for f in "${FILES[@]}" checksums.sha256 "$BUNDLE" "${PREFIX}-attestation.json"; do
  gh attestation verify "$f" --repo "$REPO" >/dev/null || fail "provenance check failed for $f"
done
ok "Sigstore provenance verified (built by ${REPO} CI)"

# 3. bundle consistency
rm -rf bundle && mkdir bundle && tar -xzf "$BUNDLE" -C bundle
B="bundle/${PREFIX}-verification-bundle"
A="$B/attestation.json"
cmp -s "$A" "${PREFIX}-attestation.json" || fail "bundle attestation differs from the published attestation"
cmp -s "$B/checksums.sha256" checksums.sha256 || fail "bundle checksums differ from the published checksums.sha256"
[[ "$(jq -r '.build.build_config_hash' "$A")" == "$(sha256sum "$B/build-config.json" | cut -d' ' -f1)" ]] \
  || fail "build_config_hash does not match build-config.json"
[[ "$(jq -r '.spec_lock.verify.report_sha256' "$A")" == "$(sha256sum "$B/spec_lock_verify.json" | cut -d' ' -f1)" ]] \
  || fail "spec-lock report does not match the attestation"
[[ "$(jq -r '.spec_lock.spec.spec_hash' "$A")" == "$(sha256sum "$B/spec_files.sha256" | cut -d' ' -f1)" ]] \
  || fail "spec_hash does not match spec_files.sha256"
ok "verification bundle is consistent"

echo
echo "Release ${TAG} from commit $(jq -r '.source.commit' "$A")"
echo "Spec-lock check of the linked consensus code:"
jq '{checked_crate: .spec_lock.checked_crate, spec_git_sha: .spec_lock.spec.git_sha, verify_exit_code: .spec_lock.verify.exit_code, summary: .spec_lock.verify.summary}' "$A"
echo "(A passing spec-lock check is not a proof of conformance. The counts show how much is covered.)"
echo

# 4. maintainer signatures
THRESHOLD="$(jq -r '.threshold' "$POLICY")"
TOTAL="$(jq -r '.maintainers | length' "$POLICY")"
if [[ "$THRESHOLD" -eq 0 ]]; then
  echo "⚠️  Maintainer signatures not enforced: ${POLICY} enrolls no keys (threshold 0)."
  exit 0
fi
command -v blvm-verify-binary >/dev/null 2>&1 || fail "blvm-verify-binary not found (cargo install blvm-sdk --bins)"
SIGS=() PUBS=()
while IFS=$'\t' read -r name keyfile; do
  PUBS+=("$POLICY_DIR/$keyfile")
  sig="${PREFIX}-verification-bundle.${name}.sig.json"
  [[ -f "$sig" ]] && SIGS+=("$sig")
done < <(jq -r '.maintainers[] | [.name, .public_key_file] | @tsv' "$POLICY")
echo "Signatures from enrolled maintainers: ${#SIGS[@]} of ${TOTAL} (need ${THRESHOLD})"
[[ ${#SIGS[@]} -ge "$THRESHOLD" ]] || fail "not enough maintainer signatures"
join() { local IFS=,; echo "$*"; }
blvm-verify-binary --signatures "$(join "${SIGS[@]}")" --pubkeys "$(join "${PUBS[@]}")" \
  --threshold "${THRESHOLD}-of-${TOTAL}" bundle --file "$BUNDLE" \
  --source-hash "$(jq -r '.source.source_hash' "$A")" \
  --build-config-hash "$(jq -r '.build.build_config_hash' "$A")" \
  --spec-hash "$(jq -r '.spec_lock.spec.spec_hash' "$A")" \
  || fail "maintainer signature threshold not met"
ok "maintainer signatures meet ${THRESHOLD}-of-${TOTAL}"
