# Contributing to Bitcoin Commons (blvm)

Thank you for your interest in contributing to the Bitcoin Commons build and release system! This document contains **repo-specific guidelines only**. For comprehensive contributing guidelines, see the [BLVM Documentation](https://docs.thebitcoincommons.org/development/contributing.html).

## Quick Links

- **[Complete Contributing Guide](https://docs.thebitcoincommons.org/development/contributing.html)** - Full developer workflow
- **[PR Process](https://docs.thebitcoincommons.org/development/pr-process.html)** - Governance tiers and review process
- **[Release Process](https://docs.thebitcoincommons.org/development/release-process.html)** - Release workflow

## Code of Conduct

This project follows the [Rust Code of Conduct](https://www.rust-lang.org/policies/code-of-conduct). By participating, you agree to uphold this code.

## Repository-Specific Guidelines

### Build Script Changes

The `build.sh` script is critical for the entire Bitcoin Commons ecosystem:

- **Test thoroughly** - Changes affect all repositories
- **Maintain backward compatibility** - Don't break existing workflows
- **Document new features** - Update README and BUILD_SYSTEM.md
- **Follow bash best practices** - Use `set -euo pipefail`, proper error handling

### Version Coordination

When modifying `versions.toml`:

- **Coordinate with all repos** - Ensure compatibility
- **Update metadata fields** - Fill in `last_updated`, `updated_by`, `release_notes`
- **Test version validation** - Run `verify-versions.sh`
- **Document breaking changes** - If version requirements change

### Workflow Changes

For GitHub Actions workflows:

- **Test locally first** - Use `act` or similar tools when possible
- **Maintain reusability** - Workflows are used by other repos
- **Document inputs/outputs** - Clear parameter descriptions
- **Version workflow calls** - Use specific tags/commits for stability

### Script Standards

All scripts should:

- Use `#!/bin/bash` with `set -euo pipefail`
- Include proper error messages
- Support `--help` flags
- Follow consistent naming conventions
- Include inline documentation

## Development Setup

### Prerequisites

- Bash 4.0+
- Git
- Access to Bitcoin Commons repositories (for testing)

### Testing Build Scripts

```bash
# Test build script
./build.sh --mode dev

# Test version verification
./scripts/verify-versions.sh

# Test artifact collection
./scripts/collect-artifacts.sh --test
```

## Review Process

### Pull Request Requirements

- [ ] **Build scripts tested** - Verified with local repos
- [ ] **Documentation updated** - README and relevant docs
- [ ] **Version coordination** - Updated versions.toml if needed
- [ ] **Workflows tested** - GitHub Actions workflows work
- [ ] **Backward compatible** - Doesn't break existing usage

### Review Criteria

Reviewers will check:

1. **Correctness** - Does the code work as intended?
2. **Compatibility** - Does it work with all repos?
3. **Documentation** - Is it clear and complete?
4. **Testing** - Are changes properly tested?
5. **Security** - Any potential vulnerabilities?

## Getting Help

- **Documentation**: [docs.thebitcoincommons.org](https://docs.thebitcoincommons.org)
- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub discussions for questions
- **Security**: See [SECURITY.md](SECURITY.md)

Thank you for contributing to Bitcoin Commons!
