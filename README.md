# BTCDecoded Commons - Build and Release System

This repository contains the unified build orchestration and release automation infrastructure for the BTCDecoded ecosystem.

## Overview

The BTCDecoded project consists of multiple independent git repositories with complex dependencies:

- **consensus-proof** (foundation library)
- **protocol-engine** (depends on consensus-proof)
- **reference-node** (depends on protocol-engine + consensus-proof)
- **developer-sdk** (standalone, CLI tools)
- **governance-app** (depends on developer-sdk)

This repository provides:

1. **Unified Build Script** (`build.sh`) - Builds all repos in dependency order
2. **Version Coordination** (`versions.toml`) - Tracks compatible versions across repos
3. **Reusable Workflows** - GitHub Actions workflows that other repos can call
4. **Release Automation** - Creates unified releases with all binaries
5. **Helper Scripts** - Utilities for artifact collection and verification

## Quick Start

### Building All Repositories

```bash
# Clone commons repository
git clone https://github.com/BTCDecoded/commons.git
cd commons

# Ensure all BTCDecoded repos are cloned in parent directory
# Expected structure:
# BTCDecoded/
#   ├── commons/
#   ├── consensus-proof/
#   ├── protocol-engine/
#   ├── reference-node/
#   ├── developer-sdk/
#   └── governance-app/

# Build all repos in development mode (uses local path dependencies)
./build.sh --mode dev

# Build all repos in release mode (uses git dependencies)
./build.sh --mode release
```

### Using Workflows from Other Repositories

Other repos can call reusable workflows from `commons`:

```yaml
# In reference-node/.github/workflows/build.yml
jobs:
  build:
    uses: BTCDecoded/commons/.github/workflows/build-single.yml@main
    with:
      repo-name: reference-node
      required-deps: consensus-proof,protocol-engine
```

## Structure

```
commons/
├── README.md                    # This file
├── build.sh                     # Main unified build script
├── versions.toml                # Version coordination manifest
├── docker-compose.build.yml     # Docker build orchestration
├── .github/
│   └── workflows/
│       ├── build-all.yml        # Reusable: Build all repos
│       ├── build-single.yml     # Reusable: Build single repo
│       ├── release.yml          # Reusable: Create unified release
│       └── verify-versions.yml  # Reusable: Validate versions
├── scripts/
│   ├── setup-build-env.sh       # Setup build environment
│   ├── collect-artifacts.sh     # Package binaries
│   ├── create-release.sh        # Release creation
│   └── verify-versions.sh       # Version validation
└── docs/
    └── BUILD_SYSTEM.md          # Detailed documentation
```

## Version Coordination

The `versions.toml` file tracks compatible versions across all repositories. This ensures that releases are built with compatible dependency versions.

See `versions.toml` for current version mappings.

## License

MIT License - see LICENSE file for details.

