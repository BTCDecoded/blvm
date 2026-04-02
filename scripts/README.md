# Commons Scripts

This directory contains build, CI, and release scripts for the Bitcoin Commons build orchestration system.

## Script Categories

### Build Scripts
- `build-release-chain.sh` - Build release chain for all components
- `setup-build-env.sh` - Set up build environment
- `setup-cache.sh` - Set up build cache

### CI/CD Scripts
- `check-workflow-status.sh` - Check GitHub workflow status
- `check-ci-status.sh` - Check CI status
- `monitor-workflows.sh` - Monitor GitHub workflows
- `cancel-old-jobs.sh` - Cancel old CI jobs
- `ci-healer.sh` - CI health monitoring
- `runner-status.sh` - Check runner status
- `start-runner.sh` - Start CI runner

### Verification Scripts
- `verify_formal_coverage.sh` - Verify formal verification coverage
- `verify-versions.sh` - Verify version consistency

### Release Scripts
- `bump-release-set.sh` / `bump-release-set.py` - Bump coordinated semver (`patch`|`minor`|`major`), update `versions.toml` (before `[metadata]`) and `blvm/Cargo.toml` `[package].version`; use `--dry-run` to preview
- `create-release.sh` - Create release
- `collect-artifacts.sh` - Collect release artifacts
- `rebuild-for-release.sh` - Rebuild base or experimental variant before `collect-artifacts` (avoids wrong binary in `target/release`)
- `package-deb.sh` - Build `.deb` for `blvm` or `blvm-experimental`
- `package-arch.sh` - Build Arch-style `.pkg.tar.gz` payload
- `package-rpm-from-deb.sh` - Optional `.rpm` via `alien` when installed
- `package-linux-releases.sh` - Orchestrate Linux packages + `SHA256SUMS-linux-packages.txt` (used by release/prerelease workflows)

## Usage

See [commons/README.md](../README.md) for build system documentation and usage instructions.

## Related Scripts

- `../tools/` - Build tools (bootstrap_runner.sh, run_suite.sh, etc.)
- `blvm-commons/scripts/download_workflow_logs.sh` - Download workflow logs (blvm-spec, blvm-consensus, etc.)
- Component-specific scripts in component directories
