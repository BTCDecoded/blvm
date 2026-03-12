# Deterministic Seeds and Limits

Use the following guidance to reduce flakiness and ensure reproducibility:

## Property Tests
- Fix the RNG seed via environment when debugging: `PROPTEST_SEED=0x12345678`.
- Limit input sizes to keep execution bounded:
  - Transactions: inputs ≤ 10, outputs ≤ 10
  - Headers chain: ≥ required for difficulty targets; use known fixtures

## Randomized Tests
- Provide a default seed: `RUST_TEST_SEED` env
- Document any suites that intentionally vary with seeds
