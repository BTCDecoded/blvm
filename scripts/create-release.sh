#!/bin/bash
#
# Create a unified release for BTCDecoded ecosystem
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMONS_DIR="$(dirname "$SCRIPT_DIR")"
ARTIFACTS_DIR="${COMMONS_DIR}/artifacts"

VERSION_TAG="${1:-}"
if [ -z "$VERSION_TAG" ]; then
    echo "Usage: $0 <version-tag>"
    echo "Example: $0 v0.1.0"
    exit 1
fi

log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[SUCCESS] $1"
}

create_release_notes() {
    local notes_file="${ARTIFACTS_DIR}/RELEASE_NOTES.md"

    cat > "$notes_file" <<EOF
# Bitcoin Commons Release ${VERSION_TAG}

Release date: $(date -u +"%Y-%m-%d %H:%M:%S UTC")

## Components

This release includes the following components:

- **blvm-consensus** - Direct mathematical implementation of Bitcoin consensus rules
- **blvm-protocol** - Bitcoin protocol abstraction layer
- **blvm-node** - Minimal Bitcoin node implementation
- **blvm-sdk** - Governance infrastructure and CLI tools
- **blvm-commons** - GitHub App for cryptographic governance enforcement

## Cargo Registry

All library dependencies are published to [crates.io](https://crates.io):

- \`blvm-consensus = "${VERSION_TAG#v}"\`
- \`blvm-protocol = "${VERSION_TAG#v}"\`
- \`blvm-node = "${VERSION_TAG#v}"\`
- \`blvm-sdk = "${VERSION_TAG#v}"\`

You can depend on these crates directly in your \`Cargo.toml\`:

\`\`\`toml
[dependencies]
blvm-consensus = "=${VERSION_TAG#v}"
blvm-protocol = "=${VERSION_TAG#v}"
blvm-node = "=${VERSION_TAG#v}"
\`\`\`

## Release bundle (\`blvm-{version}-{platform}.tar.gz\` / \`.zip\`)

**Purpose**: Standard release matching default \`cargo build --release\` for the blvm workspace (Linux) and the portable Windows feature set used in CI.

**Includes**:
- Core \`blvm\` binary
- \`blvm-mainnet-ibd.toml.example\` — mainnet IBD config template
- \`scripts/start-ibd-mainnet.sh\` — start mainnet sync without building from source
- Associated governance / SDK tools collected by \`collect-artifacts.sh\`

## Binaries Included

- \`blvm\` - Bitcoin reference node
- \`blvm-keygen\` - Key generation tool
- \`blvm-sign\` - Message signing tool
- \`blvm-verify\` - Signature verification tool
- \`blvm-commons\` - Governance application server
- \`key-manager\` - Key management utility
- \`test-content-hash\` - Content hash testing tool
- \`test-content-hash-standalone\` - Standalone content hash test

## Installation

\`\`\`bash
tar xzf blvm-${VERSION_TAG}-linux-x86_64.tar.gz
sha256sum -c SHA256SUMS-blvm-linux-x86_64
./scripts/start-ibd-mainnet.sh --init-config   # optional
BLVM_BACKGROUND=1 ./scripts/start-ibd-mainnet.sh
\`\`\`

(On Windows, extract the \`.zip\` and run \`blvm.exe\` from the archive root.)

## Verification

Verify checksums (per-platform file inside the archive):

\`\`\`bash
sha256sum -c SHA256SUMS-blvm-linux-x86_64
sha256sum -c SHA256SUMS-blvm-windows-x86_64
\`\`\`

Verify component provenance:

\`\`\`bash
# Check release manifest for component versions and hashes
cat release-manifest.json | jq '.'
\`\`\`

Component manifests are available in the \`manifests/\` directory for detailed provenance information.

## Documentation

For more information, visit:
- https://github.com/BTCDecoded
- https://btcdecoded.org

## License

MIT License - see individual repository LICENSE files for details.
EOF

    log_success "Created release notes: ${notes_file}"
}

rename_archives() {
    log_info "Renaming archives to include version tag: ${VERSION_TAG}"

    pushd "$ARTIFACTS_DIR" > /dev/null

    for platform in linux-x86_64 linux-aarch64 windows-x86_64; do
        for ext in tar.gz zip; do
            if [ -f "blvm-${platform}.${ext}" ]; then
                mv "blvm-${platform}.${ext}" "blvm-${VERSION_TAG}-${platform}.${ext}"
                log_success "Renamed: blvm-${platform}.${ext} -> blvm-${VERSION_TAG}-${platform}.${ext}"
            fi
        done

        for ext in tar.gz zip; do
            if [ -f "blvm-governance-${platform}.${ext}" ]; then
                mv "blvm-governance-${platform}.${ext}" "blvm-governance-${VERSION_TAG}-${platform}.${ext}"
                log_success "Renamed: blvm-governance-${platform}.${ext} -> blvm-governance-${VERSION_TAG}-${platform}.${ext}"
            fi
        done
    done

    popd > /dev/null
}

main() {
    log_info "Creating release for tag: ${VERSION_TAG}"

    if [ ! -d "$ARTIFACTS_DIR" ]; then
        log_info "Artifacts directory not found. Run collect-artifacts.sh first."
        log_info "Expected: ${ARTIFACTS_DIR}"
    fi

    create_release_notes
    rename_archives

    log_success "Release created for ${VERSION_TAG}"
    log_info "Release artifacts directory: ${ARTIFACTS_DIR}"
}

main "$@"
