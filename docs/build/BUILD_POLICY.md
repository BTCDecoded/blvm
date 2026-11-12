# Build Policy (Org-Level)

## Separation of Concerns
- **commons**: Orchestration, policies, reusable workflows, shared tools, version topology.
- **blvm-consensus (L2)**: Consensus math + formal verification; publishes libraries and verification bundles.
- **blvm-protocol (L3)**: Protocol abstraction; depends on L2; publishes library.
- **blvm-node (L4)**: Node infra; depends on L2 & L3; publishes binaries.

## Build Order
1. blvm-consensus → verify (tests + spec-lock)
2. blvm-protocol → build lib
3. blvm-node → build binaries

## Version Topology
- Authoritative map: `versions.toml` at the repository root. `commons/versions.toml` is not in this commit.
- Orchestrator reads this file to pin repos.

## Workflows
- Reusable: `.github/workflows/verify_consensus_cached.yml`, `build_lib_cached.yml`. The release workflow is `release.yml`.
- Orchestrator: `.github/workflows/release_orchestrator.yml`.

## Deterministic Builds
- Each repo maintains `rust-toolchain.toml`.
- Builds use `--locked` and fixed toolchain.
- Hash artifacts with `SHA256SUMS`.

## Attestation
- Verification bundles produced by L2 (tests + spec-lock + logs).
- `commons/attestations/` is not in this commit.
- Stable releases attach `blvm-<tag>-attestation.json` and `blvm-<tag>-verification-bundle.tar.gz` (spec-lock report for the linked consensus crate, build config, checksums). See [../RELEASE_ATTESTATION.md](../RELEASE_ATTESTATION.md).
