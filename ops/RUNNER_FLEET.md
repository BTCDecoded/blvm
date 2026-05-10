# Runner Fleet Hygiene

## Labels
Assign runners the following labels for targeting:
- `self-hosted, linux, x64` — baseline (required)
- `rust` — Rust toolchain present (optional, optimizes build jobs)
- `docker` — Docker engine present (optional, optimizes Docker builds)
- `z3` — Z3 installed (optional; speeds **blvm-spec-lock** jobs that run full contract verification)

**Label Priority**: Workflows prefer specific labels when available, but gracefully fall back to basic labels if specific capabilities aren't present. Installation steps handle missing tools as fallback.

## Bootstrap Script
Use `commons/tools/bootstrap_runner.sh` to install:
- Rust toolchain (rustup)
- Docker (optional), add user to docker group
- Z3 (optional; for **blvm-spec-lock** with full verification)
- Login to GHCR (optional)

## Permissions
- Restrict repositories to self-hosted only
- Use branch protection with required checks sourced from self-hosted workflows

## Caching
- Configure per-runner cache directories for Cargo registry/builds to improve performance

## Fallback Behavior
- Workflows install missing tools (Rust, Docker, Z3) if labeled runners aren't available.
- This ensures workflows work even if runners only have basic labels.
- Specific labels are optimizations for faster job execution, not requirements.
