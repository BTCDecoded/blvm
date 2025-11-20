#!/bin/bash
#
# Release System Dependency Validation Script
# Validates the dependency chain from bottom (bllvm-consensus) to top (bllvm-commons)
# Uses GitHub API to check repository status and workflows
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
ORG="BTCDecoded"

# Dependency order (bottom to top)
declare -a REPOS=(
    "bllvm-consensus"
    "bllvm-protocol"
    "bllvm-node"
    "bllvm-sdk"
    "bllvm"
    "bllvm-commons"
)

# Dependency relationships
declare -A DEPS
DEPS[bllvm-consensus]=""
DEPS[bllvm-protocol]="bllvm-consensus"
DEPS[bllvm-node]="bllvm-protocol"
DEPS[bllvm-sdk]="bllvm-node"
DEPS[bllvm]="bllvm-node"
DEPS[bllvm-commons]="bllvm-sdk bllvm-protocol"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_api_token() {
    if [ -z "$GITHUB_TOKEN" ]; then
        log_error "GITHUB_TOKEN not set"
        echo "Usage: GITHUB_TOKEN=your_token $0"
        exit 1
    fi
}

validate_cargo_toml() {
    local repo=$1
    # Try multiple possible paths
    local repo_path=""
    if [ -f "../${repo}/Cargo.toml" ]; then
        repo_path="../${repo}"
    elif [ -f "${repo}/Cargo.toml" ]; then
        repo_path="${repo}"
    elif [ -f "${HOME}/src/BTCDecoded/${repo}/Cargo.toml" ]; then
        repo_path="${HOME}/src/BTCDecoded/${repo}"
    else
        log_error "Cargo.toml not found for ${repo}"
        return 1
    fi
    
    log_info "Validating Cargo.toml for ${repo}..."
    
    if [ ! -f "${repo_path}/Cargo.toml" ]; then
        log_error "Cargo.toml not found: ${repo_path}/Cargo.toml"
        return 1
    fi
    
    # Extract package info
    local name=$(grep -E '^name = ' "${repo_path}/Cargo.toml" | head -1 | sed -E 's/^name = "([^"]+)".*/\1/')
    local version=$(grep -E '^version = ' "${repo_path}/Cargo.toml" | head -1 | sed -E 's/^version = "([^"]+)".*/\1/')
    
    if [ -z "$name" ] || [ -z "$version" ]; then
        log_error "Could not extract name or version from Cargo.toml"
        return 1
    fi
    
    log_success "Package: ${name} v${version}"
    
    # Check dependencies
    local deps="${DEPS[$repo]}"
    if [ -n "$deps" ]; then
        log_info "Checking dependencies: ${deps}"
        for dep in $deps; do
            if grep -q "${dep}" "${repo_path}/Cargo.toml"; then
                log_success "  ✓ Dependency found: ${dep}"
            else
                log_warn "  ⚠ Dependency not found: ${dep}"
            fi
        done
    else
        log_success "  ✓ No bllvm dependencies (foundation layer)"
    fi
    
    return 0
}

check_github_repo() {
    local repo=$1
    local full_repo="${ORG}/${repo}"
    
    log_info "Checking GitHub repository: ${full_repo}..."
    
    local response=$(curl -s -w "\n%{http_code}" \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/${full_repo}")
    
    local http_code=$(echo "$response" | tail -n1)
    local body=$(echo "$response" | sed '$d')
    
    if [ "$http_code" != "200" ]; then
        log_error "Failed to access repository: HTTP ${http_code}"
        echo "$body" | jq -r '.message // .' 2>/dev/null || echo "$body"
        return 1
    fi
    
    local repo_name=$(echo "$body" | jq -r '.name')
    local default_branch=$(echo "$body" | jq -r '.default_branch')
    local archived=$(echo "$body" | jq -r '.archived')
    
    log_success "Repository: ${repo_name} (default branch: ${default_branch}, archived: ${archived})"
    
    if [ "$archived" = "true" ]; then
        log_warn "Repository is archived"
    fi
    
    return 0
}

check_workflows() {
    local repo=$1
    local full_repo="${ORG}/${repo}"
    
    log_info "Checking workflows for ${repo}..."
    
    local response=$(curl -s -w "\n%{http_code}" \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/${full_repo}/actions/workflows")
    
    local http_code=$(echo "$response" | tail -n1)
    local body=$(echo "$response" | sed '$d')
    
    if [ "$http_code" != "200" ]; then
        log_error "Failed to get workflows: HTTP ${http_code}"
        return 1
    fi
    
    local workflow_count=$(echo "$body" | jq '.total_count // 0')
    log_info "Found ${workflow_count} workflow(s)"
    
    echo "$body" | jq -r '.workflows[] | "  - \(.name) (\(.state))"' 2>/dev/null || true
    
    # Check for release workflows (should only be in bllvm repo)
    if [ "$repo" != "bllvm" ]; then
        local has_release=$(echo "$body" | jq -r '.workflows[] | select(.path | contains("release")) | .name' | wc -l)
        if [ "$has_release" -gt 0 ]; then
            log_warn "  ⚠ Release workflow found in ${repo} (should only be in bllvm repo)"
        else
            log_success "  ✓ No release workflows (correct - only CI)"
        fi
    fi
    
    return 0
}

check_latest_ci_run() {
    local repo=$1
    local full_repo="${ORG}/${repo}"
    
    log_info "Checking latest CI run for ${repo}..."
    
    # Get workflows first
    local workflows=$(curl -s \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/${full_repo}/actions/workflows")
    
    local ci_workflow=$(echo "$workflows" | jq -r '.workflows[] | select(.path | contains("ci.yml")) | .id' | head -1)
    
    if [ -z "$ci_workflow" ] || [ "$ci_workflow" = "null" ]; then
        log_warn "  ⚠ No CI workflow found"
        return 0
    fi
    
    # Get latest run
    local runs=$(curl -s \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/${full_repo}/actions/workflows/${ci_workflow}/runs?per_page=1")
    
    local run_id=$(echo "$runs" | jq -r '.workflow_runs[0].id // empty')
    local status=$(echo "$runs" | jq -r '.workflow_runs[0].status // "unknown"')
    local conclusion=$(echo "$runs" | jq -r '.workflow_runs[0].conclusion // "pending"')
    local html_url=$(echo "$runs" | jq -r '.workflow_runs[0].html_url // ""')
    
    if [ -n "$run_id" ] && [ "$run_id" != "null" ]; then
        if [ "$conclusion" = "success" ]; then
            log_success "  ✓ Latest CI: ${status} (${conclusion}) - Run ${run_id}"
        elif [ "$conclusion" = "failure" ]; then
            log_error "  ✗ Latest CI: ${status} (${conclusion}) - Run ${run_id}"
            if [ -n "$html_url" ]; then
                echo "    View: ${html_url}"
            fi
        else
            log_info "  → Latest CI: ${status} (${conclusion}) - Run ${run_id}"
        fi
    else
        log_warn "  ⚠ No CI runs found"
    fi
}

validate_repo() {
    local repo=$1
    
    echo ""
    echo "=========================================="
    echo "Validating: ${repo}"
    echo "=========================================="
    
    # Validate Cargo.toml
    if ! validate_cargo_toml "$repo"; then
        log_error "Cargo.toml validation failed for ${repo}"
        return 1
    fi
    
    # Check GitHub repository
    if ! check_github_repo "$repo"; then
        log_error "GitHub repository check failed for ${repo}"
        return 1
    fi
    
    # Check workflows
    if ! check_workflows "$repo"; then
        log_warn "Workflow check had issues for ${repo} (continuing...)"
    fi
    
    # Check latest CI run
    check_latest_ci_run "$repo"
    
    log_success "Validation complete for ${repo}"
    return 0
}

main() {
    echo "=========================================="
    echo "Release System Dependency Validation"
    echo "=========================================="
    echo ""
    
    check_api_token
    
    log_info "Validating dependency chain from bottom to top..."
    log_info "Order: ${REPOS[*]}"
    echo ""
    
    local failed=0
    for repo in "${REPOS[@]}"; do
        if ! validate_repo "$repo"; then
            failed=$((failed + 1))
        fi
    done
    
    echo ""
    echo "=========================================="
    if [ $failed -eq 0 ]; then
        log_success "All repositories validated successfully!"
    else
        log_error "Validation completed with ${failed} failure(s)"
        exit 1
    fi
    echo "=========================================="
}

main "$@"

