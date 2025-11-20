# Workflow Audit and Consolidation Plan

## Current State Analysis

### Release Workflows in `bllvm/.github/workflows/`

#### 1. `release.yml` ✅ **PRIMARY - Official Release**
- **Trigger**: Push to `main` (auto) + `workflow_dispatch` (manual)
- **Purpose**: Official releases with crates.io publishing
- **Features**:
  - Auto-increments version from `versions.toml`
  - Publishes dependencies to crates.io
  - Updates Cargo.toml to use published crates
  - Builds base + experimental variants
  - Creates GitHub release (not prerelease)
  - Tags all repositories
- **Status**: ✅ **ACTIVE - Use this for official releases**

#### 2. `prerelease.yml` ✅ **PRERELEASE - Keep**
- **Trigger**: `workflow_call` (from orchestrator) + `workflow_dispatch` (manual)
- **Purpose**: Prereleases for testing
- **Features**:
  - Manual version tag required
  - Builds base + experimental variants
  - Creates GitHub prerelease
  - No crates.io publishing
- **Status**: ✅ **ACTIVE - Keep for prereleases**

#### 3. `release_prod.yml` ⚠️ **DUPLICATE - Should be removed**
- **Trigger**: `workflow_call` + `workflow_dispatch`
- **Purpose**: Production release (different approach)
- **Features**:
  - Downloads existing artifacts
  - Generates component manifests
  - Different build approach
- **Status**: ⚠️ **DUPLICATE - Conflicts with `release.yml`**
- **Action**: **REMOVE** - Functionality covered by `release.yml`

#### 4. `release_orchestrator.yml` ⚠️ **NEEDS UPDATE**
- **Trigger**: `workflow_dispatch`, `repository_dispatch`, `workflow_run`
- **Purpose**: Orchestrates builds across repos
- **Features**:
  - Builds repos in dependency order
  - Triggers prerelease after build
  - Uses old naming (consensus-proof, protocol-engine, etc.)
- **Status**: ⚠️ **OUTDATED - Uses old repo names**
- **Action**: **UPDATE** - Should trigger `release.yml` instead of prerelease for main branch

#### 5. `nightly-prerelease.yml` ✅ **KEEP**
- **Trigger**: Cron (2 AM UTC daily) + `workflow_dispatch`
- **Purpose**: Nightly prereleases
- **Features**:
  - Triggers orchestrator with `build_all`
  - Creates nightly version tags
- **Status**: ✅ **ACTIVE - Keep for nightly builds**

### Individual Repository CI Workflows

#### `bllvm-consensus/.github/workflows/ci.yml`
- **Purpose**: CI for consensus repo
- **Status**: ✅ **OK - No release logic**

#### `bllvm-protocol/.github/workflows/ci.yml`
- **Purpose**: CI for protocol repo
- **Status**: ✅ **OK - No release logic**

#### `bllvm-node/.github/workflows/ci.yml` + `build-chain.yml`
- **Purpose**: CI + build chain
- **Status**: ✅ **OK - No release logic**

#### `bllvm-sdk/.github/workflows/ci.yml` + `security.yml`
- **Purpose**: CI + security checks
- **Status**: ✅ **OK - No release logic**

#### `bllvm-commons/.github/workflows/governance-app-ci.yml`
- **Purpose**: CI for governance app
- **Status**: ✅ **OK - No release logic**

## Issues Found

### 1. Duplicate Release Workflows

**Problem**: `release_prod.yml` duplicates `release.yml` functionality

**Solution**: Remove `release_prod.yml`

### 2. Orchestrator Uses Old Names

**Problem**: `release_orchestrator.yml` uses old repo names:
- `consensus-proof` → should be `bllvm-consensus`
- `protocol-engine` → should be `bllvm-protocol`
- `reference-node` → should be `bllvm-node`
- `developer-sdk` → should be `bllvm-sdk`
- `governance-app` → should be `bllvm-commons`

**Solution**: Update orchestrator to use new names

### 3. Orchestrator Triggers Prerelease Instead of Release

**Problem**: Orchestrator always triggers prerelease, even for main branch

**Solution**: 
- For `main` branch: Trigger `release.yml` (official release)
- For other branches: Trigger `prerelease.yml` (prerelease)

### 4. Missing Cargo Publishing in Prerelease

**Problem**: `prerelease.yml` doesn't publish to crates.io

**Solution**: 
- **Prerelease**: Don't publish (correct - prereleases shouldn't publish)
- **Official Release**: Publish (already implemented in `release.yml`)

### 5. Release Workflow Doesn't Integrate with Orchestrator

**Problem**: `release.yml` is standalone, doesn't use orchestrator

**Solution**: 
- **Option A**: Keep standalone (simpler, direct)
- **Option B**: Integrate with orchestrator (more complex)
- **Recommendation**: **Option A** - Keep standalone for simplicity

## Consolidation Plan

### Phase 1: Remove Duplicates

1. **Remove `release_prod.yml`**
   - Functionality covered by `release.yml`
   - No longer needed

### Phase 2: Update Orchestrator

1. **Update repo names** in `release_orchestrator.yml`
2. **Update trigger logic**:
   - If `main` branch → trigger `release.yml`
   - Otherwise → trigger `prerelease.yml`

### Phase 3: Ensure Complete Release System

1. **Official Release** (`release.yml`):
   - ✅ Auto-triggers on push to main
   - ✅ Publishes to crates.io
   - ✅ Creates GitHub release
   - ✅ Tags all repos
   - ✅ Complete

2. **Prerelease** (`prerelease.yml`):
   - ✅ Manual trigger
   - ✅ Called by orchestrator
   - ✅ Creates prerelease
   - ✅ Complete

3. **Nightly** (`nightly-prerelease.yml`):
   - ✅ Scheduled trigger
   - ✅ Creates nightly prerelease
   - ✅ Complete

## Final Workflow Structure

### Release Workflows

```
bllvm/.github/workflows/
├── release.yml              ✅ Official Release (auto on main)
├── prerelease.yml           ✅ Prerelease (manual/orchestrator)
├── nightly-prerelease.yml   ✅ Nightly builds
└── release_orchestrator.yml ⚠️  Update to use new names
```

### Individual Repo Workflows

```
{bllvm-consensus,bllvm-protocol,bllvm-node,bllvm-sdk}/.github/workflows/
└── ci.yml                   ✅ CI only, no release logic

bllvm-commons/.github/workflows/
└── governance-app-ci.yml    ✅ CI only, no release logic
```

## Actions Required

### Immediate

1. ✅ **Remove `release_prod.yml`** - Duplicate functionality
2. ⚠️ **Update `release_orchestrator.yml`**:
   - Fix repo names
   - Update trigger logic for main branch
3. ✅ **Verify `release.yml`** has all features:
   - Cargo publishing ✅
   - Version auto-increment ✅
   - Tagging ✅
   - GitHub release ✅

### Verification Checklist

- [ ] `release.yml` triggers on push to main
- [ ] `release.yml` publishes to crates.io (if token set)
- [ ] `release.yml` creates GitHub release
- [ ] `release.yml` tags all repos
- [ ] `prerelease.yml` works for manual prereleases
- [ ] `nightly-prerelease.yml` creates nightly builds
- [ ] No duplicate release workflows
- [ ] Individual repo CIs don't trigger releases
- [ ] Orchestrator uses correct repo names

## Summary

### Current Status

- ✅ **Official Release**: Complete and ready (`release.yml`)
- ✅ **Prerelease**: Complete (`prerelease.yml`)
- ✅ **Nightly**: Complete (`nightly-prerelease.yml`)
- ⚠️ **Orchestrator**: Needs update (repo names, trigger logic)
- ❌ **Duplicate**: `release_prod.yml` should be removed

### Next Steps

1. Remove `release_prod.yml`
2. Update `release_orchestrator.yml` with new repo names
3. Test release workflow end-to-end
4. Verify no conflicts between workflows

