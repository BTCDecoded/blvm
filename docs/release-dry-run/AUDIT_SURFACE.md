# Minimal build audit surface

Measured 2026-11-13T19:28:32Z. This is a dry-run report. It is not a published release artifact.

blvm HEAD: `46c23a0d255fc6e6f8ef3b60d98a556efe23a102`. `Cargo.toml` is dirty.
`Cargo.lock` is dirty.
`src/bin/main.rs` is dirty. A dirty `main.rs` means the binary hash below is not a commit hash.

## Feature flag

`minimal` = `["blvm-node/minimal"]`.

## Hardened profile

`minimal-hardened.toml` sha256 `753b64c7edc7d0f7e9cb3d5f5f045dee6edbffec4be76f34cb19a3673a4c8790` (1599 bytes).

## Binary

`blvm-minimal` sha256 `720564b0728826b2a15367be7ab91c81425e6265c9800453be2c990c71a739dc` (33708104 bytes).

## Lines of Rust under src

- blvm: 2789 lines. HEAD `46c23a0d255fc6e6f8ef3b60d98a556efe23a102`.
- blvm-node: 252011 lines. HEAD `097caf82d51228bfdc559d029090a65184a3d2ef`.
- blvm-consensus: 50594 lines. HEAD `f4e06a68a947153585a449711dafa608dc43dcc4`.
- blvm-protocol: 18544 lines. HEAD `17f9af3a217f14674c1e59fbc7ebd7856a9e8f6b`.
- blvm-primitives: 7068 lines. HEAD `fa1cd6957cf21b534ef1a135bdc00a8fcec604e5`.
- blvm-secp256k1: 26829 lines. HEAD `56c9288a85e83eef654b5da2c68ce3dd3a6be2c4`.
- blvm-muhash: 662 lines. HEAD `a62792854eb64cb9e74a93730ad85e58046c6343`.

## cargo-geiger

Source file: `geiger-minimal-2026-11-13.txt`.
Totals are unsafe/total for functions, expressions, impls, traits, and methods.
Total line: `347/558    30150/38245  764/855 84/89   1027/1488`.
Warnings: `237`.
- blvm: functions 0/0, expressions 2/2, version 0.1.0, marker !
- blvm-node: functions 1/1, expressions 495/537, version 0.1.92, marker !
- blvm-consensus: functions 3/3, expressions 135/137, version 0.1.82, marker !
- blvm-protocol: unknown to the scanner, version 0.1.48, marker ?
- blvm-primitives: functions 26/26, expressions 1663/1663, version 0.1.34, marker !
- blvm-secp256k1: functions 2/2, expressions 167/183, version 0.1.16, marker !
- blvm-muhash: unknown to the scanner, version 0.1.11, marker ?

## Dependencies

The tree is the working copy. It is not HEAD. `Cargo.toml` and `Cargo.lock` were already dirty when this ran.
Unique normal packages in the `--target=all` tree: 233.
Direct normal dependencies:
- anyhow 1.0.104
- blvm-node 0.1.92
- clap 4.4.11
- hex 0.4.3
- rkyv 0.8.18
- serde 1.0.228
- serde_json 1.0.133
- time 0.3.55
- tokio 1.54.1
- toml 0.8.2
- tracing 0.1.41
- tracing-subscriber 0.3.20

Forbidden names in that tree:
- blvm-sdk: absent
- iroh: absent
- blvm-stratum-v2: absent
- blvm-index: absent
- blvm-fees: absent
- blvm-wallet-index: absent
- blvm-monitor: absent
- blvm-miningos: absent
- blvm-governance: absent
- hickory-proto: absent
- hickory-resolver: absent

## What this report is not

It is not the three-artifact parity run, the 50+50 crash gate, or a differential record.
Criterion 11 stays Not met until one binary hash is the candidate for the freeze commit.
