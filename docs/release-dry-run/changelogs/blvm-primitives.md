# Changelog

All notable changes to `blvm-primitives` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Every section below is reconstructed from git history. Conventional Commits
were not enforced when those commits were written. Merge commits are omitted.

## [Unreleased]

## [v0.1.28] - 2026-10-22

### Reconstructed

- ci: fetch version list once from crates.io instead of per-iteration API calls [skip ci] ([8669b4ab930b](https://github.com/BTCDecoded/blvm-primitives/commit/8669b4ab930b6a3df7b15cd3d5147fa6c4a09700))
- refactor(serialize): dedupe tx deserialization via witness-aware parser ([a77e75b2fd2b](https://github.com/BTCDecoded/blvm-primitives/commit/a77e75b2fd2b0594b3f44666b326141d2748a725))
- Bump version to 0.1.14 for release [skip ci] ([78a258d6fda9](https://github.com/BTCDecoded/blvm-primitives/commit/78a258d6fda9dd08a531f3fb36d501f0684c7172))
- ci(release): derive next patch from max used version ([56cf2b485ac4](https://github.com/BTCDecoded/blvm-primitives/commit/56cf2b485ac4a9ac56f2692e04785ab9dd35f035))
- fix(manifest): point repository URL at blvm-primitives GitHub repo ([2ba6dbffdd84](https://github.com/BTCDecoded/blvm-primitives/commit/2ba6dbffdd84fa79617bcd955bdd2cd83cf08bad))
- Bump version to 0.1.15 for release [skip ci] ([bac287608f5b](https://github.com/BTCDecoded/blvm-primitives/commit/bac287608f5b0ecce0c88978d8170a07fb3e5e80))
- style(primitives): rustfmt transaction output construction ([d1198be887a3](https://github.com/BTCDecoded/blvm-primitives/commit/d1198be887a3018d8d6cde79e812a47553f5989c))
- Bump version to 0.1.16 for release [skip ci] ([ca0411125dec](https://github.com/BTCDecoded/blvm-primitives/commit/ca0411125dec75f34845b44964b0444277c4aa64))
- ci: bump GitHub Actions to Node.js 24 compatible versions [no ci] ([c6105798289a](https://github.com/BTCDecoded/blvm-primitives/commit/c6105798289addd564aa81ce3c6f335b67ba21a7))
- chore: MSRV 1.85, edition 2024, and unify CI to 1.88.0 ([c8579a9e2605](https://github.com/BTCDecoded/blvm-primitives/commit/c8579a9e260553214e1590fa2b4fefa817822045))
- Bump version to 0.1.17 for release [skip ci] ([2585f0aeb088](https://github.com/BTCDecoded/blvm-primitives/commit/2585f0aeb0880cec9d0930d2f745d079cd4995ca))
- ci: allow manual workflow_dispatch to run Release & publish [skip ci] ([2931ffdc4d77](https://github.com/BTCDecoded/blvm-primitives/commit/2931ffdc4d77c4d986b5deb557a6d263ddab681e))
- feat(types): add Network::Signet (BIP325) ([8249f9680ef8](https://github.com/BTCDecoded/blvm-primitives/commit/8249f9680ef8767a4f6e1ed287eb6cda46778608))
- Bump version to 0.1.18 for release [skip ci] ([e86bc5f98d88](https://github.com/BTCDecoded/blvm-primitives/commit/e86bc5f98d8839e4a3238bc946d643f5a4f345b4))
- dens-keep-ibd: park SBS/Arc process counters with dens leftover ([25d680cb2d22](https://github.com/BTCDecoded/blvm-primitives/commit/25d680cb2d224c21c47099d4f45558f0797ff744))
- style: rustfmt SharedRepr clone and Arc header counter so CI fmt --check passes. ([8d6275a2b01e](https://github.com/BTCDecoded/blvm-primitives/commit/8d6275a2b01e90d518aba099a685a532246ebc72))
- Bump version to 0.1.19 for release [skip ci] ([0e616afd6ce6](https://github.com/BTCDecoded/blvm-primitives/commit/0e616afd6ce6bf05e39f60d93328332b96679d34))
- feat(types): Block::from_parts and live block / tx-slice counters ([cff0348816d9](https://github.com/BTCDecoded/blvm-primitives/commit/cff0348816d9310c91dfb2faa59b4a049c0a43bd))
- feat(config): rename reject_envelope_protocol to reject_unexec_if ([96f79cec94d7](https://github.com/BTCDecoded/blvm-primitives/commit/96f79cec94d73121e5d666ebdf06ddf91e15b355))
- fix(docs): blank line in the BLOCK_LIVE doc so clippy accepts it ([92415a4d08a6](https://github.com/BTCDecoded/blvm-primitives/commit/92415a4d08a6c5c0757fcee0add08b1f3c7b48b4))
- style: rustfmt the block-live wire test so CI fmt --check passes ([8b8af8b4cf28](https://github.com/BTCDecoded/blvm-primitives/commit/8b8af8b4cf2854c5afc1f2d78337e0ec926c3b77))
- Bump version to 0.1.20 for release [skip ci] ([9e3bae27f13d](https://github.com/BTCDecoded/blvm-primitives/commit/9e3bae27f13d32e0c3a67ad1a8587cfad05aa59c))
- docs(types): a block time must be strictly later than the median ([a4d4d63a9a22](https://github.com/BTCDecoded/blvm-primitives/commit/a4d4d63a9a2223d923190f760fc03982adc533ad))
- Bump version to 0.1.21 for release [skip ci] ([2a3313c498a2](https://github.com/BTCDecoded/blvm-primitives/commit/2a3313c498a2838773bcf7ab303e3f6df54ef7c1))
- docs(types): the duplicate-coinbase rule does not deactivate ([6f222b47d3ab](https://github.com/BTCDecoded/blvm-primitives/commit/6f222b47d3ab7cce6acabbdecdcc76b902c3f518))
- Bump version to 0.1.22 for release [skip ci] ([536fbafafa32](https://github.com/BTCDecoded/blvm-primitives/commit/536fbafafa3214531ace0067fb68288cd858406a))
- fix(wire): encode each witness inside its transaction ([0f407d88faec](https://github.com/BTCDecoded/blvm-primitives/commit/0f407d88faec5c90ce160a40e9f299d9c24ed970))
- Bump version to 0.1.23 for release [skip ci] ([7643a56a69aa](https://github.com/BTCDecoded/blvm-primitives/commit/7643a56a69aacfc3d0fd0cf3f5e5531c5390acd5))
- test(primitives): run SHA-NI checks when the CPU has the instruction ([3aa1bb6cbf13](https://github.com/BTCDecoded/blvm-primitives/commit/3aa1bb6cbf132444c3314b937df27d2424ce5c16))
- Bump version to 0.1.24 for release [skip ci] ([9b736df60c68](https://github.com/BTCDecoded/blvm-primitives/commit/9b736df60c6881c74af23abec1d40c0fabe08273))
- feat(primitives): add the testnet4 network id ([2eb561510354](https://github.com/BTCDecoded/blvm-primitives/commit/2eb561510354f5c9fd0f8fe453649dba3ebad3eb))
- Bump version to 0.1.25 for release [skip ci] ([6665d3d27ab7](https://github.com/BTCDecoded/blvm-primitives/commit/6665d3d27ab77ebbd0ffcd6b165bde5cbe48ff33))
- fix(wire): store transaction version as four unsigned bytes ([dacfe7a16c36](https://github.com/BTCDecoded/blvm-primitives/commit/dacfe7a16c36814cba6405d86b2ab4ac42448330))
- Bump version to 0.1.26 for release [skip ci] ([57c3530c7aff](https://github.com/BTCDecoded/blvm-primitives/commit/57c3530c7affea7ef7fbabc1a6f59c36804ab0f1))
- fix(wire): reject a witness flag with only empty stacks ([de97c801317c](https://github.com/BTCDecoded/blvm-primitives/commit/de97c801317c613f28bb1627366997d4050036f5))
- Bump version to 0.1.27 for release [skip ci] ([7b2788819d1c](https://github.com/BTCDecoded/blvm-primitives/commit/7b2788819d1c9b074f12a8090f74d6d30eb53a9b))
- ci: tag each crates.io release as v<version> ([b0953650787f](https://github.com/BTCDecoded/blvm-primitives/commit/b0953650787f66b4eff13f49d9b42b888158b05f))
- Bump version to 0.1.28 for release [skip ci] ([12f03a9eb2ff](https://github.com/BTCDecoded/blvm-primitives/commit/12f03a9eb2ff96be6291e404c41eae25ea62aa2f))

## [v0.1.29] - 2026-10-24

### Reconstructed

- fix(wire): read output scripts without building transactions ([da8c7b6b8750](https://github.com/BTCDecoded/blvm-primitives/commit/da8c7b6b8750fa3bf941bcce9429ae1123949d47))
- style(primitives): cargo fmt after da8c7b6 ([91db33fc2625](https://github.com/BTCDecoded/blvm-primitives/commit/91db33fc2625ce26383d72ab90d4c98a419da00c))
- Bump version to 0.1.29 for release [skip ci] ([1e653b68f9b1](https://github.com/BTCDecoded/blvm-primitives/commit/1e653b68f9b194c400d3f20a372ba942528a903c))

## [v0.1.30] - 2026-10-24

### Reconstructed

- fix(primitives): compile hash comparison on non-x86 targets ([8a43f5a5e0af](https://github.com/BTCDecoded/blvm-primitives/commit/8a43f5a5e0af9294b884e0d3c04d9f1fb8307218))
- Bump version to 0.1.30 for release [skip ci] ([9720541b8897](https://github.com/BTCDecoded/blvm-primitives/commit/9720541b8897c383cbdd0f3f6334d4bcc0af9485))

## [v0.1.31] - 2026-11-04

### Reconstructed

- fix(primitives): name the FindAndDelete script error ([7b7080fd90ed](https://github.com/BTCDecoded/blvm-primitives/commit/7b7080fd90edf8082936c6cb5022c30b3adb20fd))
- Bump version to 0.1.31 for release [skip ci] ([1ce7b0a0d782](https://github.com/BTCDecoded/blvm-primitives/commit/1ce7b0a0d78201da57b0c0058198dad41619043f))

## [v0.1.32] - 2026-11-05

### Reconstructed

- fix(primitives): start regtest BIP34, BIP66, BIP65, and CSV at height 1 ([185a87d8c2f5](https://github.com/BTCDecoded/blvm-primitives/commit/185a87d8c2f54e2da6ef744851698683a6c0d896))
- Bump version to 0.1.32 for release [skip ci] ([67adace586e9](https://github.com/BTCDecoded/blvm-primitives/commit/67adace586e92e9a04b1c8adf66eb0c8091fe850))

## [v0.1.33] - 2026-11-05

### Reconstructed

- fix(primitives): stop loading block-validation env the node never reads ([9710c791aec9](https://github.com/BTCDecoded/blvm-primitives/commit/9710c791aec9a62f744e35275e5c31e15da80a81))
- Bump version to 0.1.33 for release [skip ci] ([426e811ee549](https://github.com/BTCDecoded/blvm-primitives/commit/426e811ee549a59ab703fd373c423eb26cb32c7f))

## [v0.1.34] - 2026-11-11

### Reconstructed

- fix(primitives): keep copy and batch SHA256 inside their stated bounds ([b211ceb9ec3f](https://github.com/BTCDecoded/blvm-primitives/commit/b211ceb9ec3f0b5ed4f5511af0b0e7a0c98f0808))
- Bump version to 0.1.34 for release [skip ci] ([ede6efb409bd](https://github.com/BTCDecoded/blvm-primitives/commit/ede6efb409bdfc93cef9eb9a47a2be5e9094bc59))
