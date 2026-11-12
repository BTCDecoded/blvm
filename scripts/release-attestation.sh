#!/usr/bin/env bash
# Write the release attestation and verification bundle for a blvm release.
#
# Outputs, in ARTIFACTS_DIR:
#   blvm-<tag>-build-config.json       inputs that determine the binaries
#   blvm-<tag>-attestation.json        what was built, from what, and what checks ran
#   blvm-<tag>-verification-bundle.tar.gz   the two files above + checksums + spec-lock evidence
#
# Maintainers sign the bundle (scripts/sign-release.sh) after rebuilding the
# static musl binaries themselves. The signed message is
#   bundle:<bundle_sha256>:<source_hash>:<build_config_hash>:<spec_hash>
# (blvm-sign-binary bundle), so one signature covers the artifact hashes, the
# source tree, the build inputs, and the exact spec text that was checked.
#
# Env (required):
#   VERSION, VERSION_TAG
#   ARTIFACTS_DIR   staged release files (checksums.sha256 already written)
#   EVIDENCE_DIR    output of scripts/spec-lock-evidence.sh
#   SOURCE_COMMIT   commit the release was built from
# Env (optional):
#   GATES_JSON      JSON object of CI gate results, e.g. {"test":"success",...}
#   RUN_URL         CI run URL
#   SOURCE_DATE_EPOCH  timestamp for archive entries (default: commit time)
set -euo pipefail

VERSION="${VERSION:?}"
VERSION_TAG="${VERSION_TAG:?}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:?}"
EVIDENCE_DIR="${EVIDENCE_DIR:?}"
SOURCE_COMMIT="${SOURCE_COMMIT:?}"
GATES_JSON="${GATES_JSON:-}"
[[ -n "$GATES_JSON" ]] || GATES_JSON='{}'
RUN_URL="${RUN_URL:-}"

command -v jq >/dev/null 2>&1 || { echo "❌ jq required" >&2; exit 1; }
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$REPO_ROOT"
SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-$(git log -1 --format=%ct "$SOURCE_COMMIT")}"

for f in "$ARTIFACTS_DIR/checksums.sha256" "$EVIDENCE_DIR/spec_lock_evidence.json" \
         "$EVIDENCE_DIR/spec_lock_verify.json" "$EVIDENCE_DIR/spec_lock_output.txt" \
         "$EVIDENCE_DIR/spec_files.sha256"; do
  [[ -s "$f" ]] || { echo "❌ missing input: $f" >&2; exit 1; }
done

PREFIX="blvm-${VERSION_TAG}"
BUILD_CONFIG="$ARTIFACTS_DIR/${PREFIX}-build-config.json"
ATTESTATION="$ARTIFACTS_DIR/${PREFIX}-attestation.json"
BUNDLE="$ARTIFACTS_DIR/${PREFIX}-verification-bundle.tar.gz"

# --- source_hash: content of the tagged tree, independent of git's archive format.
SOURCE_HASH="$(git ls-tree -r --full-tree "$SOURCE_COMMIT" | sha256sum | cut -d' ' -f1)"

# --- build config: everything a rebuilder must match.
# shellcheck source=ci-portable-cross-features.sh
source "$SCRIPT_DIR/ci-portable-cross-features.sh"
ZIGLANG_VERSION_DEFAULT="$(sed -nE 's/^ZIGLANG_VERSION="\$\{ZIGLANG_VERSION:-([^}]+)\}"/\1/p' "$SCRIPT_DIR/ci-build-musl.sh")"
ZIGBUILD_VERSION_DEFAULT="$(sed -nE 's/^CARGO_ZIGBUILD_VERSION="\$\{CARGO_ZIGBUILD_VERSION:-([^}]+)\}"/\1/p' "$SCRIPT_DIR/ci-build-musl.sh")"
jq -n -S \
  --arg version "$VERSION" \
  --arg toolchain_channel "$(sed -nE 's/^channel *= *"([^"]+)".*/\1/p' rust-toolchain.toml)" \
  --arg rustc "$(rustc -V 2>/dev/null || echo unknown)" \
  --arg cargo "$(cargo -V 2>/dev/null || echo unknown)" \
  --arg cargo_lock_sha256 "$(sha256sum Cargo.lock | cut -d' ' -f1)" \
  --arg rust_toolchain_sha256 "$(sha256sum rust-toolchain.toml | cut -d' ' -f1)" \
  --arg linux_features "$BLVM_LINUX_RELEASE_FEATURES" \
  --arg portable_features "$BLVM_PORTABLE_CROSS_FEATURES" \
  --arg zig "${ZIGLANG_VERSION:-$ZIGLANG_VERSION_DEFAULT}" \
  --arg zigbuild "${CARGO_ZIGBUILD_VERSION:-$ZIGBUILD_VERSION_DEFAULT}" \
  '{
    schema: "blvm-build-config/v1",
    version: $version,
    version_bump: "scripts/release-bump-version.sh <version> applied to the tagged tree before building",
    toolchain: { channel: $toolchain_channel, rustc: $rustc, cargo: $cargo, rust_toolchain_toml_sha256: $rust_toolchain_sha256 },
    cargo_lock_sha256_after_bump: $cargo_lock_sha256,
    env: { BLVM_SECP256K1_NO_GPU: "1 for cross and musl builds", remap_path_prefix: ["$HOME=/build", "<sysroot>=/rustlib", "<repo>=/src"] },
    targets: {
      "x86_64-unknown-linux-gnu": { features: "default (cargo build --release --locked)", rebuildable_by_maintainers: false, why_not: "may compile CUDA kernels when nvcc is on the host; links host glibc" },
      "aarch64-unknown-linux-gnu": { features: $linux_features, script: "scripts/ci-build-aarch64.sh", rebuildable_by_maintainers: false, why_not: "links the cross toolchain glibc" },
      "x86_64-pc-windows-gnu": { features: $portable_features, rebuildable_by_maintainers: false, why_not: "links host MinGW runtime" },
      "x86_64-unknown-linux-musl": { features: $linux_features, script: "scripts/ci-build-musl.sh", static: true, zig: $zig, cargo_zigbuild: $zigbuild, rebuildable_by_maintainers: true },
      "aarch64-unknown-linux-musl": { features: $linux_features, script: "scripts/ci-build-musl.sh", static: true, zig: $zig, cargo_zigbuild: $zigbuild, rebuildable_by_maintainers: true }
    }
  }' > "$BUILD_CONFIG"
BUILD_CONFIG_HASH="$(sha256sum "$BUILD_CONFIG" | cut -d' ' -f1)"
SPEC_HASH="$(jq -r '.spec.spec_hash' "$EVIDENCE_DIR/spec_lock_evidence.json")"

# --- artifact list from the staged checksums (every uploaded file).
ARTIFACTS_JSON="$(awk '{ f=$2; sub(/^\*?\.?\/?/, "", f); printf "{\"name\":\"%s\",\"sha256\":\"%s\"}\n", f, $1 }' \
  "$ARTIFACTS_DIR/checksums.sha256" | jq -s 'map(select(.name != "checksums.sha256")) | sort_by(.name)')"

jq -n -S \
  --arg version "$VERSION" \
  --arg tag "$VERSION_TAG" \
  --arg repository "${GITHUB_REPOSITORY:-BTCDecoded/blvm}" \
  --arg commit "$SOURCE_COMMIT" \
  --arg source_hash "$SOURCE_HASH" \
  --arg build_config_hash "$BUILD_CONFIG_HASH" \
  --arg spec_hash "$SPEC_HASH" \
  --arg checksums_sha256 "$(sha256sum "$ARTIFACTS_DIR/checksums.sha256" | cut -d' ' -f1)" \
  --arg run_url "$RUN_URL" \
  --argjson artifacts "$ARTIFACTS_JSON" \
  --argjson gates "$GATES_JSON" \
  --slurpfile evidence "$EVIDENCE_DIR/spec_lock_evidence.json" \
  '{
    schema: "blvm-release-attestation/v1",
    release: { name: "blvm", version: $version, tag: $tag, repository: $repository, unverified: ($tag | endswith("-unverified")) },
    source: {
      commit: $commit,
      source_hash: $source_hash,
      source_hash_rule: "sha256 of `git ls-tree -r --full-tree <commit>` output"
    },
    build: {
      config_file: ("blvm-" + $tag + "-build-config.json"),
      build_config_hash: $build_config_hash,
      ci_double_build: false,
      reproducibility: "Maintainers rebuild the musl static binaries from the tag and sign only on a hash match (scripts/sign-release.sh)."
    },
    artifacts: $artifacts,
    checksums_sha256: $checksums_sha256,
    spec_lock: ($evidence[0] + { report_files: ["spec_lock_verify.json", "spec_lock_output.txt", "spec_lock_drift.txt", "spec_files.sha256"] }),
    ci_gates: $gates,
    ci_run: $run_url,
    provenance: "Each artifact also has a Sigstore build-provenance attestation from this CI run. Check with: gh attestation verify <file> --repo BTCDecoded/blvm",
    maintainer_signatures: {
      tool: "blvm-sign-binary bundle / blvm-verify-binary bundle (blvm-sdk)",
      message: "bundle:<sha256 of verification bundle>:<source_hash>:<build_config_hash>:<spec_hash>",
      policy: "release-keys/policy.json",
      file_pattern: ("blvm-" + $tag + "-verification-bundle.<maintainer>.sig.json")
    }
  }' > "$ATTESTATION"

# --- deterministic bundle
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
B="$STAGE/${PREFIX}-verification-bundle"
mkdir -p "$B"
cp "$ATTESTATION" "$B/attestation.json"
cp "$BUILD_CONFIG" "$B/build-config.json"
cp "$ARTIFACTS_DIR/checksums.sha256" "$B/checksums.sha256"
for f in spec_lock_evidence.json spec_lock_verify.json spec_lock_output.txt spec_files.sha256 spec_lock_drift.txt; do
  [[ -f "$EVIDENCE_DIR/$f" ]] && cp "$EVIDENCE_DIR/$f" "$B/$f"
done
(cd "$STAGE" && tar --sort=name --mtime="@${SOURCE_DATE_EPOCH}" --owner=0 --group=0 --numeric-owner \
  --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
  -cf - "${PREFIX}-verification-bundle" | gzip -n -9 > "$BUNDLE")
BUNDLE_HASH="$(sha256sum "$BUNDLE" | cut -d' ' -f1)"

echo "=== release attestation ==="
echo "attestation:        $(basename "$ATTESTATION")"
echo "bundle:             $(basename "$BUNDLE") ${BUNDLE_HASH}"
echo "source_hash:        ${SOURCE_HASH}"
echo "build_config_hash:  ${BUILD_CONFIG_HASH}"
echo "spec_hash:          ${SPEC_HASH}"
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  {
    echo "bundle=$(basename "$BUNDLE")"
    echo "bundle_sha256=${BUNDLE_HASH}"
    echo "source_hash=${SOURCE_HASH}"
    echo "build_config_hash=${BUILD_CONFIG_HASH}"
    echo "spec_hash=${SPEC_HASH}"
  } >> "$GITHUB_OUTPUT"
fi
