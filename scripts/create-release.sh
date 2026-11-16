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
    case "${VERSION_TAG}" in
        *prerelease*)
            echo "release notes refuse ${VERSION_TAG}: prerelease is not a project version" >&2
            exit 2
            ;;
        v0.[2-9].*|v[1-9]*|0.[2-9].*|[1-9]*)
            ;;
        *)
            echo "release notes refuse ${VERSION_TAG}: project versions start at 0.2" >&2
            exit 2
            ;;
    esac
    mkdir -p "$ARTIFACTS_DIR"
    python3 "${SCRIPT_DIR}/release/build_release_notes.py" --accumulate --repo "${COMMONS_DIR}"
    cp "${COMMONS_DIR}/docs/release/RELEASE_NOTES.md" "$notes_file"
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

        for ext in tar.gz zip; do
            if [ -f "blvm-minimal-${platform}.${ext}" ]; then
                mv "blvm-minimal-${platform}.${ext}" "blvm-minimal-${VERSION_TAG}-${platform}.${ext}"
                log_success "Renamed: blvm-minimal-${platform}.${ext} -> blvm-minimal-${VERSION_TAG}-${platform}.${ext}"
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
