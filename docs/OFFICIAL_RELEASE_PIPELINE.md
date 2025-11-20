# Official Release Pipeline Design

## Summary

This document describes the official release pipeline for the Bitcoin Commons ecosystem, built on the successful prerelease workflow pattern.

## Key Design Decisions

### 1. Automatic Triggering

**Decision**: Trigger on push to `main` in any repository

**Rationale**:
- Merges to main represent completed, reviewed work
- Automatic releases reduce manual overhead
- Consistent with CI/CD best practices
- Path filtering excludes documentation-only changes

**Implementation**:
```yaml
on:
  push:
    branches:
      - main
    paths-ignore:
      - '**.md'
      - '.github/**'
      - 'docs/**'
```

### 2. Version Determination

**Decision**: Auto-increment patch version from `versions.toml`

**Rationale**:
- Maintains semantic versioning
- Reduces manual version management
- Clear version progression
- Allows manual override via workflow dispatch

**Implementation**:
- Reads `bllvm-consensus` version from `versions.toml`
- Increments patch: `X.Y.Z` → `X.Y.(Z+1)`
- Generates release set ID: `set-YYYY-MMDD`

### 3. Build Order via Cargo

**Decision**: Use Cargo's dependency resolution for build ordering

**Rationale**:
- Leverages existing dependency declarations
- Automatic dependency resolution
- No manual build order maintenance
- Handles parallel builds (bllvm-sdk)

**Implementation**:
- `build.sh` uses topological sort based on Cargo dependencies
- Builds follow dependency graph automatically
- Parallel builds where possible

### 4. Two Variant System

**Decision**: Build both base and experimental variants

**Rationale**:
- Base: Stable for production
- Experimental: Full features for development
- Users choose based on needs
- Consistent with prerelease pattern

**Implementation**:
- Base: `--features production`
- Experimental: All features enabled
- Separate artifact directories

### 5. Cross-Platform Support

**Decision**: Build for Linux and Windows

**Rationale**:
- Linux: Native build, primary platform
- Windows: Cross-compile with MinGW
- Both variants for both platforms
- Consistent with prerelease pattern

**Implementation**:
- Linux: Native `x86_64-unknown-linux-gnu`
- Windows: Cross-compile `x86_64-pc-windows-gnu`
- MinGW toolchain auto-detected and configured

### 6. Deterministic Build Verification

**Decision**: Verify builds are reproducible

**Rationale**:
- Security: Ensures no tampering
- Reproducibility: Same source = same binary
- Trust: Users can verify builds
- Best practice for cryptocurrency software

**Implementation**:
- Build once, save hashes
- Clean and rebuild
- Compare hashes (warning if mismatch)

### 7. Comprehensive Testing

**Decision**: Run all tests before release

**Rationale**:
- Quality assurance
- Catch regressions early
- Confidence in release
- Exclude doctests for speed (Phase 1)

**Implementation**:
- All repos: `cargo test --release --all-features`
- Exclude doctests: `--lib --bins --tests` (no `--doc`)
- Timeout: 30 minutes per repo
- Single-threaded: Avoid resource contention

### 8. Git Tagging

**Decision**: Tag all repositories with same version

**Rationale**:
- Version tracking
- Reproducible builds
- Release identification
- Dependency coordination

**Implementation**:
- Tag all repos: `bllvm-consensus`, `bllvm-protocol`, `bllvm-node`, `bllvm`, `bllvm-sdk`, `bllvm-commons`
- Annotated tags with release message
- Skip if tag exists (idempotent)

### 9. GitHub Release

**Decision**: Create official release (not prerelease)

**Rationale**:
- Distinction from prereleases
- Production-ready artifacts
- User confidence
- Clear release type

**Implementation**:
- `prerelease: false`
- Release in `bllvm` repository
- Include all artifacts and checksums

## Workflow Structure

### Jobs

1. **determine-version**
   - Reads/calculates version
   - Outputs version tag and number
   - Generates release set ID

2. **release**
   - Builds all variants and platforms
   - Runs tests
   - Creates artifacts
   - Tags repositories
   - Creates GitHub release

### Steps (Release Job)

1. Checkout and setup
2. Configure build environment
3. Checkout all repos at main
4. Build base variant (Linux)
5. Build experimental variant (Linux)
6. Build base variant (Windows)
7. Build experimental variant (Windows)
8. Verify deterministic builds
9. Run tests
10. Collect artifacts
11. Create release package
12. Verify versions
13. Tag repositories
14. Create GitHub release

## Differences from Prerelease

| Aspect | Prerelease | Official Release |
|--------|-----------|------------------|
| Trigger | Manual/workflow_call | Push to main |
| Version | Provided manually | Auto-incremented |
| Release Type | Prerelease | Official release |
| Tagging | Optional | Required |
| Deterministic | Warning | Should pass |
| Tests | Skip doctests | All tests required |

## Version Coordination

### Current Approach

- Read from `versions.toml`
- Auto-increment patch
- Tag all repos with same version

### Future Enhancements

- Auto-update `versions.toml` after release
- Major/minor bump detection
- Release set coordination
- Dependency version validation

## Build Constraints

### Cargo Dependencies

The build system respects Cargo's dependency declarations:

```toml
# bllvm-protocol/Cargo.toml
[dependencies]
bllvm-consensus = { git = "...", tag = "v0.1.0" }

# bllvm-node/Cargo.toml
[dependencies]
bllvm-protocol = { git = "...", tag = "v0.1.0" }
bllvm-consensus = { git = "...", tag = "v0.1.0" }
```

### Build Order Enforcement

`build.sh` uses topological sort to ensure:
1. Dependencies built before dependents
2. Parallel builds where possible
3. Correct feature propagation

## Release Artifacts

### Structure

```
artifacts/
├── bllvm-{version}-linux-x86_64.tar.gz
├── bllvm-{version}-linux-x86_64.zip
├── bllvm-{version}-windows-x86_64.tar.gz
├── bllvm-{version}-windows-x86_64.zip
├── bllvm-experimental-{version}-linux-x86_64.tar.gz
├── bllvm-experimental-{version}-linux-x86_64.zip
├── bllvm-experimental-{version}-windows-x86_64.tar.gz
├── bllvm-experimental-{version}-windows-x86_64.zip
├── SHA256SUMS-bllvm-linux-x86_64
├── SHA256SUMS-bllvm-windows-x86_64
├── SHA256SUMS-bllvm-experimental-linux-x86_64
├── SHA256SUMS-bllvm-experimental-windows-x86_64
└── RELEASE_NOTES.md
```

### Contents

Each archive contains:
- All binaries (bllvm + governance tools)
- SHA256SUMS file for verification
- Flat structure (no subdirectories)

## Error Handling

### Build Failures

- **Stop on first failure**: Don't continue with broken builds
- **Clear error messages**: Identify which repo failed
- **Log preservation**: Save build logs for debugging

### Test Failures

- **Fail fast**: Stop release if tests fail
- **Detailed output**: Show test failures
- **Timeout handling**: Detect and report timeouts

### Tagging Failures

- **Skip existing tags**: Don't fail if tag exists
- **Continue on error**: Tag other repos even if one fails
- **Warning messages**: Report but don't fail release

## Security Considerations

### Build Security

- Locked dependencies: `--locked` flag
- Deterministic builds: Verified reproducibility
- Checksums: SHA256 for all artifacts

### Release Security

- Immutable tags: Once created, never changed
- Verified artifacts: Checksums provided
- Official releases: Clear release type

## Monitoring

### Success Indicators

- All builds succeed
- All tests pass
- Deterministic verification passes
- Tags created successfully
- GitHub release created

### Failure Indicators

- Build failures (stop release)
- Test failures (stop release)
- Non-deterministic builds (warning)
- Tagging failures (warning, continue)
- Missing artifacts (stop release)

## Future Improvements

### Short Term

- Auto-update `versions.toml` after release
- GPG signing of releases
- Release notifications

### Long Term

- OpenTimestamps anchoring
- Release attestations
- Automated changelog generation
- Major/minor version detection
- Release set coordination UI

