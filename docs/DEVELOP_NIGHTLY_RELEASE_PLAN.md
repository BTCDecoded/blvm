# Develop binary nightly (GitHub + GHCR)

**Status:** Implemented in tree (including dev-crate pins via `publish-develop-set`) — see [DEVELOP_CHANNEL_PLAN.md](DEVELOP_CHANNEL_PLAN.md)  
**Repo:** [BTCDecoded/blvm](https://github.com/BTCDecoded/blvm)

This file covers **Part A** only (rolling binaries + container). **crates.io develop publishes** and the **dependency resolver** are in the umbrella plan.

## Quick reference

| Item | Value |
|------|--------|
| Branch | `develop` only |
| Git tag / release | `nightly` (force-pushed, prerelease) |
| GHCR | `ghcr.io/btcdecoded/blvm:nightly` |
| crates.io | **Not** used for nightly *binaries*; dev **libraries** are Part B of [DEVELOP_CHANNEL_PLAN.md](DEVELOP_CHANNEL_PLAN.md) |
| Workflow | `blvm/.github/workflows/ci.yml` — `nightly-release`, `docker-ghcr-nightly` |
| Script | `blvm/scripts/ci-nightly-artifacts.sh` |

## Artifacts

Same naming as stable with `version=nightly` (e.g. `blvm-nightly-linux-x86_64`, `blvm_nightly_amd64.deb`). Upload uses `gh release upload --clobber`.

Linux + Windows (`.exe`, `.zip`).

## Prerequisites

- [ ] `develop` branch on GitHub
- [ ] Force-push allowed for tag `nightly`
- [ ] Runner: mingw, zip, packaging tools

## Validation

| Check | Expected |
|-------|----------|
| Push `main` | No `nightly-release` |
| Push `develop` | `nightly-release` + `docker-ghcr-nightly` |
| PR → `main` or `develop` | No `nightly-release` (gates only); see [DEVELOP_CHANNEL_PLAN.md](DEVELOP_CHANNEL_PLAN.md) Addendum B |
| Second push | Same tag, new asset checksums |

```bash
curl -LO https://github.com/BTCDecoded/blvm/releases/download/nightly/blvm-nightly-linux-x86_64
docker pull ghcr.io/btcdecoded/blvm:nightly
```
