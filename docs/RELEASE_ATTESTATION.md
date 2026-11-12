# Release attestation

Each stable release (`ci.yml`, job `release`) publishes a record of what was built, from what source, with which inputs, and what the linked consensus code was checked against. Maintainers then rebuild part of the release themselves and sign that record. Operators check all of it with one script.

## Status

| Piece | Status |
|---|---|
| Sigstore build provenance on every uploaded file (binaries, packages, checksums, attestation, bundle) | Built. Covered only the three bare binaries before this change |
| Spec-lock evidence for the linked `blvm-consensus` crate (`spec-evidence` job) | Built. Gates the release. Not yet run in CI |
| Attestation JSON, build config, verification bundle (`scripts/release-attestation.sh`) | Built. Not yet run in CI |
| Static musl binaries, x86_64 and aarch64 (`scripts/ci-build-musl.sh`) | Built, non-blocking until the first green run on the self-hosted runners |
| Maintainer rebuild and signature (`scripts/sign-release.sh`) | Built. Whether the musl build is byte-for-byte reproducible across machines is not yet confirmed |
| Operator check (`scripts/verify-release.sh`) | Built |
| Maintainer signature threshold | Designed. `release-keys/policy.json` enrolls no keys, so the threshold is 0 and signatures are not enforced |
| CI double build with hash comparison in `ci.yml` | Not built. `release.yml` has it for the base variants. `ci.yml` records `ci_double_build: false` |

## Release files

| File | Contents |
|---|---|
| `blvm-<tag>-attestation.json` | Tag, commit, `source_hash`, every release file's sha256, CI gate results, the spec-lock evidence summary, and how maintainer signatures work |
| `blvm-<tag>-build-config.json` | Toolchain, Cargo.lock hash after the version bump, feature set and build script per target, and which targets maintainers can rebuild |
| `blvm-<tag>-verification-bundle.tar.gz` | The two files above, `checksums.sha256`, `spec_lock_verify.json`, the verify and drift logs, and `spec_files.sha256`. Built deterministically (sorted entries, fixed mtime, `gzip -n`) |
| `blvm-<tag>-verification-bundle.<name>.sig.json` | One per maintainer, added after release |

## Hashes that tie it together

- `source_hash` is the sha256 of `git ls-tree -r --full-tree <commit>`, the content of the tagged tree.
- `build_config_hash` is the sha256 of `build-config.json`.
- `spec_hash` is the sha256 of `spec_files.sha256`, which lists the sha256 of each spec file passed to spec-lock in order. It pins the exact spec text the report was produced against.
- A maintainer signature is `blvm-sign-binary bundle` over `bundle:<bundle sha256>:<source_hash>:<build_config_hash>:<spec_hash>`.

## What the spec-lock evidence says

The `spec-evidence` job reads the `blvm-consensus` version and checksum from `Cargo.lock`, confirms the downloaded `.crate` matches that checksum, and runs `cargo spec-lock verify` (strict, Z3) and `check-drift` on that crate's source against `blvm-spec` HEAD. `verify` failing blocks the release. `check-drift` is recorded but does not block. The verifier version is pinned to the one `blvm-consensus` uses for its own release gate.

A passing spec-lock run is not a proof that the code matches the Orange Paper. `summary` in the attestation gives the counts, and `summary.evidence` says which kind of evidence backs each row. Read those numbers before describing a release as checked against the spec.

## Version bump and rebuilds

The release job bumps the version in `Cargo.toml` and `Cargo.lock` before building, and the tag points at the commit before that bump. `scripts/release-bump-version.sh` is the only code that applies the bump, and `sign-release.sh` runs it on a fresh clone of the tag, so the rebuilt binary embeds the same version string.

The musl builds are the rebuild target because they avoid host inputs. They use no CUDA kernels, link statically, use pinned zig and cargo-zigbuild, and remap the home, cargo home, sysroot, repo, and target paths for Rust and C. The glibc and Windows builds are not rebuilt by maintainers. `build-config.json` says why for each.

## Maintainer flow

```bash
scripts/sign-release.sh --tag v0.1.42 --key ~/keys/me.json --name <name> --upload
```

The script checks Sigstore provenance, checks that the bundle agrees with the published files, clones the tag and confirms `source_hash`, applies the bump and confirms the Cargo.lock hash, rebuilds both musl binaries, and signs only if both hashes match. It refuses `-unverified` tags and releases whose spec-lock `verify` did not pass.

## Operator flow

```bash
scripts/verify-release.sh --tag v0.1.42 --file blvm-0.1.42-linux-x86_64-musl
```

The script checks checksums, provenance, and bundle consistency, prints the spec-lock result, and checks maintainer signatures against `release-keys/policy.json` from your local checkout.
