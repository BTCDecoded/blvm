#!/usr/bin/env bash
# Maintainer release signing: check a published blvm release, rebuild its static
# musl binaries from the tag, and sign the verification bundle only if every
# check passes and the rebuilt hashes match the published ones.
#
# Usage:
#   scripts/sign-release.sh --tag v0.1.42 --key ~/keys/me.json --name <maintainer> [--upload] [--workdir DIR]
#
# Requires: gh (logged in), git, jq, cargo/rustup, python3, blvm-sign-binary and
# blvm-verify-binary (cargo install blvm-sdk --bins), plus what scripts/ci-build-musl.sh installs.
# The secret key never leaves this machine; only the signature file is uploaded.
set -euo pipefail

REPO="${BLVM_REPO:-BTCDecoded/blvm}"
TAG="" KEY="" NAME="" UPLOAD=0 WORKDIR=""
usage() { sed -n '2,13p' "$0" >&2; exit 2; }
while [[ $# -gt 0 ]]; do
  case "$1" in
    --tag) TAG="$2"; shift 2 ;;
    --key) KEY="$2"; shift 2 ;;
    --name) NAME="$2"; shift 2 ;;
    --upload) UPLOAD=1; shift ;;
    --workdir) WORKDIR="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown argument: $1" >&2; usage ;;
  esac
done
[[ -n "$TAG" && -n "$KEY" && -n "$NAME" ]] || usage
[[ "$NAME" =~ ^[A-Za-z0-9_-]+$ ]] || { echo "❌ --name must be [A-Za-z0-9_-]" >&2; exit 2; }
[[ -f "$KEY" ]] || { echo "❌ key file not found: $KEY" >&2; exit 2; }
KEY="$(cd "$(dirname "$KEY")" && pwd)/$(basename "$KEY")"
for tool in gh git jq cargo python3 blvm-sign-binary blvm-verify-binary; do
  command -v "$tool" >/dev/null 2>&1 || { echo "❌ ${tool} not found on PATH" >&2; exit 1; }
done

fail() { echo "❌ $*" >&2; exit 1; }
ok() { echo "✅ $*"; }

if [[ "$TAG" == *-unverified ]]; then
  fail "${TAG} skipped CI gates; it is not eligible for maintainer signatures"
fi
VERSION="${TAG#v}"
WORKDIR="${WORKDIR:-$(mktemp -d "/tmp/blvm-sign-${TAG}-XXXX")}"
mkdir -p "$WORKDIR/dl"
WORKDIR="$(cd "$WORKDIR" && pwd)"
DL="$WORKDIR/dl"
PREFIX="blvm-${TAG}"
BUNDLE="${PREFIX}-verification-bundle.tar.gz"
echo "Working in ${WORKDIR}"

# 1. Download the published files we check.
gh release download "$TAG" --repo "$REPO" --dir "$DL" --clobber \
  --pattern "$BUNDLE" --pattern "${PREFIX}-attestation.json" --pattern "${PREFIX}-build-config.json" \
  --pattern checksums.sha256 --pattern "blvm-${VERSION}-linux-*-musl"
ok "downloaded release files"

# 2. Sigstore provenance: these files came from this repo's CI.
for f in "$BUNDLE" "${PREFIX}-attestation.json" checksums.sha256 "blvm-${VERSION}-linux-x86_64-musl" "blvm-${VERSION}-linux-aarch64-musl"; do
  [[ -f "$DL/$f" ]] || fail "missing release file: $f"
  gh attestation verify "$DL/$f" --repo "$REPO" >/dev/null || fail "provenance check failed for $f"
done
ok "Sigstore provenance verified"

# 3. Bundle contents agree with the published files.
(cd "$WORKDIR" && rm -rf bundle && mkdir bundle && tar -xzf "$DL/$BUNDLE" -C bundle)
B="$WORKDIR/bundle/${PREFIX}-verification-bundle"
cmp -s "$B/attestation.json" "$DL/${PREFIX}-attestation.json" || fail "attestation.json in bundle differs from the published one"
cmp -s "$B/build-config.json" "$DL/${PREFIX}-build-config.json" || fail "build-config.json in bundle differs from the published one"
cmp -s "$B/checksums.sha256" "$DL/checksums.sha256" || fail "checksums.sha256 in bundle differs from the published one"
(cd "$DL" && grep -E "  (\./)?blvm-${VERSION}-linux-(x86_64|aarch64)-musl$" checksums.sha256 | sha256sum -c --quiet) \
  || fail "published musl binaries do not match checksums.sha256"
A="$B/attestation.json"
[[ "$(jq -r '.release.tag' "$A")" == "$TAG" ]] || fail "attestation is for a different tag"
[[ "$(jq -r '.release.unverified' "$A")" == "false" ]] || fail "attestation marks this release unverified"
[[ "$(jq -r '.build.build_config_hash' "$A")" == "$(sha256sum "$B/build-config.json" | cut -d' ' -f1)" ]] \
  || fail "build_config_hash does not match build-config.json"
[[ "$(jq -r '.checksums_sha256' "$A")" == "$(sha256sum "$B/checksums.sha256" | cut -d' ' -f1)" ]] \
  || fail "checksums_sha256 does not match checksums.sha256"
[[ "$(jq -r '.spec_lock.verify.exit_code' "$A")" == "0" ]] || fail "spec-lock verify did not pass for this release"
[[ "$(jq -r '.spec_lock.verify.report_sha256' "$A")" == "$(sha256sum "$B/spec_lock_verify.json" | cut -d' ' -f1)" ]] \
  || fail "spec_lock_verify.json does not match the hash in the attestation"
[[ "$(jq -r '.spec_lock.spec.spec_hash' "$A")" == "$(sha256sum "$B/spec_files.sha256" | cut -d' ' -f1)" ]] \
  || fail "spec_hash does not match spec_files.sha256"
ok "bundle is consistent"

# 4. Source: the tag's tree is what the attestation names.
COMMIT="$(jq -r '.source.commit' "$A")"
SRC="$WORKDIR/src"
rm -rf "$SRC"
git clone --quiet --depth 1 --branch "$TAG" "https://github.com/${REPO}.git" "$SRC"
[[ "$(git -C "$SRC" rev-parse HEAD)" == "$COMMIT" ]] || fail "tag ${TAG} does not point at attested commit ${COMMIT}"
SOURCE_HASH="$(git -C "$SRC" ls-tree -r --full-tree HEAD | sha256sum | cut -d' ' -f1)"
[[ "$SOURCE_HASH" == "$(jq -r '.source.source_hash' "$A")" ]] || fail "source_hash mismatch"
ok "source tree matches (${COMMIT})"

# 5. Rebuild the static musl binaries exactly as CI did.
(
  cd "$SRC"
  awk '/^\[patch\.crates-io\]/ { skip = 1; next } skip && /^\[/ { skip = 0 } !skip { print }' Cargo.toml > Cargo.toml.tmp
  mv Cargo.toml.tmp Cargo.toml
  bash scripts/release-bump-version.sh "$VERSION"
  LOCK_SHA="$(sha256sum Cargo.lock | cut -d' ' -f1)"
  [[ "$LOCK_SHA" == "$(jq -r '.cargo_lock_sha256_after_bump' "$B/build-config.json")" ]] \
    || { echo "❌ Cargo.lock after bump differs from build-config.json" >&2; exit 1; }
  for arch in x86_64 aarch64; do
    bash scripts/ci-build-musl.sh "$WORKDIR/target" "$VERSION" "$arch"
  done
)
MISMATCH=0
for arch in x86_64 aarch64; do
  f="blvm-${VERSION}-linux-${arch}-musl"
  want="$(sha256sum "$DL/$f" | cut -d' ' -f1)"
  got="$(sha256sum "$SRC/$f" | cut -d' ' -f1)"
  if [[ "$want" == "$got" ]]; then
    ok "rebuilt ${f} matches (${got})"
  else
    echo "❌ rebuilt ${f} ${got} != published ${want}" >&2
    MISMATCH=1
  fi
done
if [[ "$MISMATCH" -ne 0 ]]; then
  echo "Not signing. Compare the two binaries (for example with diffoscope) to find the difference:" >&2
  echo "  ${DL}/blvm-${VERSION}-linux-<arch>-musl  vs  ${SRC}/blvm-${VERSION}-linux-<arch>-musl" >&2
  exit 1
fi

# 6. Sign the bundle and check the signature with our own public key.
SPEC_HASH="$(jq -r '.spec_lock.spec.spec_hash' "$A")"
BUILD_CONFIG_HASH="$(jq -r '.build.build_config_hash' "$A")"
SIG="$WORKDIR/${PREFIX}-verification-bundle.${NAME}.sig.json"
blvm-sign-binary --key "$KEY" --output "$SIG" bundle \
  --file "$DL/$BUNDLE" --source-hash "$SOURCE_HASH" --build-config-hash "$BUILD_CONFIG_HASH" --spec-hash "$SPEC_HASH" >/dev/null
PUB="$WORKDIR/${NAME}.pub.json"
jq '{public_key}' "$KEY" > "$PUB"
blvm-verify-binary --signatures "$SIG" --pubkeys "$PUB" bundle \
  --file "$DL/$BUNDLE" --source-hash "$SOURCE_HASH" --build-config-hash "$BUILD_CONFIG_HASH" --spec-hash "$SPEC_HASH" >/dev/null \
  || fail "own signature did not verify"
ok "signed: ${SIG}"

echo
echo "Spec-lock result you are signing off on:"
jq '{checked_crate: .spec_lock.checked_crate, spec_git_sha: .spec_lock.spec.git_sha, summary: .spec_lock.verify.summary}' "$A"

if [[ "$UPLOAD" -eq 1 ]]; then
  gh release upload "$TAG" "$SIG" --repo "$REPO"
  ok "uploaded $(basename "$SIG") to ${TAG}"
else
  echo "Upload with: gh release upload ${TAG} ${SIG} --repo ${REPO}"
fi
