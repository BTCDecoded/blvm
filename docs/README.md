# BTCDecoded Commons Documentation

This directory contains all documentation for the BTCDecoded commons repository.

## Workspace-wide documentation (multi-repo checkout)

If you use a **workspace** that contains this repo next to `blvm-node`, `blvm-docs`, etc., cross-repo plans and audits may live in a sibling **`docs/`** folder at that workspace root (not here). This `blvm/docs/` directory is for **Bitcoin Commons / `blvm` crate** build and workflow documentation only.

## Directory Structure

### `/build/` - Build System Documentation
- **BUILD_CHAINING_GUIDE.md** - Complete guide to chaining builds across repositories
- **LOCAL_BUILD_VERIFICATION.md** - Local build verification and quick start
- **BUILD_POLICY.md** - Build policy and guidelines
- **BUILD_SYSTEM.md** - Detailed build system documentation

### `/workflows/` - Workflow Documentation
- **WORKFLOW_METHODOLOGY.md** - Core workflow methodology

### `/testing/` - Testing Documentation
- **TEST_SEEDS.md** - Test seed information

### `/guides/` - Quick Reference Guides
- **QUICK_START.md** - Quick start guide for local builds

## Quick Links

### Getting Started
- [Quick Start Guide](./guides/QUICK_START.md) - Start building locally
- [Build Chaining Guide](./build/BUILD_CHAINING_GUIDE.md) - Chain builds together

### Build System
- [Build System Documentation](./build/BUILD_SYSTEM.md) - Complete build system
- [Build Policy](./build/BUILD_POLICY.md) - Build policies
- [Local Build Verification](./build/LOCAL_BUILD_VERIFICATION.md) - Local build guide

### Workflows
- [Workflow Methodology](./workflows/WORKFLOW_METHODOLOGY.md) - Core methodology

### Testing
- [Test Seeds](./testing/TEST_SEEDS.md) - Test seed information

## Root Documentation

The following documentation remains in the root directory for easy access:
- **README.md** - Main repository README
- **CONTRIBUTING.md** - Contribution guidelines
- **SECURITY.md** - Security guidelines
- **NAMING_POLICY.md** - Naming conventions
- **RELEASE_SET.md** - Release set information

## Operations Documentation

Operations documentation is in the `ops/` directory:
- **ops/SELF_HOSTED_RUNNER.md** - Self-hosted runner setup
- **ops/RUNNER_FLEET.md** - Runner fleet management

## Scripts Documentation

Scripts documentation is in the `scripts/` directory:
- **scripts/README.md** - Complete script documentation

## Documentation Updates

When adding new documentation:
1. **Build-related** → `docs/build/`
2. **Workflow-related** → `docs/workflows/`
3. **Testing-related** → `docs/testing/`
4. **Guides** → `docs/guides/`
5. **Policy documents** → Root directory
6. **Operations** → `ops/`
7. **Scripts** → `scripts/`

## Architecture and security (internal reference)

- **[Repository Architecture ADR](./REPOSITORY_ARCHITECTURE_ADR.md)** — full monorepo vs multi-repo decision record (trade-off matrix, steelman, mitigations)
- **[BLVM vs btc-verified](./BTC_VERIFIED_COMPARISON.md)** — comparison with [ProofOfKeags/btc-verified](https://github.com/ProofOfKeags/btc-verified) (Lean 4 proof leaves); local checkout at `../../btc-verified`
- **[btc-verified lessons plan](./BTC_VERIFIED_LESSONS_PLAN.md)** — action plan: golden vectors, codec laws, merkle spec, Orange Paper amendments (**active tracker**)
- **[Architecture objection responses](./ARCHITECTURE_OBJECTION_RESPONSES.md)** — copy-paste replies to common technical objections (internal; not published in the book)
- **[Constant-time coverage](./security/CONSTANT_TIME_COVERAGE.md)** — audit of secret-path timing in `blvm-secp256k1` and upstream callers

## Website / marketing (cross-repo)

Implementation is in **`commons-website`** (`thebitcoincommons.org`). Plans:

- **[Commons website — essential fixes](./COMMONS_WEBSITE_IMPROVEMENT_PLAN.md)** — whitepaper alignment + cross-links only (`commons-website`)
- **[Landing page plan](../../docs/landing-page-plan.md)** — conversion waves C → A → B (`btc-commons/docs/`) — **after** essential fixes
- **[Documentation tightening plan](../../docs/DOCS_TIGHTENING_PLAN.md)** — canonical tiers for book vs sites

## See Also

- [Workflow Methodology](./workflows/WORKFLOW_METHODOLOGY.md) - Workflow details
- [Build System](./build/BUILD_SYSTEM.md) - Build system details
