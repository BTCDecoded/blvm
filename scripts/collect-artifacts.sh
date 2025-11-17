#!/bin/bash
#
# Collect all built binaries into release artifacts
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMONS_DIR="$(dirname "$SCRIPT_DIR")"
PARENT_DIR="$(dirname "$COMMONS_DIR")"
ARTIFACTS_DIR="${COMMONS_DIR}/artifacts"
PLATFORM="${1:-linux-x86_64}"
VARIANT="${2:-base}"  # base or experimental

# Validate variant
if [ "$VARIANT" != "base" ] && [ "$VARIANT" != "experimental" ]; then
    echo "ERROR: Invalid variant: $VARIANT (must be 'base' or 'experimental')"
    exit 1
fi

# Determine target directory and binary extension based on platform
if [[ "$PLATFORM" == *"windows"* ]]; then
    TARGET_DIR="target/x86_64-pc-windows-gnu/release"
    BIN_EXT=".exe"
    if [ "$VARIANT" = "base" ]; then
        BINARIES_DIR="${ARTIFACTS_DIR}/binaries-windows"
    else
        BINARIES_DIR="${ARTIFACTS_DIR}/binaries-experimental-windows"
    fi
else
    TARGET_DIR="target/release"
    BIN_EXT=""
    if [ "$VARIANT" = "base" ]; then
        BINARIES_DIR="${ARTIFACTS_DIR}/binaries"
    else
        BINARIES_DIR="${ARTIFACTS_DIR}/binaries-experimental"
    fi
fi

# Binary mapping
declare -A REPO_BINARIES
REPO_BINARIES[bllvm]="bllvm"
REPO_BINARIES[bllvm-sdk]="bllvm-keygen bllvm-sign bllvm-verify"
REPO_BINARIES[bllvm-commons]="bllvm-commons key-manager test-content-hash test-content-hash-standalone"

log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[SUCCESS] $1"
}

log_warn() {
    echo "[WARN] $1"
}

collect_repo_binaries() {
    local repo=$1
    local repo_path="${PARENT_DIR}/${repo}"
    local binaries="${REPO_BINARIES[$repo]:-}"
    
    if [ -z "$binaries" ]; then
        return 0  # No binaries for this repo
    fi
    
    for binary in $binaries; do
        local bin_path="${repo_path}/${TARGET_DIR}/${binary}${BIN_EXT}"
        
        if [ -f "$bin_path" ]; then
            cp "$bin_path" "${BINARIES_DIR}/"
            log_success "Collected: ${binary}${BIN_EXT}"
        else
            log_warn "Binary not found: ${bin_path}"
        fi
    done
}

generate_checksums() {
    log_info "Generating checksums for ${PLATFORM} (variant: ${VARIANT})..."
    
    pushd "$BINARIES_DIR" > /dev/null
    
    # Base variant uses SHA256SUMS-{platform}, experimental uses SHA256SUMS-experimental-{platform}
    local checksum_file
    if [ "$VARIANT" = "base" ]; then
        checksum_file="${ARTIFACTS_DIR}/SHA256SUMS-${PLATFORM}"
    else
        checksum_file="${ARTIFACTS_DIR}/SHA256SUMS-experimental-${PLATFORM}"
    fi
    if command -v sha256sum &> /dev/null; then
        sha256sum * > "$checksum_file" 2>/dev/null || true
        log_success "Generated ${checksum_file}"
    elif command -v shasum &> /dev/null; then
        shasum -a 256 * > "$checksum_file" 2>/dev/null || true
        log_success "Generated ${checksum_file}"
    else
        log_warn "No checksum tool found (sha256sum or shasum)"
    fi
    
    popd > /dev/null
}

create_archives() {
    log_info "Creating release archives for ${PLATFORM} (variant: ${VARIANT})..."
    
    # Base variant uses bllvm-{version}-{platform}, experimental uses bllvm-experimental-{version}-{platform}
    # Note: version will be added by create-release.sh, here we just set the base name
    local archive_base
    if [ "$VARIANT" = "base" ]; then
        archive_base="bllvm-${PLATFORM}"
    else
        archive_base="bllvm-experimental-${PLATFORM}"
    fi
    
    # Checksum file name
    local checksum_file
    if [ "$VARIANT" = "base" ]; then
        checksum_file="SHA256SUMS-${PLATFORM}"
    else
        checksum_file="SHA256SUMS-experimental-${PLATFORM}"
    fi
    
    pushd "$ARTIFACTS_DIR" > /dev/null
    
    # Determine binaries directory name
    local bin_dir_name
    if [[ "$PLATFORM" == *"windows"* ]]; then
        if [ "$VARIANT" = "base" ]; then
            bin_dir_name="binaries-windows"
        else
            bin_dir_name="binaries-experimental-windows"
        fi
    else
        if [ "$VARIANT" = "base" ]; then
            bin_dir_name="binaries"
        else
            bin_dir_name="binaries-experimental"
        fi
    fi
    
    # Create tar.gz (skip for Windows, use zip instead)
    if [[ "$PLATFORM" != *"windows"* ]] && [ -d "$bin_dir_name" ] && [ "$(ls -A $bin_dir_name)" ]; then
        tar -czf "${archive_base}.tar.gz" "$bin_dir_name/" "$checksum_file" 2>/dev/null || true
        log_success "Created: ${archive_base}.tar.gz"
    fi
        
    # Create zip (preferred for Windows, also available for Linux)
    if command -v zip &> /dev/null && [ -d "$bin_dir_name" ] && [ "$(ls -A $bin_dir_name)" ]; then
        zip -r "${archive_base}.zip" "$bin_dir_name/" "$checksum_file" 2>/dev/null || true
        log_success "Created: ${archive_base}.zip"
    fi
    
    popd > /dev/null
}

main() {
    log_info "Collecting artifacts for ${PLATFORM} (variant: ${VARIANT})..."
    
    mkdir -p "$BINARIES_DIR"
    
    # Collect binaries from each repo
    # Note: bllvm-commons may not cross-compile easily, skip for Windows for now
    if [[ "$PLATFORM" == *"windows"* ]]; then
        for repo in bllvm bllvm-sdk; do
            collect_repo_binaries "$repo"
        done
    else
        for repo in bllvm bllvm-sdk bllvm-commons; do
        collect_repo_binaries "$repo"
    done
    fi
    
    # Generate checksums
    if [ "$(ls -A ${BINARIES_DIR} 2>/dev/null)" ]; then
        generate_checksums
        create_archives
        log_success "Artifacts collected in: ${ARTIFACTS_DIR}"
    else
        log_warn "No binaries found to collect for ${PLATFORM}"
    fi
}

main "$@"

