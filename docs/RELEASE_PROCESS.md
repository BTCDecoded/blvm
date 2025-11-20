# Official Release Process

## Overview

The official release pipeline automatically builds and releases the Bitcoin Commons ecosystem when code is merged to `main` in any repository. The system uses Cargo's dependency management to build repositories in the correct order.

## Trigger Conditions

### Automatic Release (Push to Main)

The release pipeline automatically triggers when:
- A commit is pushed to the `main` branch in any repository
- The commit changes code files (not just documentation)
- Paths ignored: `**.md`, `.github/**`, `docs/**`

### Manual Release (Workflow Dispatch)

You can manually trigger a release with:
- Custom version tag (e.g., `v0.1.0`)
- Platform selection (linux, windows, or both)
- Option to skip tagging (for testing)

## Version Determination

### Automatic Version Bumping

When triggered by a push to `main`, the pipeline:
1. Reads the current version from `bllvm/versions.toml` (from `bllvm-consensus` version)
2. Auto-increments the patch version (X.Y.Z → X.Y.(Z+1))
3. Generates a release set ID (e.g., `set-2025-0123`)

### Manual Version Override

When using workflow dispatch, you can:
- Provide a specific version tag (e.g., `v0.2.0`)
- The pipeline uses your provided version instead of auto-incrementing

## Build Process

### Dependency Order

The build follows Cargo's dependency graph:

```
1. bllvm-consensus (no dependencies)
   ↓
2. bllvm-protocol (depends on bllvm-consensus)
   ↓
3. bllvm-node (depends on bllvm-protocol + bllvm-consensus)
   ↓
4. bllvm (depends on bllvm-node)

Parallel:
5. bllvm-sdk (no dependencies)
   ↓
6. bllvm-commons (depends on bllvm-sdk)
```

### Build Variants

Each release includes two variants:

#### Base Variant
- **Purpose**: Stable, production-ready
- **Features**: Core functionality, production optimizations
- **Use for**: Production deployments

#### Experimental Variant
- **Purpose**: Full-featured with experimental features
- **Features**: All base features plus:
  - UTXO commitments
  - Dandelion++ privacy relay
  - BIP119 CheckTemplateVerify (CTV)
  - Stratum V2 mining
  - BIP158 compact block filters
  - Signature operations counting
  - Iroh transport support
- **Use for**: Development, testing, advanced features

### Platforms

Both variants are built for:
- **Linux x86_64** (native)
- **Windows x86_64** (cross-compiled with MinGW)

## Release Artifacts

### Binaries Included

Both variants include:
- `bllvm` - Bitcoin reference node
- `bllvm-keygen` - Key generation tool
- `bllvm-sign` - Message signing tool
- `bllvm-verify` - Signature verification tool
- `bllvm-commons` - Governance application server (Linux only)
- `key-manager` - Key management utility
- `test-content-hash` - Content hash testing tool
- `test-content-hash-standalone` - Standalone content hash test

### Archive Formats

Each platform/variant combination produces:
- `.tar.gz` archive (Linux/Unix)
- `.zip` archive (Windows/universal)
- `SHA256SUMS` file for verification

### Release Notes

Automatically generated `RELEASE_NOTES.md` includes:
- Release date
- Component versions
- Build variant descriptions
- Installation instructions
- Verification instructions

## Quality Assurance

### Deterministic Build Verification

The pipeline verifies builds are reproducible by:
1. Building once and saving binary hashes
2. Cleaning and rebuilding
3. Comparing hashes (must match exactly)

**Note**: Non-deterministic builds are warnings (not failures) but should be fixed for production.

### Test Execution

All repositories run their test suites:
- Unit tests
- Integration tests
- Library and binary tests
- **Excluded**: Doctests (for Phase 1 speed)

**Test Requirements**:
- All tests must pass
- 30-minute timeout per repository
- Single-threaded execution to avoid resource contention

## Git Tagging

### Automatic Tagging

When a release succeeds, the pipeline:
1. Creates git tags in all repositories with the version tag
2. Tags are annotated with release message
3. Pushes tags to origin

**Repositories Tagged**:
- `bllvm-consensus`
- `bllvm-protocol`
- `bllvm-node`
- `bllvm`
- `bllvm-sdk`
- `bllvm-commons`

### Tag Format

- Format: `vX.Y.Z` (e.g., `v0.1.0`)
- Semantic versioning
- Immutable once created

## GitHub Release

### Release Creation

The pipeline creates a GitHub release with:
- **Tag**: Version tag (e.g., `v0.1.0`)
- **Title**: `Bitcoin Commons v0.1.0`
- **Body**: Generated from `RELEASE_NOTES.md`
- **Artifacts**: All binary archives and checksums
- **Type**: Official release (not prerelease)

### Release Location

Releases are created in the `bllvm` repository as the primary release point for the ecosystem.

## Version Coordination

### versions.toml

The `bllvm/versions.toml` file tracks:
- Current version of each repository
- Dependency requirements
- Release set ID

### Updating Versions

For major/minor version bumps:
1. Manually edit `versions.toml`
2. Update version numbers
3. Trigger release with workflow dispatch
4. Provide the new version tag

For patch releases:
- Automatic via push to main
- Patch version auto-increments

## Troubleshooting

### Build Failures

**Common Issues**:
- Missing dependencies: Check all repos are cloned
- Cargo config issues: Pipeline auto-fixes common problems
- Windows cross-compile: Verify MinGW is installed

**Solutions**:
- Check build logs in GitHub Actions
- Verify all repositories are accessible
- Ensure Rust toolchain is up to date

### Test Failures

**Common Issues**:
- Flaky tests: Check for timing issues
- Resource contention: Tests run single-threaded
- Timeout: Tests have 30-minute limit

**Solutions**:
- Review test output in logs
- Check for CI-specific test issues
- Consider skipping problematic tests temporarily

### Tagging Failures

**Common Issues**:
- Tag already exists: Pipeline skips gracefully
- Permission issues: Verify `REPO_ACCESS_TOKEN` has write access

**Solutions**:
- Check if tag exists before release
- Verify token permissions
- Use `skip_tagging` option for testing

## Best Practices

### When to Release

- **Automatic**: After merging PRs to main (recommended)
- **Manual**: For major/minor version bumps
- **Skip**: For documentation-only changes (auto-ignored)

### Version Strategy

- **Patch**: Bug fixes, minor improvements (auto-increment)
- **Minor**: New features, backward compatible (manual)
- **Major**: Breaking changes (manual)

### Release Frequency

- **Regular**: After each merge to main (automatic)
- **Scheduled**: For coordinated releases (manual)
- **Emergency**: For critical fixes (manual with version override)

## Security Considerations

### Build Security

- All builds use `--locked` flag for reproducible builds
- Deterministic build verification ensures integrity
- Checksums provided for all artifacts

### Release Security

- Tags are immutable once created
- Releases require passing tests
- Artifacts are signed with SHA256 checksums

## Cargo Registry Publishing

### Overview

To avoid compiling all dependencies when building the final `bllvm` binary, all library dependencies are published to [crates.io](https://crates.io) as part of the release process. This allows the final binary to use pre-built, cached dependencies from the Cargo registry.

### Publishing Strategy

Dependencies are published in dependency order:

1. **bllvm-consensus** (no dependencies) → Published first
2. **bllvm-protocol** (depends on bllvm-consensus) → Published after bllvm-consensus
3. **bllvm-node** (depends on bllvm-protocol) → Published after bllvm-protocol
4. **bllvm-sdk** (no dependencies) → Published in parallel with bllvm-consensus

### Publishing Process

The release pipeline automatically:

1. **Publishes dependencies** in dependency order to crates.io
2. **Waits for publication** to complete before building dependents
3. **Updates Cargo.toml** in dependent repos to use published versions
4. **Builds final binary** using published crates (no compilation of dependencies)

### Benefits

- **Faster builds**: Final binary uses pre-built dependencies
- **Better caching**: Cargo can cache published crates
- **Version control**: Exact versions published and tracked
- **Reproducibility**: Same versions available to all users
- **Distribution**: Users can depend on published crates directly

### Crate Names

Published crates use the same names as the repositories:
- `bllvm-consensus` → `bllvm-consensus`
- `bllvm-protocol` → `bllvm-protocol`
- `bllvm-node` → `bllvm-node`
- `bllvm-sdk` → `bllvm-sdk`

### Version Coordination

- Published versions match git tags (e.g., `v0.1.0` → crate version `0.1.0`)
- Exact version pinning in `Cargo.toml` ensures reproducibility
- All dependencies use exact versions: `bllvm-protocol = "=0.1.0"`

### Local Development

For local development, repositories still use path dependencies:
```toml
bllvm-protocol = { path = "../bllvm-protocol" }
```

For release builds, the pipeline switches to published crates:
```toml
bllvm-protocol = "=0.1.0"
```

## Future Enhancements

Planned improvements:
- GPG signing of releases
- Release attestations
- OpenTimestamps anchoring
- Automated version bumping in versions.toml
- Release notifications
- Automatic Cargo.toml updates for published crates

