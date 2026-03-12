# Release Process

## Deterministic Build
- Ensure `rust-toolchain.toml`
- `cargo build --release --locked`
- Hash artifacts to `SHA256SUMS`

## Tests
- Run suites per `cargo test` and repo-specific test documentation

## Version Pins
- Confirm pins match `commons/versions.toml`

## Attestations
- Verification bundle (if L2)
- Upload hashes and bundle receipts to governance attestations
