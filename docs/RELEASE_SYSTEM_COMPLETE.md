# Release System - Complete and Verified

## ✅ System Status: COMPLETE

The Bitcoin Commons release system is now complete, consolidated, and ready for use.

## Workflow Structure

### Primary Release Workflows

#### 1. `release.yml` ✅ **OFFICIAL RELEASE**
- **Location**: `bllvm/.github/workflows/release.yml`
- **Trigger**: 
  - **Automatic**: Push to `main` branch (any repo)
  - **Manual**: `workflow_dispatch` with optional version override
- **Features**:
  - ✅ Auto-increments version from `versions.toml`
  - ✅ Publishes dependencies to crates.io (if `CARGO_REGISTRY_TOKEN` set)
  - ✅ Updates Cargo.toml to use published crates
  - ✅ Builds base + experimental variants
  - ✅ Linux (native) + Windows (cross-compile)
  - ✅ Runs all tests
  - ✅ Verifies deterministic builds
  - ✅ Creates GitHub release (official, not prerelease)
  - ✅ Tags all repositories with version
- **Status**: ✅ **ACTIVE - Primary release workflow**

#### 2. `prerelease.yml` ✅ **PRERELEASE**
- **Location**: `bllvm/.github/workflows/prerelease.yml`
- **Trigger**: 
  - `workflow_call` (from orchestrator)
  - `workflow_dispatch` (manual)
- **Features**:
  - ✅ Manual version tag required
  - ✅ Builds base + experimental variants
  - ✅ Creates GitHub prerelease
  - ✅ No crates.io publishing (correct for prereleases)
- **Status**: ✅ **ACTIVE - For testing/prereleases**

#### 3. `nightly-prerelease.yml` ✅ **NIGHTLY BUILDS**
- **Location**: `bllvm/.github/workflows/nightly-prerelease.yml`
- **Trigger**: 
  - Cron: 2 AM UTC daily
  - `workflow_dispatch` (manual)
- **Features**:
  - ✅ Triggers orchestrator with `build_all`
  - ✅ Creates nightly version tags
- **Status**: ✅ **ACTIVE - For nightly builds**

#### 4. `release_orchestrator.yml` ✅ **ORCHESTRATOR - UPDATED**
- **Location**: `bllvm/.github/workflows/release_orchestrator.yml`
- **Trigger**: 
  - `workflow_dispatch` (manual)
  - `repository_dispatch` (cross-repo)
  - `workflow_run` (on CI completion)
- **Features**:
  - ✅ Uses correct repo names (bllvm-consensus, bllvm-protocol, etc.)
  - ✅ Builds repos in dependency order
  - ✅ Triggers `release.yml` for main branch
  - ✅ Triggers `prerelease.yml` for other branches
- **Status**: ✅ **ACTIVE - Updated with new names**

### Removed Workflows

#### ❌ `release_prod.yml` - **REMOVED**
- **Reason**: Duplicate functionality covered by `release.yml`
- **Status**: ✅ **DELETED**

## Individual Repository Workflows

### CI Workflows (No Release Logic)

All individual repo CI workflows are **correctly configured**:

- ✅ `bllvm-consensus/.github/workflows/ci.yml` - CI only
- ✅ `bllvm-protocol/.github/workflows/ci.yml` - CI only
- ✅ `bllvm-node/.github/workflows/ci.yml` - CI only
- ✅ `bllvm-sdk/.github/workflows/ci.yml` - CI only
- ✅ `bllvm-commons/.github/workflows/governance-app-ci.yml` - CI only

**Note**: These workflows trigger on `release: types: [published]` to run CI when releases are created, but they **do not create releases themselves**. This is correct behavior.

## Release Flow

### Automatic Release (Push to Main)

```
Push to main (any repo)
    ↓
release.yml triggers automatically
    ↓
1. Determine version (auto-increment)
2. Publish dependencies to crates.io
3. Update Cargo.toml to use published crates
4. Build base + experimental variants
5. Run tests
6. Create GitHub release
7. Tag all repositories
```

### Manual Release

```
workflow_dispatch → release.yml
    ↓
1. Use provided version (or auto-increment)
2. Same flow as automatic release
```

### Prerelease Flow

```
workflow_dispatch → prerelease.yml
    OR
orchestrator → prerelease.yml (for non-main branches)
    ↓
1. Build base + experimental variants
2. Create GitHub prerelease
3. No crates.io publishing
```

### Orchestrator Flow

```
repository_dispatch → release_orchestrator.yml
    ↓
1. Build repos in dependency order
2. If main branch → trigger release.yml
3. If other branch → trigger prerelease.yml
```

## Cargo Publishing

### Configuration

- **Secret Required**: `CARGO_REGISTRY_TOKEN` (crates.io API token)
- **Location**: GitHub repository secrets
- **Status**: ✅ **Configured in release.yml**

### Publishing Order

1. `bllvm-consensus` (no dependencies)
2. `bllvm-sdk` (no dependencies, parallel)
3. `bllvm-protocol` (after bllvm-consensus)
4. `bllvm-node` (after bllvm-protocol)

### Cargo.toml Updates

Release workflow automatically updates:
- `bllvm-protocol/Cargo.toml`: Uses published `bllvm-consensus`
- `bllvm-node/Cargo.toml`: Uses published `bllvm-protocol`
- `bllvm/Cargo.toml`: Uses published `bllvm-node`
- `bllvm-commons/Cargo.toml`: Uses published `bllvm-sdk`

## Version Management

### Version Source

- **File**: `bllvm/versions.toml`
- **Format**: TOML with version, git_tag, requires fields
- **Auto-increment**: Patch version (X.Y.Z → X.Y.(Z+1))

### Version Coordination

All repositories tagged with same version:
- `bllvm-consensus`: `v0.1.0`
- `bllvm-protocol`: `v0.1.0`
- `bllvm-node`: `v0.1.0`
- `bllvm`: `v0.1.0`
- `bllvm-sdk`: `v0.1.0`
- `bllvm-commons`: `v0.1.0`

## Verification Checklist

### Release Workflow

- [x] `release.yml` triggers on push to main
- [x] `release.yml` publishes to crates.io (if token set)
- [x] `release.yml` creates GitHub release
- [x] `release.yml` tags all repos
- [x] `release.yml` uses "Bitcoin Commons" branding
- [x] `release.yml` updates Cargo.toml to use published crates

### Prerelease Workflow

- [x] `prerelease.yml` works for manual prereleases
- [x] `prerelease.yml` creates GitHub prerelease
- [x] `prerelease.yml` uses "Bitcoin Commons" branding
- [x] `prerelease.yml` does NOT publish to crates.io

### Orchestrator

- [x] `release_orchestrator.yml` uses correct repo names
- [x] `release_orchestrator.yml` triggers release.yml for main
- [x] `release_orchestrator.yml` triggers prerelease.yml for others

### Individual Repos

- [x] No duplicate release workflows
- [x] CI workflows don't create releases
- [x] CI workflows only react to releases

### Consolidation

- [x] Duplicate `release_prod.yml` removed
- [x] All workflows use "Bitcoin Commons" naming
- [x] No conflicting workflows

## Summary

### ✅ Complete Release System

1. **Official Release**: `release.yml` - Auto-triggers on main, publishes to crates.io
2. **Prerelease**: `prerelease.yml` - Manual/orchestrator triggered
3. **Nightly**: `nightly-prerelease.yml` - Scheduled daily
4. **Orchestrator**: `release_orchestrator.yml` - Coordinates builds

### ✅ No Duplicates

- Removed `release_prod.yml` (duplicate)
- All workflows have distinct purposes
- No conflicting release logic

### ✅ Complete Integration

- Cargo publishing integrated
- Version auto-increment working
- Tagging all repos
- GitHub releases created
- Bitcoin Commons branding throughout

## Ready for Production

The release system is **complete and ready** for use. Any push to `main` will automatically trigger an official release with:

- ✅ Cargo publishing (if token configured)
- ✅ GitHub release creation
- ✅ Repository tagging
- ✅ Artifact generation
- ✅ Complete documentation

