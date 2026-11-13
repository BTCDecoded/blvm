# Changelog

All notable changes to `blvm-consensus` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Every section below is reconstructed from git history. Conventional Commits
were not enforced when those commits were written. Merge commits are omitted.

## [Unreleased]

## [v0.1.0] - 2025-10-16

### Reconstructed

- Initial commit ([f41820438f73](https://github.com/BTCDecoded/blvm-consensus/commit/f41820438f738e663c802d6340cddb8ec67f1c10))
- Complete consensus-proof implementation with comprehensive test suite ([c584b2275375](https://github.com/BTCDecoded/blvm-consensus/commit/c584b2275375cb086d3fd61486afae655b753c5a))

## [v0.1.1] - 2025-11-21

### Reconstructed

- Complete consensus-proof implementation ([d86b084ca92b](https://github.com/BTCDecoded/blvm-consensus/commit/d86b084ca92b87bd059d24f6e3d3d13acba67968))
- feat(verification): Add formal verification to script, SegWit, and Taproot modules ([c45d5fd8eaab](https://github.com/BTCDecoded/blvm-consensus/commit/c45d5fd8eaab38d0bf3dbe679262837b60cae6fa))
- Update consensus validation and build dependencies ([c5e0977e64c2](https://github.com/BTCDecoded/blvm-consensus/commit/c5e0977e64c292975a1507abbf06c81cb65b44bd))
- docs: Organize documentation into structured directories ([6834b2ce581f](https://github.com/BTCDecoded/blvm-consensus/commit/6834b2ce581f313467b0b224344793409ed4e665))
- fuzz: Complete remaining fuzzing infrastructure tasks ([4ffb7727dde2](https://github.com/BTCDecoded/blvm-consensus/commit/4ffb7727dde25af1a7f96bcf8d4c97c6c6a61f47))
- chore: Update codebase with various improvements ([c5caa9381a69](https://github.com/BTCDecoded/blvm-consensus/commit/c5caa9381a695ac026bd93da99c05132b219a16e))
- Fix all compilation errors and test binaries ([4f51c328f574](https://github.com/BTCDecoded/blvm-consensus/commit/4f51c328f574db47e22e431474039470c24de6b0))
- Add benchmark comparison infrastructure and production features benchmarks ([9b12c5dc1015](https://github.com/BTCDecoded/blvm-consensus/commit/9b12c5dc1015c01a9468394cf695ff34709543ee))
- Simplify CI to Linux-only self-hosted runners ([a2ef5baa45ea](https://github.com/BTCDecoded/blvm-consensus/commit/a2ef5baa45ea8cdbd8beed90b35c3acfc7997b13))
- Fix runner label case sensitivity ([e4a97aaf998c](https://github.com/BTCDecoded/blvm-consensus/commit/e4a97aaf998c2ad67e62844fd496ae43f533f76a))
- Update CI workflow to use array format for runner labels ([d5febca4b157](https://github.com/BTCDecoded/blvm-consensus/commit/d5febca4b1573923039ab54f66e53d22c92e471b))
- Update Rust toolchain to 1.82.0 and fix clippy errors ([93258cb94cb2](https://github.com/BTCDecoded/blvm-consensus/commit/93258cb94cb221c5ba6c5049b0ad500d91e37269))
- Fix Rust 1.83 compatibility and clippy errors ([9d3dcc3c9d5c](https://github.com/BTCDecoded/blvm-consensus/commit/9d3dcc3c9d5cba38b5bc3394a9c3876260bfd839))
- Fix remaining clippy errors and rustfmt issues ([0115eea64469](https://github.com/BTCDecoded/blvm-consensus/commit/0115eea6446962b1b0d4c36c7b8725aeefeaaafc))
- Fix test failures: locktime encoding, tx_id calculation, block header validation ([0e54253537e5](https://github.com/BTCDecoded/blvm-consensus/commit/0e54253537e5ba11247b3e3f00e27e70ac316fbd))
- Remove accidentally committed test_compress file ([5990d481ed71](https://github.com/BTCDecoded/blvm-consensus/commit/5990d481ed715e7eb11c6bb9721d64bfee3bd8ba))
- Fix compress_target to match Bitcoin Core's GetCompact algorithm ([e7e112bf4f79](https://github.com/BTCDecoded/blvm-consensus/commit/e7e112bf4f79225a6c07ac66ccfbf0f5577b061a))
- Remove accidentally committed test file ([fed21ab6a2f1](https://github.com/BTCDecoded/blvm-consensus/commit/fed21ab6a2f1c36e088a234307ef029c2c550231))
- Fix round-trip test to allow precision loss in least significant word ([b048ead2b67b](https://github.com/BTCDecoded/blvm-consensus/commit/b048ead2b67bd5f14979921bdf25c6c5a524631a))
- Fix round-trip test: allow precision loss in words 0 and 1 ([b6f89e024874](https://github.com/BTCDecoded/blvm-consensus/commit/b6f89e02487431fdedc8d860611b7ff9c5e2e612))
- Skip problematic test case in round-trip test ([9252f59e3d37](https://github.com/BTCDecoded/blvm-consensus/commit/9252f59e3d3731544bc84486b3db67c18f0ef728))
- Remove accidentally committed debug file ([238512e610eb](https://github.com/BTCDecoded/blvm-consensus/commit/238512e610ebdf6569fea51396dff7b132ae3431))
- Fix remaining test failures ([ae5beaa49565](https://github.com/BTCDecoded/blvm-consensus/commit/ae5beaa49565c771a931192215bb20e1e56b976c))
- Fix mining tests: use valid script pattern for transaction verification ([4e1741a8d106](https://github.com/BTCDecoded/blvm-consensus/commit/4e1741a8d1064887f44d68b684ab7e8d1ce42517))
- Remove accidentally committed test script ([6ae37574c135](https://github.com/BTCDecoded/blvm-consensus/commit/6ae37574c1352a873a63c5e293643db05da923f7))
- Fix and lock Kani proof for compress_target round-trip ([71fd40f6da17](https://github.com/BTCDecoded/blvm-consensus/commit/71fd40f6da17ad17f4d1474d17770341d3dfb9c1))
- chore: trigger CI workflow ([64237388b261](https://github.com/BTCDecoded/blvm-consensus/commit/64237388b261ffd7e053b4f2ab9603d653d04a3b))
- ci: upload build artifacts for downstream dependencies ([70cfec159d18](https://github.com/BTCDecoded/blvm-consensus/commit/70cfec159d18489c421d43921216cb3dfd61b397))
- Fix clippy errors: unused variable and unnecessary casts ([0fe9dc83b52f](https://github.com/BTCDecoded/blvm-consensus/commit/0fe9dc83b52f77396a93f734a2e9d70c02ea5f49))
- Fix security audit: pin cargo-audit to v0.20.0 (compatible with Rust 1.83.0) ([76b572015d58](https://github.com/BTCDecoded/blvm-consensus/commit/76b572015d5826ee3ede439d2676dd6aace5c264))
- Fix property tests: correct target bounds and U256 shift operations ([93242c2d4c09](https://github.com/BTCDecoded/blvm-consensus/commit/93242c2d4c09cbf2c82a80865cedf42d68c9fa08))
- Fix all remaining test failures: overflow protection, property test bounds, and serialization ([c7a0ca2dd4cc](https://github.com/BTCDecoded/blvm-consensus/commit/c7a0ca2dd4cc6e858906f696a23ffa2f5ab2c0f9))
- Fix clippy errors and doctest failures ([7254f5ae09c9](https://github.com/BTCDecoded/blvm-consensus/commit/7254f5ae09c909c173c3cc38d18d6cb511be2493))
- Fix remaining CI failures: test, rustfmt, and make test more lenient ([b6d182fa4ae0](https://github.com/BTCDecoded/blvm-consensus/commit/b6d182fa4ae02cd7c77cde4b8f4c3c1fc258f6ae))
- Fix security audit: use cargo-audit 0.18.0 (compatible with Rust 1.83.0) ([e9197c366f12](https://github.com/BTCDecoded/blvm-consensus/commit/e9197c366f12db353f21b66ab45f3e8298869bd2))
- Fix security audit: use cargo-audit 0.17.6 (compatible with Rust 1.83.0) ([92fdefcd9e66](https://github.com/BTCDecoded/blvm-consensus/commit/92fdefcd9e6610a4c4a2dfa89e183c0da0023c81))
- Fix clippy and rustfmt issues ([b42e8610297e](https://github.com/BTCDecoded/blvm-consensus/commit/b42e8610297e10d97a1bf7490e980457093f10d0))
- Fix all test failures and clippy warnings ([74af092a1cb3](https://github.com/BTCDecoded/blvm-consensus/commit/74af092a1cb3bbb2311eb4d61569312504b2ae3f))
- Fix integration test: coinbase script_sig length requirement ([3337bf6c034e](https://github.com/BTCDecoded/blvm-consensus/commit/3337bf6c034e12269474f146d86d6dddbc848f2c))
- Fix rustfmt formatting in mining.rs ([aebf360416ba](https://github.com/BTCDecoded/blvm-consensus/commit/aebf360416baa206b7c9aeb78623d874cc0d0d9d))
- Fix BIP9 soft fork activation logic ([c36c58215314](https://github.com/BTCDecoded/blvm-consensus/commit/c36c58215314d0bb1f8e9ea785c3b411d0337642))
- Fix BIP9 activation logic: preserve lock-in detection height ([8ba580de77cd](https://github.com/BTCDecoded/blvm-consensus/commit/8ba580de77cd572dc0851272f903b132dfda6c74))
- Fix remaining soft_fork_activation test failures ([fc2e5c4e8b70](https://github.com/BTCDecoded/blvm-consensus/commit/fc2e5c4e8b7091cb3a67232595ad9a6152f907b4))
- Fix rustfmt formatting in soft_fork_activation.rs ([bd4ac290eb03](https://github.com/BTCDecoded/blvm-consensus/commit/bd4ac290eb03732082dadd3e8620c85c5f048d2b))
- Fix time_based_consensus test: correct minimal encoding assertion ([cb0888931567](https://github.com/BTCDecoded/blvm-consensus/commit/cb0888931567b5ab460020c95b8b011daad84652))
- Fix test_bip112_csv_sequence_combinations: correct CSV disabled sequence ([6a6e8a741682](https://github.com/BTCDecoded/blvm-consensus/commit/6a6e8a74168242b81b828fc2e5719b6d3bbe9a80))
- Add CI-aware test helpers for performance tests ([2450639890e5](https://github.com/BTCDecoded/blvm-consensus/commit/2450639890e5e80959816d24ab83afa33b1df026))
- Fix remaining production_integration_tests timeout for CI ([a2b5e0b6e81f](https://github.com/BTCDecoded/blvm-consensus/commit/a2b5e0b6e81fbe2d9ec3ba31c1b50049b01b47e0))
- Fix test coverage step: pin cargo-tarpaulin to compatible version ([722e5efa987d](https://github.com/BTCDecoded/blvm-consensus/commit/722e5efa987da0822af29ce4543be1df6e9eee90))
- Fix compilation errors in benchmarks ([2447ebcae32a](https://github.com/BTCDecoded/blvm-consensus/commit/2447ebcae32a336c38669839dfb80116dea397ec))
- Fix test coverage step: use lowercase 'xml' format ([bc80ce89e52a](https://github.com/BTCDecoded/blvm-consensus/commit/bc80ce89e52a76c2421d6f155fa33d407b34b400))
- Try cargo-audit 0.16.0 for Rust 1.83.0 compatibility ([8f49b54f28cf](https://github.com/BTCDecoded/blvm-consensus/commit/8f49b54f28cf44784ca088531140a11c8f3f3cc8))
- feat: Implement BLLVM optimizations (Phase 1 & 2) with comprehensive testing ([ad2e3415c411](https://github.com/BTCDecoded/blvm-consensus/commit/ad2e3415c41140ac341af74210579d080bf6688f))
- refactor: Improve BLLVM organization and documentation ([1d6b9fb9c185](https://github.com/BTCDecoded/blvm-consensus/commit/1d6b9fb9c18550bed4974d8506510b9d9a692aba))
- Make security audit and coverage non-blocking ([04512790b484](https://github.com/BTCDecoded/blvm-consensus/commit/04512790b484d1195f91989bb7a69c7bf9b0a33b))
- Fix security audit and coverage: update Rust toolchain to 1.88.0 ([03fd48b45020](https://github.com/BTCDecoded/blvm-consensus/commit/03fd48b4502058f36120b1ab62be9618f8b1f14d))
- Update all Rust toolchain versions to 1.88.0 in workflow ([0f89af97b6a5](https://github.com/BTCDecoded/blvm-consensus/commit/0f89af97b6a521ae5c57ea286b89d0f1bdb21cb4))
- Fix: Update rust-toolchain.toml to 1.88.0 ([5d93d4dad547](https://github.com/BTCDecoded/blvm-consensus/commit/5d93d4dad5471d312e0eb2acdaee8726e342f004))
- Fix clippy errors: deprecated functions, unused imports, useless comparisons ([bf5352b2d303](https://github.com/BTCDecoded/blvm-consensus/commit/bf5352b2d303f1044d7e86137b409ce8d2751b4b))
- Fix clippy errors: format! strings and unused imports ([accd50b8fa36](https://github.com/BTCDecoded/blvm-consensus/commit/accd50b8fa364114735acfb4ec040a14efcec816))
- Fix remaining format! string errors in block.rs ([f7b86c750a54](https://github.com/BTCDecoded/blvm-consensus/commit/f7b86c750a5409f9fc33bb202c7253f1cd88bcac))
- Fix: Update cargo-audit to 0.21.0 to support Cargo.lock format version 4 ([530f9988bf1e](https://github.com/BTCDecoded/blvm-consensus/commit/530f9988bf1eb3bf6445b5ed7ea860fc0187dc7c))
- Add benchmarking utilities for reproducible benchmarks ([3c2152e1886c](https://github.com/BTCDecoded/blvm-consensus/commit/3c2152e1886cd5e6c7a1816fb9b700cc07627b47))
- Fix: Use cargo-audit 0.20.0 instead of 0.21.0 (0.21.0 requires Rust 1.89) ([bc537a2125f8](https://github.com/BTCDecoded/blvm-consensus/commit/bc537a2125f81c243f3a2a42458e17b71e7c2f89))
- Update repository references to new names (bllvm-*) ([685de957bb70](https://github.com/BTCDecoded/blvm-consensus/commit/685de957bb709731b68a28253d7f1f17e8c2bd37))
- docs: Add reference to master status document ([66ddc6f18c8b](https://github.com/BTCDecoded/blvm-consensus/commit/66ddc6f18c8b0e47524e7e8ddb7a3ee93611cc29))
- docs: Update bllvm-sdk description to 'developer toolkit' ([00546157316d](https://github.com/BTCDecoded/blvm-consensus/commit/00546157316d6f38bf161f8dd3ec89e1ef1fec80))
- Add realistic block validation benchmark for fair comparison with Bitcoin Core ([cc3106851123](https://github.com/BTCDecoded/blvm-consensus/commit/cc3106851123e9b723dfa0080581a4bde365a331))
- feat: Add Intel SHA-NI single-hash optimization + integrate with block validation ([201d404d9845](https://github.com/BTCDecoded/blvm-consensus/commit/201d404d9845963a5a48fee16d026fa392dd1fd5))
- feat: Add focused performance benchmarks ([aa1685fd77e0](https://github.com/BTCDecoded/blvm-consensus/commit/aa1685fd77e0dc78f24a337d9712273462c9ce56))
- docs: Add performance summary with CPU feature verification ([50742d06834e](https://github.com/BTCDecoded/blvm-consensus/commit/50742d06834e9e9b42923833a7c5bdc1c9c87f48))
- feat: Add low-hanging fruit optimizations ([75ed30c2f5d5](https://github.com/BTCDecoded/blvm-consensus/commit/75ed30c2f5d537c74937d64c797eb447ed1040a1))
- fix: Resolve all compiler warnings ([6ec5bab1448c](https://github.com/BTCDecoded/blvm-consensus/commit/6ec5bab1448c4ec78a8aac98b96d8428bd6c378f))
- fix: Add missing crypto module declaration in lib.rs ([8a047e4361c1](https://github.com/BTCDecoded/blvm-consensus/commit/8a047e4361c105435569d48ce776dfb639d27c0d))
- fix: Update test imports from consensus_proof to bllvm_consensus ([ba96a3fa7e76](https://github.com/BTCDecoded/blvm-consensus/commit/ba96a3fa7e762ca0001503a558b13e62ed544ff6))
- fix: Resolve Clippy and Rustfmt errors ([aaaf990c19a1](https://github.com/BTCDecoded/blvm-consensus/commit/aaaf990c19a1e70f8635235c696c581de9266017))
- fix: Resolve remaining Clippy boolean expression errors ([300cd8aebf65](https://github.com/BTCDecoded/blvm-consensus/commit/300cd8aebf659b69661d0df1114903ade171a97c))
- fix: Remove remaining boolean expression logic bug ([ef8f22b3cb61](https://github.com/BTCDecoded/blvm-consensus/commit/ef8f22b3cb619a4f931c41083c00748d47339f8c))
- fix: Resolve all remaining Clippy boolean expression errors ([aef486393ff1](https://github.com/BTCDecoded/blvm-consensus/commit/aef486393ff165aa3c4a4f07f84fda8f974f8606))
- fix: Resolve final Clippy error (absurd extreme comparison) ([f990433176a8](https://github.com/BTCDecoded/blvm-consensus/commit/f990433176a8e872a8b7623b077160b22afec7f0))
- fix: Correct SHA-NI final hash extraction ([5cdff481dc8e](https://github.com/BTCDecoded/blvm-consensus/commit/5cdff481dc8e83862fd5353b7253caae15e5102f))
- fix: Correct SHA-NI hash extraction with proper reordering ([46b69aeb619f](https://github.com/BTCDecoded/blvm-consensus/commit/46b69aeb619f669271862ccf83c3f68b562a22ea))
- fix(pow): make expand_target public for protocol layer access ([111dea70b7b2](https://github.com/BTCDecoded/blvm-consensus/commit/111dea70b7b246d625bf9435714bf156631f68dc))
- Fix kani conditional compilation: use #[cfg(kani)] instead of #[cfg(feature = "verify")] ([9563af77ee08](https://github.com/BTCDecoded/blvm-consensus/commit/9563af77ee08ba656fcb00292857d720b276d466))
- Fix compilation errors with --all-features ([09285963b304](https://github.com/BTCDecoded/blvm-consensus/commit/09285963b304d98e59e005c924ee6fc4b168e4a0))
- Fix GenericArray type annotation for k256 verify ([184709564fa7](https://github.com/BTCDecoded/blvm-consensus/commit/184709564fa7f82298b4599cb3bb585d415516d5))
- Fix k256 verify: use Sha256::digest for message hash ([12ea87094419](https://github.com/BTCDecoded/blvm-consensus/commit/12ea87094419c64ebe6f734331e83a6993960986))
- Fix clippy and rustfmt errors ([4c9649baada9](https://github.com/BTCDecoded/blvm-consensus/commit/4c9649baada9641ad8639629ec7cf55f6ab17e0f))
- Skip sha_ni tests when SHA-NI is not available ([157bc8d34c46](https://github.com/BTCDecoded/blvm-consensus/commit/157bc8d34c465e27668f4412ebc5cdae0725e76d))
- Ignore sha_ni tests in CI - implementation has bugs ([1da4b024b9ef](https://github.com/BTCDecoded/blvm-consensus/commit/1da4b024b9eff75b15845b0f06819dbb15e29267))
- Fix doctest imports - use correct crate name bllvm_consensus ([72e0be150ea2](https://github.com/BTCDecoded/blvm-consensus/commit/72e0be150ea272f4ed4bd9c44ed60e965440ee02))
- Fix all doctest imports - replace consensus_proof with bllvm_consensus ([2781136738da](https://github.com/BTCDecoded/blvm-consensus/commit/2781136738da6909b3703ee0d133cf69efa10b7a))
- Fix remaining consensus_proof references in doctest code bodies ([28439034dda5](https://github.com/BTCDecoded/blvm-consensus/commit/28439034dda51c35a7dd37a052c37ba39fa6c2b8))
- Fix rsync cache: ensure target cache directory exists before syncing ([ac13d6c0b564](https://github.com/BTCDecoded/blvm-consensus/commit/ac13d6c0b564b047d32eabfaac25d9ccf8051c64))
- Make repository-dispatch non-blocking to prevent build job failure ([ee6fc66e16d5](https://github.com/BTCDecoded/blvm-consensus/commit/ee6fc66e16d5e6b8ddb63ddeaa6c50df20e2db43))
- Use REPO_ACCESS_TOKEN for repository-dispatch (org-level secret) ([6867dd9d9d76](https://github.com/BTCDecoded/blvm-consensus/commit/6867dd9d9d76f83bba07da79d9700886818c43c4))
- Upgrade cargo-audit to 0.22.0 for Cargo.lock format version 4 support ([241ef5dc76fb](https://github.com/BTCDecoded/blvm-consensus/commit/241ef5dc76fbf978f9e6de763955b71f371ef6a1))
- Add --locked flag to cargo-audit installation to use exact dependency versions ([1cba86189ada](https://github.com/BTCDecoded/blvm-consensus/commit/1cba86189adab4f1c252919c30425e07ee9b467f))
- Upgrade Rust to 1.89.0 for Security Audit job (required by cargo-audit 0.22.0) ([0b8ca4b717ec](https://github.com/BTCDecoded/blvm-consensus/commit/0b8ca4b717ec5cd4acc7947f2fd7e516849c1edc))
- Update serde to 1.0.228 for iroh 0.95 compatibility ([4b583fb297de](https://github.com/BTCDecoded/blvm-consensus/commit/4b583fb297de379a792e8bd250defda4d04154e7))
- Fix Bitcoin difficulty adjustment off-by-one error (with compatibility option) ([77cc2051fd78](https://github.com/BTCDecoded/blvm-consensus/commit/77cc2051fd78f47e9ddeb4a6b90540a100277091))
- Add comprehensive mathematical protections across consensus-critical modules ([f4716c80c360](https://github.com/BTCDecoded/blvm-consensus/commit/f4716c80c36062a4e850822e18f4a9082c48f98a))
- feat: Senior Rust engineer improvements - Phase 1-3 ([0517dd6e11ff](https://github.com/BTCDecoded/blvm-consensus/commit/0517dd6e11ff9a0219ee2b79b4903e56f50bd5e6))
- refactor: Remove bench definitions - moved to bllvm-bench ([e201393b9ac6](https://github.com/BTCDecoded/blvm-consensus/commit/e201393b9ac6ff3ac74cfea2dbbf98fc202ceaa3))
- Fix compilation errors: Convert Vec to SmallVec/Box for production feature ([8eb0169b54fd](https://github.com/BTCDecoded/blvm-consensus/commit/8eb0169b54fdb9938324bf685cd3fb1589156e41))
- fix: add ctv feature ([9ac2a2a63fa2](https://github.com/BTCDecoded/blvm-consensus/commit/9ac2a2a63fa2e1d0a330709d28d9f09100c18b78))
- Complete edge case coverage: Add CVE-2012-2459 and CVE-2018-17144 tests ([5555df1f4fcf](https://github.com/BTCDecoded/blvm-consensus/commit/5555df1f4fcfd891c0118b972806dbbfdf1de6af))
- Fix all compile-time warnings ([b55303c174b8](https://github.com/BTCDecoded/blvm-consensus/commit/b55303c174b8453aa0400232ea1df03b2fb1e21c))
- Fix all compilation warnings and complete TODOs ([1a3787598acd](https://github.com/BTCDecoded/blvm-consensus/commit/1a3787598acdbccdcdff0d960fcba33d807db36c))
- fix: disable sha2-asm for Windows targets ([0dc158ee8cc2](https://github.com/BTCDecoded/blvm-consensus/commit/0dc158ee8cc2d83dbaed0f5aeacd1f4bd26f1f15))
- fix: add explicit x86_64-pc-windows-gnu target config for sha2 ([87327a62cb66](https://github.com/BTCDecoded/blvm-consensus/commit/87327a62cb66f079880d29325d9bd0bdedc8d0be))
- fix: restore sha2 in main dependencies to fix Linux builds ([c1740aa479aa](https://github.com/BTCDecoded/blvm-consensus/commit/c1740aa479aa3c0a9a97208ad150d7927ef42648))
- fix: remove duplicate Windows target dependency config ([fe662b36027c](https://github.com/BTCDecoded/blvm-consensus/commit/fe662b36027ce36ab862c4252fe146cd28362a08))
- fix: properly disable sha2-asm for Windows using target-specific deps ([378895add545](https://github.com/BTCDecoded/blvm-consensus/commit/378895add545f63ee7039e67c6792e6d187cfed7))
- Organize documentation: archive historical/status docs, create README structure ([84029a95f62b](https://github.com/BTCDecoded/blvm-consensus/commit/84029a95f62bb419496fdeed9240aed8db29945a))
- Update .gitignore: remove target/, fuzz/target/, and Cargo.lock from tracking ([f8fceda68b0f](https://github.com/BTCDecoded/blvm-consensus/commit/f8fceda68b0f1ee572db5402d8b0b47c4b6af0ce))
- Add benchmark_results.txt to .gitignore and remove from tracking ([c484ed762f53](https://github.com/BTCDecoded/blvm-consensus/commit/c484ed762f531ba28b686b6ccb500f1d91865bfc))
- Archive historical documentation to bllvm-docs ([62835578ac22](https://github.com/BTCDecoded/blvm-consensus/commit/62835578ac22f2429ac25997263a360d2a79c9f5))
- fix: pin k256 to exact version ([66beb13d648c](https://github.com/BTCDecoded/blvm-consensus/commit/66beb13d648c9eb0b8cd1a71cb467deeb5cc5c21))
- Archive outdated documentation ([9bcbc25732dd](https://github.com/BTCDecoded/blvm-consensus/commit/9bcbc25732dd7f3c8c68ef7bd3af694569731acb))
- feat: add BIP119 CTV validation and integration tests ([fc920692c897](https://github.com/BTCDecoded/blvm-consensus/commit/fc920692c89789f4e177f651182453621a8d842e))
- refactor(tests): remove redundant tests and consolidate helpers ([e114a454b209](https://github.com/BTCDecoded/blvm-consensus/commit/e114a454b209aa6b2c84a22b0170d51b9565567d))
- refactor(tests): consolidate more duplicate test helpers ([8f56c2364c99](https://github.com/BTCDecoded/blvm-consensus/commit/8f56c2364c99938c05508cdd3ae02c95cd9121fa))
- chore(tests): remove trailing empty lines from mempool_rbf_tests.rs ([1b9c752e9161](https://github.com/BTCDecoded/blvm-consensus/commit/1b9c752e9161c035b2feedbbf7d082486b49aafe))
- feat: Add inline hints to hot functions for LLVM optimization ([ebbe8d41be39](https://github.com/BTCDecoded/blvm-consensus/commit/ebbe8d41be395955f2c78c032053dd9846fb0a66))
- feat: Integrate cache-aligned structures and Kani-proven bounds ([ef64f233952d](https://github.com/BTCDecoded/blvm-consensus/commit/ef64f233952dacea3a92605f5d715ce4c8c31bce))
- feat: Expand Kani-proven bounds and consolidate function implementations ([5b4761c96a74](https://github.com/BTCDecoded/blvm-consensus/commit/5b4761c96a74f7801084f23cdaa9dd956af5ad10))
- Fix SHA-NI implementation using Bitcoin Core's Shuffle/Unshuffle pattern ([f5de95e083b1](https://github.com/BTCDecoded/blvm-consensus/commit/f5de95e083b172d958ee0aaae9f4a2ef2909a066))
- Fix coverage timeout: add tarpaulin timeout and reduce slow test ranges ([8e272b215fe9](https://github.com/BTCDecoded/blvm-consensus/commit/8e272b215fe99cb7eda181e24523d8d6d0cdbbf3))
- Fix prop_block_subsidy_constant_time: make timeout lenient under coverage ([256cac5caafb](https://github.com/BTCDecoded/blvm-consensus/commit/256cac5caafb81b05cc8da184adf1189a9207000))
- Check for CARGO_TARPAULIN env var in addition to TARPAULIN ([38ca6f8d8746](https://github.com/BTCDecoded/blvm-consensus/commit/38ca6f8d874635a65ad168490353950341f3113b))
- Fix tarpaulin flag: use --timeout instead of --test-timeout ([65024507625a](https://github.com/BTCDecoded/blvm-consensus/commit/65024507625a81b707fa2a0473e04feadeff017b))
- Make performance tests more lenient to handle system load variations ([d38379833973](https://github.com/BTCDecoded/blvm-consensus/commit/d38379833973d555e0ad3c1b8567a3bd98038ec6))
- Add orchestrator trigger: trigger release orchestrator on push to main ([fe562be9d4fd](https://github.com/BTCDecoded/blvm-consensus/commit/fe562be9d4fd1045c5544eb2562fd35d17ffafc9))
- Standardize CI workflow: security depends on setup, build depends on all checks ([4b9e3919814d](https://github.com/BTCDecoded/blvm-consensus/commit/4b9e3919814def07ce6e4f038d0fa52121ef47b4))
- Fix CI: performance test boundary and tarpaulin timeouts ([1f579cb45585](https://github.com/BTCDecoded/blvm-consensus/commit/1f579cb45585059c17b9590d93890af05b1bf781))
- Fix property test ranges: use helper functions for conditional ranges ([d7ef92ea1256](https://github.com/BTCDecoded/blvm-consensus/commit/d7ef92ea1256d5e8b68dc57cba073925c5bbf170))
- Add independent release workflow for bllvm-consensus ([1d1ffdbe01dc](https://github.com/BTCDecoded/blvm-consensus/commit/1d1ffdbe01dc93f56e6a90e0c08b56fac2e2b95b))
- Increase block subsidy performance test timeout to 10ms ([4d96ae84e15a](https://github.com/BTCDecoded/blvm-consensus/commit/4d96ae84e15abd68588ffe90ac70c518c54ad408))
- Add release job to CI workflow ([42edafc8d7ab](https://github.com/BTCDecoded/blvm-consensus/commit/42edafc8d7ab8466bcc01b21781f4a469bbb066e))
- Fix version determination to only match package version ([92e3bef4be46](https://github.com/BTCDecoded/blvm-consensus/commit/92e3bef4be461980048f237e914172c93af464e8))
- Fix version extraction: use grep instead of awk ([f69124436188](https://github.com/BTCDecoded/blvm-consensus/commit/f6912443618895d960ebc45c73143a0674fd493e))
- Commit Cargo.toml changes before publish ([fde05275122f](https://github.com/BTCDecoded/blvm-consensus/commit/fde05275122ffb2fe74d4d4d38abbae1e1996a1d))
- Update kani-verifier version to 0.66 for crates.io compatibility ([2548a3af47e0](https://github.com/BTCDecoded/blvm-consensus/commit/2548a3af47e0ce964d779ebce26e0f51a9f2d49b))
- Regenerate Cargo.lock before publish to fix kani-verifier version ([86f2c730f4dd](https://github.com/BTCDecoded/blvm-consensus/commit/86f2c730f4ddf7e3c811d8e8adb71b8b958fff83))
- Fix version update and Cargo.lock regeneration order ([3e57309385af](https://github.com/BTCDecoded/blvm-consensus/commit/3e57309385af725162f0b03c09465bb017b1d7a5))
- Fix Cargo.lock regeneration order and version update ([c84464a55ae0](https://github.com/BTCDecoded/blvm-consensus/commit/c84464a55ae0fc1d77ec900341ed829fc4e9746a))
- Improve version update and add verification ([736f305a725b](https://github.com/BTCDecoded/blvm-consensus/commit/736f305a725b21934a94d7051366fa9608630357))

## [v0.1.1-unverified] - 2025-11-22

### Reconstructed

- Enhance release pipeline with mathematical verification and pre-release checks ([57034b696a03](https://github.com/BTCDecoded/blvm-consensus/commit/57034b696a03dc8558aa5c4dd6685c79a20e9a6b))
- Fix Kani installation and PATH handling in verify job ([7f32d6f85f87](https://github.com/BTCDecoded/blvm-consensus/commit/7f32d6f85f877a7f1e44c8232fe2087fd52ceeaa))
- Remove Kani installation step - use pre-installed Kani on runner ([434263d615d8](https://github.com/BTCDecoded/blvm-consensus/commit/434263d615d861c07e1218cfdf2c81f92eb08747))
- Fix Kani command - use 'cargo kani' instead of 'kani' ([6c18af6d254f](https://github.com/BTCDecoded/blvm-consensus/commit/6c18af6d254fed0b7d6f167ab112bc5aa0be6690))
- Simplify Kani verification step name to 'Verify' ([c9d7f0a115c1](https://github.com/BTCDecoded/blvm-consensus/commit/c9d7f0a115c1150991b478c63bfffc065b3a8a9f))
- Revert step name to 'Run Kani proofs' ([4fbd92eddbb5](https://github.com/BTCDecoded/blvm-consensus/commit/4fbd92eddbb5e3a8316d5837bda9243414eacc90))
- Change job name from 'Mathematical Verification' to 'Verify' ([8a6a3e9c0ea8](https://github.com/BTCDecoded/blvm-consensus/commit/8a6a3e9c0ea8324fcb81de147e91aa5b7d85bfab))
- Fix Kani proof compilation errors in taproot.rs ([bae5bc22a118](https://github.com/BTCDecoded/blvm-consensus/commit/bae5bc22a11806e67bd7603e5ceeb1aa50635c7a))
- Fix unused variable warnings in Kani proofs ([84fb846086be](https://github.com/BTCDecoded/blvm-consensus/commit/84fb846086be90e38ac49b8db1f6135746c0e66e))
- Fix duplicate kani_proofs modules and syntax error ([892f61874575](https://github.com/BTCDecoded/blvm-consensus/commit/892f6187457547578b6f58249f50597bcd8eedb8))
- Fix Kani proof compilation: replace kani::any() with helper functions ([8232c51b826f](https://github.com/BTCDecoded/blvm-consensus/commit/8232c51b826f1370d0b587e2389e248c328cf9cf))
- Fix rustfmt formatting in segwit.rs ([a82f2a342956](https://github.com/BTCDecoded/blvm-consensus/commit/a82f2a34295659693a30f1c664fec4ba74d7b973))
- Fix Kani compilation: replace kani::any() with helper functions ([23575b838e02](https://github.com/BTCDecoded/blvm-consensus/commit/23575b838e027b0d772d30bd78e52a961d2eddda))
- Fix remaining Kani compilation errors ([8f6184f1e37f](https://github.com/BTCDecoded/blvm-consensus/commit/8f6184f1e37f39b4a9fcdb5297af903fd71b3c6a))
- Fix remaining Kani compilation errors ([9f906ac76baa](https://github.com/BTCDecoded/blvm-consensus/commit/9f906ac76baa431f804867cc1f381b42bc0deb20))
- Fix final Kani compilation errors ([fb0834dfbc3d](https://github.com/BTCDecoded/blvm-consensus/commit/fb0834dfbc3d4e820b771a289c6f8ab6c3252f64))
- Fix rustfmt formatting issues ([8eddd7c557ac](https://github.com/BTCDecoded/blvm-consensus/commit/8eddd7c557acb32992c77d19dd0abea1ce86ecff))
- Fix mutable tx in economic.rs Kani proof ([c46da52b6bed](https://github.com/BTCDecoded/blvm-consensus/commit/c46da52b6bedc75626b8a77e671bb6dc667e04e2))
- Fix unwind attributes: use integer literals with source constant comments ([977adbd3fa56](https://github.com/BTCDecoded/blvm-consensus/commit/977adbd3fa566cf86197c9e0ddbedfa02a527f10))
- Optimize BIP113 Kani proofs: add unwind attributes and reduce bounds for tractability ([97889d1cb71c](https://github.com/BTCDecoded/blvm-consensus/commit/97889d1cb71ceb799996fc08b8466a67003f7059))
- Further reduce BIP113 proof bounds to avoid sort_unstable unwinding issues ([13165fdb796d](https://github.com/BTCDecoded/blvm-consensus/commit/13165fdb796dea144933005030f89c78fa9a95d3))
- Add explicit header_count > 0 assumption to help Kani prune paths early ([abf10ec1d23c](https://github.com/BTCDecoded/blvm-consensus/commit/abf10ec1d23c88c584ad12cad5f9f20709567082))
- Disable kani_bip113_median_time_ge_minimum due to sort_unstable unwinding issues ([1931ef818b65](https://github.com/BTCDecoded/blvm-consensus/commit/1931ef818b652f926e05c068399bf53a53b987d5))
- Optimize BIP113 proof: use u8 for header_count to help Kani prune paths early ([be2196d52e02](https://github.com/BTCDecoded/blvm-consensus/commit/be2196d52e0271c65b34e2d726eebfad90feba6a))
- Fix cargo-audit version compatibility with Rust 1.88.0 ([338c977550d7](https://github.com/BTCDecoded/blvm-consensus/commit/338c977550d7784f951f2abf90caae3027de8d17))
- Improve Kani verification step with timeout and output filtering ([ee4287de0411](https://github.com/BTCDecoded/blvm-consensus/commit/ee4287de0411e828bf53c9e6deb84a4a5e2c61c0))
- Optimize Kani verification and test execution ([3d67fa377ace](https://github.com/BTCDecoded/blvm-consensus/commit/3d67fa377acec682c19b80aa1beaff5087b16872))
- Remove all timeouts and maximize Kani proof parallelization ([286f76faf0d9](https://github.com/BTCDecoded/blvm-consensus/commit/286f76faf0d9185de83b93fc94ec4d0dae96d201))
- Fix Kani proof: constrain coinbase value to not exceed MAX_MONEY ([05f93502b80f](https://github.com/BTCDecoded/blvm-consensus/commit/05f93502b80f8b810ec10ccf625731b15b052858))
- Set maximum timeout for Kani verification job ([0caf6fc5ec58](https://github.com/BTCDecoded/blvm-consensus/commit/0caf6fc5ec58897c86be2d96fb6f5b5587e0450f))
- Fix Kani proof failure and improve error handling ([a66cdd264a54](https://github.com/BTCDecoded/blvm-consensus/commit/a66cdd264a5472d6c51d56050684f7272beb38f4))
- Split Kani proofs into Fast/Medium and Slow steps ([53ce0846a661](https://github.com/BTCDecoded/blvm-consensus/commit/53ce0846a6618f627893ed35c71ab53c1cb54b1a))
- Reduce Kani parallelism to prevent OOM and add perf tag to verify step ([c58b8ae6fc1e](https://github.com/BTCDecoded/blvm-consensus/commit/c58b8ae6fc1e57587e3a63b7ce892a0d4dfe9bd5))
- Implement tiered Kani proof execution based on event type ([0cdb00991ac3](https://github.com/BTCDecoded/blvm-consensus/commit/0cdb00991ac33063e534f75379a75fa5ad2bc394))
- Add Kani optimization guide and enable faster solver ([416157789e9a](https://github.com/BTCDecoded/blvm-consensus/commit/416157789e9a9ebb960e945730a63e3c5c9db309))
- Optimize Kani proofs while maintaining mathematical validity ([f3bd42c124c8](https://github.com/BTCDecoded/blvm-consensus/commit/f3bd42c124c8edbafaee37dc900e2b7f80287dad))
- Fix Kani jobs flag and formatting ([e3ffddae0bb8](https://github.com/BTCDecoded/blvm-consensus/commit/e3ffddae0bb8d994177309054c2b7ec5076b30b4))
- Change non-verification jobs to use 'builds' runners ([abff9138541b](https://github.com/BTCDecoded/blvm-consensus/commit/abff9138541b8c0100a2c05f90c72bd36b34b20b))
- Add GitHub attestations for releases ([6f60c5ff5254](https://github.com/BTCDecoded/blvm-consensus/commit/6f60c5ff52548d7706827bade488ba45cabbe022))
- Optimize Kani unwind bounds: remove low-value proofs and reduce bounds ([61229faafb94](https://github.com/BTCDecoded/blvm-consensus/commit/61229faafb943111c85ee0bf8dd31bb10bbd2ab9))
- Add skip_verification workflow input ([ffe95385b4e3](https://github.com/BTCDecoded/blvm-consensus/commit/ffe95385b4e3e0b85882ecb07c9ca6c14507b760))
- Add skip condition to Collect build metadata step ([d3b52ae8744d](https://github.com/BTCDecoded/blvm-consensus/commit/d3b52ae8744d3b0852975dd085eb4151a960dcf3))
- Fix: Add workflow_dispatch to build and release job conditions ([37e9e0064f58](https://github.com/BTCDecoded/blvm-consensus/commit/37e9e0064f580d42e033a4ca6bde3079532d1ef1))
- Fix: Handle 'crate already exists' error gracefully ([1cbf1cb0226d](https://github.com/BTCDecoded/blvm-consensus/commit/1cbf1cb0226d1a998bc3e15a84aaeaf533b6d019))

## [v0.1.2] - 2025-11-23

### Reconstructed

- Fix: Add enhanced debugging for publish step ([94b49601f076](https://github.com/BTCDecoded/blvm-consensus/commit/94b49601f0763baf65db854845f8363a4f0394a1))
- Fix: Update release notes to handle missing crates.io versions ([92c843c212dc](https://github.com/BTCDecoded/blvm-consensus/commit/92c843c212dc5e0273c11cd1890c21c26542ddc8))
- Fix: Correct release notes syntax for conditional links ([24f63b8f90d4](https://github.com/BTCDecoded/blvm-consensus/commit/24f63b8f90d4fc7b695b2a91290948aeba6ba3a4))
- Add skip_tests workflow input option ([593eb16415f9](https://github.com/BTCDecoded/blvm-consensus/commit/593eb16415f99cf5d89602ab8cac1d1544df7e86))
- Simplify version tag: untested counts as unverified ([9e1f8e23777b](https://github.com/BTCDecoded/blvm-consensus/commit/9e1f8e23777b61170c9d86282b80a016da54b13d))
- Fix: Restructure conditional expressions to avoid shell syntax errors ([c77a77829470](https://github.com/BTCDecoded/blvm-consensus/commit/c77a7782947073ee499fdb03406f849aecc26d80))
- Make verify job conditional when skip_verification is true ([4255d1e15887](https://github.com/BTCDecoded/blvm-consensus/commit/4255d1e1588786589a40f743c2b0b65e7426096b))
- Fix: Update release job condition to handle skipped verify ([f98f947dc81b](https://github.com/BTCDecoded/blvm-consensus/commit/f98f947dc81bb31e94353762e19749fd18101595))
- Fix: Correct conditional logic for verify dependency ([a49adea3d026](https://github.com/BTCDecoded/blvm-consensus/commit/a49adea3d0263f0e83cae0851c6d4012ba6ca1be))
- Make test job conditional when skip_tests is true ([3e531f67ff44](https://github.com/BTCDecoded/blvm-consensus/commit/3e531f67ff44fefad51cf45a7503bcef7497e813))
- Fix: Update release job condition to handle skipped tests ([e4e0ea20523e](https://github.com/BTCDecoded/blvm-consensus/commit/e4e0ea20523efd7861d271177c5e1c90ca0b099f))
- Fix: Avoid shell syntax errors in version determination ([a28117648fb4](https://github.com/BTCDecoded/blvm-consensus/commit/a28117648fb434d88972a3d8ea9bf35d9ca9773b))
- Fix: Correct heredoc structure in release notes generation ([76f1ca799d45](https://github.com/BTCDecoded/blvm-consensus/commit/76f1ca799d45e21969fae6f81b5f313ed9a47639))
- Fix: Move github.repository expression outside heredoc ([77cfcfdb79d2](https://github.com/BTCDecoded/blvm-consensus/commit/77cfcfdb79d2a456326b32de07ef476a2246072d))
- Fix: Remove invalid GITHUB_OUTPUT lines and add version verification ([3ab44316ec4f](https://github.com/BTCDecoded/blvm-consensus/commit/3ab44316ec4fd41cb79d10c5b6eea91100a894b8))
- Fix: Use secrets.CARGO_REGISTRY_TOKEN in if conditions ([692c811657e8](https://github.com/BTCDecoded/blvm-consensus/commit/692c811657e80f11dfb90bb961ecdedb52ececec))
- Fix: Set CARGO_REGISTRY_TOKEN as job-level env var ([fa0f50d4f8a4](https://github.com/BTCDecoded/blvm-consensus/commit/fa0f50d4f8a46c1507f25391beda96ae221ffc1b))
- Fix: Only commit Cargo.toml, not Cargo.lock ([6f2f53a8e6ef](https://github.com/BTCDecoded/blvm-consensus/commit/6f2f53a8e6efa2646398162d99ed50aca001296c))
- Add [skip ci] support to prevent CI on version bump commits ([c3a4d2627902](https://github.com/BTCDecoded/blvm-consensus/commit/c3a4d26279020ae81c3e2eefd36abb6db2e9bcea))
- Fix: Add [skip ci] check to docs job ([bacf023a2e57](https://github.com/BTCDecoded/blvm-consensus/commit/bacf023a2e57b36687a469ddea7e463b517621be))
- Fix: Reorder conditions so skip_tests/skip_verification work correctly ([82de6fc7c5d8](https://github.com/BTCDecoded/blvm-consensus/commit/82de6fc7c5d8e2838a922774085949ab3c38c8db))
- Fix: Remove skip_tests/skip_verification from job conditions ([0d658a620736](https://github.com/BTCDecoded/blvm-consensus/commit/0d658a6207367fd27141de252041650e3087a576))
- Fix: Remove internal skip_check logic, use job-level conditions ([b7d087dc9d21](https://github.com/BTCDecoded/blvm-consensus/commit/b7d087dc9d213f690ed4b8f68d156a0c0dd77f2e))
- Fix: Fix syntax error in verify job Kani proofs step ([fba007f14b36](https://github.com/BTCDecoded/blvm-consensus/commit/fba007f14b361ee54db9ea66f64ec4f84fc54041))
- Fix: Fix broken YAML syntax in test job ([43a21248fb0e](https://github.com/BTCDecoded/blvm-consensus/commit/43a21248fb0e173b21486d2fd1662883efb9895d))
- Fix: Fix all broken YAML syntax from skip_check removal ([be1c65ef5456](https://github.com/BTCDecoded/blvm-consensus/commit/be1c65ef545669ae26078d7506b3ee5c7948f7ee))
- Bump version to 0.1.1 for release [skip ci] ([58d8cde179a7](https://github.com/BTCDecoded/blvm-consensus/commit/58d8cde179a7d2e62449c87053bf6e8dac917eef))
- Fix: Remove unsupported custom predicate from attestation ([4c1e8c70a13c](https://github.com/BTCDecoded/blvm-consensus/commit/4c1e8c70a13c48a8f3f7f2a03c707ee709cb9228))
- Bump version to 0.1.2 for release [skip ci] ([1fc670bca651](https://github.com/BTCDecoded/blvm-consensus/commit/1fc670bca6512b043306956cf2b372836464e48c))

## [v0.1.3] - 2025-11-23

### Reconstructed

- Improve crates.io version checking and release notes generation ([8c991370710d](https://github.com/BTCDecoded/blvm-consensus/commit/8c991370710dfcdc5820e3b1506ef025f3a69688))
- Add timeout handling and better error messages for Kani verification ([94ae823f278d](https://github.com/BTCDecoded/blvm-consensus/commit/94ae823f278d4cbc6efa0405c045dd4f0e31e212))
- Bump version to 0.1.3 for release [skip ci] ([5da4077e9eac](https://github.com/BTCDecoded/blvm-consensus/commit/5da4077e9eac92f3d1f3e8d64ae528b7bfcd9cfb))

## [v0.1.3-unverified] - 2025-11-23

### Reconstructed

- Complete consensus-proof implementation ([460e7d403777](https://github.com/BTCDecoded/blvm-consensus/commit/460e7d403777d1ce2b8684846e15bdf8c9f03e8b))
- feat(verification): Add formal verification to script, SegWit, and Taproot modules ([d7fab79ff490](https://github.com/BTCDecoded/blvm-consensus/commit/d7fab79ff490be13d5b92ac4d58a94de17123496))
- Update consensus validation and build dependencies ([8e584e569691](https://github.com/BTCDecoded/blvm-consensus/commit/8e584e569691d27e7fdb2eca456f608ecfa66188))
- docs: Organize documentation into structured directories ([13ccdee45857](https://github.com/BTCDecoded/blvm-consensus/commit/13ccdee458579ba5c7b273cba1e964b2e4a5d70f))
- fuzz: Complete remaining fuzzing infrastructure tasks ([19cac20a0098](https://github.com/BTCDecoded/blvm-consensus/commit/19cac20a00988669aea877a7554cfb2c794fb815))
- chore: Update codebase with various improvements ([b30eade150c6](https://github.com/BTCDecoded/blvm-consensus/commit/b30eade150c6f2753b6046d44dc044587a617594))
- Fix all compilation errors and test binaries ([25aba6c8fab6](https://github.com/BTCDecoded/blvm-consensus/commit/25aba6c8fab6a16c1a341df73df0346e08a648b9))
- Add benchmark comparison infrastructure and production features benchmarks ([7d072a5a428b](https://github.com/BTCDecoded/blvm-consensus/commit/7d072a5a428b69eca4bbda25282c50c22963fef2))
- Simplify CI to Linux-only self-hosted runners ([a42963e33083](https://github.com/BTCDecoded/blvm-consensus/commit/a42963e33083a3b48e8db009f466ed06b523370e))
- Fix runner label case sensitivity ([90f2b37d52fe](https://github.com/BTCDecoded/blvm-consensus/commit/90f2b37d52fe986f949a486ae692133ed04d025f))
- Update CI workflow to use array format for runner labels ([4a0f19d284ed](https://github.com/BTCDecoded/blvm-consensus/commit/4a0f19d284ed7fbf85fca0d9f0bb3139b16a5875))
- Update Rust toolchain to 1.82.0 and fix clippy errors ([244df9662cf2](https://github.com/BTCDecoded/blvm-consensus/commit/244df9662cf2f8689dbcf3ff418ca5753df7b4d0))
- Fix Rust 1.83 compatibility and clippy errors ([8d5372a5e668](https://github.com/BTCDecoded/blvm-consensus/commit/8d5372a5e668f4bbac6b4284f6be4302ea95608c))
- Fix remaining clippy errors and rustfmt issues ([2cce97304cf5](https://github.com/BTCDecoded/blvm-consensus/commit/2cce97304cf5d5dc2533e07ab9ef449ecd52f2b0))
- Fix test failures: locktime encoding, tx_id calculation, block header validation ([0cd1cb91e0e1](https://github.com/BTCDecoded/blvm-consensus/commit/0cd1cb91e0e135e76d85bc32dbe40f40851863a1))
- Remove accidentally committed test_compress file ([78192c7bd6cd](https://github.com/BTCDecoded/blvm-consensus/commit/78192c7bd6cdc5882c6e4c9cda753ecf9b2d8231))
- Fix compress_target to match Bitcoin Core's GetCompact algorithm ([3e421ff1652d](https://github.com/BTCDecoded/blvm-consensus/commit/3e421ff1652dabf24bf422c93c0f2f16c6d9a916))
- Remove accidentally committed test file ([ab734f6a985d](https://github.com/BTCDecoded/blvm-consensus/commit/ab734f6a985d2a4d7224e0eabfb20ac7159ebfc1))
- Fix round-trip test to allow precision loss in least significant word ([3e8f674c4c5f](https://github.com/BTCDecoded/blvm-consensus/commit/3e8f674c4c5f06349691144a1b88ba99fb0ba041))
- Fix round-trip test: allow precision loss in words 0 and 1 ([1dec23398062](https://github.com/BTCDecoded/blvm-consensus/commit/1dec233980626f1ef36dcb46c704d06b7d2b2d52))
- Skip problematic test case in round-trip test ([bad69c35db44](https://github.com/BTCDecoded/blvm-consensus/commit/bad69c35db443adf6b9d11f57ccb9ae9782aaef2))
- Remove accidentally committed debug file ([1a089d57f644](https://github.com/BTCDecoded/blvm-consensus/commit/1a089d57f64421f9fad776d23e735f1a33ad8511))
- Fix remaining test failures ([5a01e385eead](https://github.com/BTCDecoded/blvm-consensus/commit/5a01e385eead73a3f20c3e184ae1bb1dcf874e0c))
- Fix mining tests: use valid script pattern for transaction verification ([2a5820c079da](https://github.com/BTCDecoded/blvm-consensus/commit/2a5820c079dad64eca3e0cc03311c471cdcbd433))
- Remove accidentally committed test script ([fd29acdf6e92](https://github.com/BTCDecoded/blvm-consensus/commit/fd29acdf6e923a75ddea480130573395a272375c))
- Fix and lock Kani proof for compress_target round-trip ([1175fbc50204](https://github.com/BTCDecoded/blvm-consensus/commit/1175fbc5020414ca08f9bb06729dd8feb0cd2dca))
- chore: trigger CI workflow ([e7bcfa4b7cc2](https://github.com/BTCDecoded/blvm-consensus/commit/e7bcfa4b7cc263d3990e782f33aa31313311f991))
- chore: trigger CI workflow ([32b329c120b5](https://github.com/BTCDecoded/blvm-consensus/commit/32b329c120b571db6b1a90d87098f2451bbf578f))
- ci: upload build artifacts for downstream dependencies ([f4a663c6f48f](https://github.com/BTCDecoded/blvm-consensus/commit/f4a663c6f48f56ec8db12f85e782c60b79563e34))
- Fix clippy errors: unused variable and unnecessary casts ([c0febd7bce51](https://github.com/BTCDecoded/blvm-consensus/commit/c0febd7bce5128f53c7714d501c498f177478343))
- Fix security audit: pin cargo-audit to v0.20.0 (compatible with Rust 1.83.0) ([08f7ad60f911](https://github.com/BTCDecoded/blvm-consensus/commit/08f7ad60f911be0f91523037cf962fdc515b2bcc))
- Fix property tests: correct target bounds and U256 shift operations ([889960255671](https://github.com/BTCDecoded/blvm-consensus/commit/8899602556712a91b0031e4034e4767e082a0610))
- Fix all remaining test failures: overflow protection, property test bounds, and serialization ([4afd0c823c48](https://github.com/BTCDecoded/blvm-consensus/commit/4afd0c823c484887423474c8a8a532413a1d99b0))
- Fix clippy errors and doctest failures ([f1d93266f6c8](https://github.com/BTCDecoded/blvm-consensus/commit/f1d93266f6c8d85d57217250a49e82b28fbaea0d))
- Fix remaining CI failures: test, rustfmt, and make test more lenient ([8649f16b2538](https://github.com/BTCDecoded/blvm-consensus/commit/8649f16b25388ce86b04772995963c69e7cdfc05))
- Fix security audit: use cargo-audit 0.18.0 (compatible with Rust 1.83.0) ([01e04fa75776](https://github.com/BTCDecoded/blvm-consensus/commit/01e04fa757769a318727f1da12286a45d08d0f47))
- Fix security audit: use cargo-audit 0.17.6 (compatible with Rust 1.83.0) ([fac1b2e5eb74](https://github.com/BTCDecoded/blvm-consensus/commit/fac1b2e5eb7425e449b07df781ec0313b7b69a30))
- Fix clippy and rustfmt issues ([f54753114e12](https://github.com/BTCDecoded/blvm-consensus/commit/f54753114e12b857d1ff7046e06c6e44a626535a))
- Fix all test failures and clippy warnings ([3701c2beda59](https://github.com/BTCDecoded/blvm-consensus/commit/3701c2beda59246cc9d024542f7ec29757fb6681))
- Fix integration test: coinbase script_sig length requirement ([ceb8752d2cc2](https://github.com/BTCDecoded/blvm-consensus/commit/ceb8752d2cc207d82825f5d4528dffe7743f8804))
- Fix rustfmt formatting in mining.rs ([90122fdc3b9c](https://github.com/BTCDecoded/blvm-consensus/commit/90122fdc3b9cce7be8f35965e3b6a3d4916702c7))
- Fix BIP9 soft fork activation logic ([d120e3b4251f](https://github.com/BTCDecoded/blvm-consensus/commit/d120e3b4251fb8145355bf0b8ffea66cf85f5d5a))
- Fix BIP9 activation logic: preserve lock-in detection height ([37a06a91abdb](https://github.com/BTCDecoded/blvm-consensus/commit/37a06a91abdbb06f71c0b2287f693e67d41504a0))
- Fix remaining soft_fork_activation test failures ([23e87813db2f](https://github.com/BTCDecoded/blvm-consensus/commit/23e87813db2f1f960675efcb71fea6214339052d))
- Fix rustfmt formatting in soft_fork_activation.rs ([142849ae53dd](https://github.com/BTCDecoded/blvm-consensus/commit/142849ae53dd4ae8c1db1812983b189a800b3607))
- Fix time_based_consensus test: correct minimal encoding assertion ([ac4ff78a28ae](https://github.com/BTCDecoded/blvm-consensus/commit/ac4ff78a28ae683ddf8659c2bdcee1bef1b89933))
- Fix test_bip112_csv_sequence_combinations: correct CSV disabled sequence ([71472ef4f0c3](https://github.com/BTCDecoded/blvm-consensus/commit/71472ef4f0c334f76a36d86cce363e8994295be6))
- Add CI-aware test helpers for performance tests ([f101178fc379](https://github.com/BTCDecoded/blvm-consensus/commit/f101178fc3798997f0fbfb0511f044d4095b1aa4))
- Fix remaining production_integration_tests timeout for CI ([f970c384a07c](https://github.com/BTCDecoded/blvm-consensus/commit/f970c384a07ce91501eefe0f81dee8bd03c80165))
- Fix test coverage step: pin cargo-tarpaulin to compatible version ([b5b193caa33b](https://github.com/BTCDecoded/blvm-consensus/commit/b5b193caa33bd3e792b922cbcc2686fcb24dd88c))
- Fix compilation errors in benchmarks ([7f7e17969d82](https://github.com/BTCDecoded/blvm-consensus/commit/7f7e17969d8223b775c7a5b37ab8034366180296))
- Fix test coverage step: use lowercase 'xml' format ([236707aa8a9a](https://github.com/BTCDecoded/blvm-consensus/commit/236707aa8a9a3dc66ba1850bd96c66eeed6236d2))
- Try cargo-audit 0.16.0 for Rust 1.83.0 compatibility ([f339f1bf5913](https://github.com/BTCDecoded/blvm-consensus/commit/f339f1bf5913aca4a3f91e6a94df8fb47abfb797))
- feat: Implement BLLVM optimizations (Phase 1 & 2) with comprehensive testing ([f26e42f09168](https://github.com/BTCDecoded/blvm-consensus/commit/f26e42f0916829e1a0d8ae63e59cfdff9e3a2d50))
- refactor: Improve BLLVM organization and documentation ([808de654a59b](https://github.com/BTCDecoded/blvm-consensus/commit/808de654a59ba84d7d56cdc497f7c07ccb198b1a))
- Make security audit and coverage non-blocking ([4923e2a07457](https://github.com/BTCDecoded/blvm-consensus/commit/4923e2a07457c3c35e18524fa44507b046509df1))
- Fix security audit and coverage: update Rust toolchain to 1.88.0 ([713761f9f476](https://github.com/BTCDecoded/blvm-consensus/commit/713761f9f47660f2b58a41ed84f0995db6dbe357))
- Update all Rust toolchain versions to 1.88.0 in workflow ([24cb1bf48a15](https://github.com/BTCDecoded/blvm-consensus/commit/24cb1bf48a155b6258d4e09b982f4627b0560380))
- Fix: Update rust-toolchain.toml to 1.88.0 ([0d68d8233284](https://github.com/BTCDecoded/blvm-consensus/commit/0d68d823328423d1232cbb1aac17947e656e1c45))
- Fix clippy errors: deprecated functions, unused imports, useless comparisons ([6ed26551cf8d](https://github.com/BTCDecoded/blvm-consensus/commit/6ed26551cf8d390bb096431cca67bf26f945bae3))
- Fix clippy errors: format! strings and unused imports ([ba97b91fe3d2](https://github.com/BTCDecoded/blvm-consensus/commit/ba97b91fe3d29df6ed30a7b9475cb574c201c9f0))
- Fix remaining format! string errors in block.rs ([9820cfb623f5](https://github.com/BTCDecoded/blvm-consensus/commit/9820cfb623f5664d08df21da717fa316bb9fdbd9))
- Fix: Update cargo-audit to 0.21.0 to support Cargo.lock format version 4 ([2ccc61a1b888](https://github.com/BTCDecoded/blvm-consensus/commit/2ccc61a1b8889bc6564173a4b8725137bcd091fa))
- Add benchmarking utilities for reproducible benchmarks ([3fb55009d982](https://github.com/BTCDecoded/blvm-consensus/commit/3fb55009d982b028754aad0c90d7277afdda8ee6))
- Fix: Use cargo-audit 0.20.0 instead of 0.21.0 (0.21.0 requires Rust 1.89) ([478cf3ca4b84](https://github.com/BTCDecoded/blvm-consensus/commit/478cf3ca4b84545c32dd086d708643824a66031d))
- Update repository references to new names (bllvm-*) ([a5076f0f635b](https://github.com/BTCDecoded/blvm-consensus/commit/a5076f0f635b7c2a8eaf922ee220504953b3c85f))
- docs: Add reference to master status document ([1227fec696dd](https://github.com/BTCDecoded/blvm-consensus/commit/1227fec696ddd468cd56780cc2d2ad03728dc588))
- docs: Update bllvm-sdk description to 'developer toolkit' ([6a8b62c9a5e5](https://github.com/BTCDecoded/blvm-consensus/commit/6a8b62c9a5e5ab2a17b8c90eb13c24a822e8b2f8))
- Add realistic block validation benchmark for fair comparison with Bitcoin Core ([7b5dfdad4bad](https://github.com/BTCDecoded/blvm-consensus/commit/7b5dfdad4bad2641fa8989a2e9ee0952af88d266))
- feat: Add Intel SHA-NI single-hash optimization + integrate with block validation ([29e3d71eeeca](https://github.com/BTCDecoded/blvm-consensus/commit/29e3d71eeeca52613e3147cda617ee7d67cfc12c))
- feat: Add focused performance benchmarks ([2f6195a9a082](https://github.com/BTCDecoded/blvm-consensus/commit/2f6195a9a082e87b464a1f011c55b97a67ac12dc))
- docs: Add performance summary with CPU feature verification ([4a723a9390a5](https://github.com/BTCDecoded/blvm-consensus/commit/4a723a9390a5a81e19ce4df66429ce5d7f391cd7))
- feat: Add low-hanging fruit optimizations ([197dced38aba](https://github.com/BTCDecoded/blvm-consensus/commit/197dced38aba3afc521e6f973561baa6e0012e48))
- fix: Resolve all compiler warnings ([c28a36e7b60b](https://github.com/BTCDecoded/blvm-consensus/commit/c28a36e7b60be4e32a38f72b272322cd66a3f71d))
- fix: Add missing crypto module declaration in lib.rs ([ad634294ea6b](https://github.com/BTCDecoded/blvm-consensus/commit/ad634294ea6b2675c39337ed5ca3858e564b2e37))
- fix: Update test imports from consensus_proof to bllvm_consensus ([f1ff38664dd5](https://github.com/BTCDecoded/blvm-consensus/commit/f1ff38664dd5deaaa46fc9d342df1d4aa6559aca))
- fix: Resolve Clippy and Rustfmt errors ([8117c9d24fda](https://github.com/BTCDecoded/blvm-consensus/commit/8117c9d24fda06c4c3e65467c5c4ca10025375da))
- fix: Resolve remaining Clippy boolean expression errors ([3b9eedb70851](https://github.com/BTCDecoded/blvm-consensus/commit/3b9eedb7085173bd1c9d02b5a92ea367475d2bf7))
- fix: Remove remaining boolean expression logic bug ([11bcc446bdcd](https://github.com/BTCDecoded/blvm-consensus/commit/11bcc446bdcd6864bebfceceb25af626d202db0f))
- fix: Resolve all remaining Clippy boolean expression errors ([9a8899900f72](https://github.com/BTCDecoded/blvm-consensus/commit/9a8899900f72fd7976114ce87249568b305f8c64))
- fix: Resolve final Clippy error (absurd extreme comparison) ([7295e57f173e](https://github.com/BTCDecoded/blvm-consensus/commit/7295e57f173e3f177ca85e5d24dea217299f09a1))
- fix: Correct SHA-NI final hash extraction ([f07d5647303c](https://github.com/BTCDecoded/blvm-consensus/commit/f07d5647303ccb8804a28220556b84bb8a11ae7b))
- fix: Correct SHA-NI hash extraction with proper reordering ([7f4b328582d8](https://github.com/BTCDecoded/blvm-consensus/commit/7f4b328582d833617fdebd03430c67c4e75cf799))
- fix(pow): make expand_target public for protocol layer access ([e022725fb893](https://github.com/BTCDecoded/blvm-consensus/commit/e022725fb893c4603a99e14f34d9816d1bc4d0f0))
- Fix kani conditional compilation: use #[cfg(kani)] instead of #[cfg(feature = "verify")] ([a98e55fe945a](https://github.com/BTCDecoded/blvm-consensus/commit/a98e55fe945a811fb155acd5ecf9d810e95df87b))
- Fix compilation errors with --all-features ([94657c72c08b](https://github.com/BTCDecoded/blvm-consensus/commit/94657c72c08bf7372b12ae5a85e32c07aa0819c4))
- Fix GenericArray type annotation for k256 verify ([38349c8badbb](https://github.com/BTCDecoded/blvm-consensus/commit/38349c8badbb41e5ed96a65036fcdbe9d0a8d476))
- Fix k256 verify: use Sha256::digest for message hash ([262915723855](https://github.com/BTCDecoded/blvm-consensus/commit/262915723855fc3340f0465ca923de7e499889e7))
- Fix clippy and rustfmt errors ([3e2760404f3d](https://github.com/BTCDecoded/blvm-consensus/commit/3e2760404f3d4e789f9439c71ae3f139e9ed87c0))
- Skip sha_ni tests when SHA-NI is not available ([40cf1287fb58](https://github.com/BTCDecoded/blvm-consensus/commit/40cf1287fb58d9b3b225340348224c324cabe3ac))
- Ignore sha_ni tests in CI - implementation has bugs ([cac70f7c3473](https://github.com/BTCDecoded/blvm-consensus/commit/cac70f7c347301bdb8f0bc54d309e7bde1a95296))
- Fix doctest imports - use correct crate name bllvm_consensus ([6db58df82d57](https://github.com/BTCDecoded/blvm-consensus/commit/6db58df82d57d6a96218ff306dc174927cd938af))
- Fix all doctest imports - replace consensus_proof with bllvm_consensus ([f7254a395b71](https://github.com/BTCDecoded/blvm-consensus/commit/f7254a395b7197c07b6d13f0dd94c0f5a7117dd8))
- Fix remaining consensus_proof references in doctest code bodies ([541af6ddd3e0](https://github.com/BTCDecoded/blvm-consensus/commit/541af6ddd3e0c2000271619c4c292ba3fa6e377f))
- Fix rsync cache: ensure target cache directory exists before syncing ([5d785947f3d8](https://github.com/BTCDecoded/blvm-consensus/commit/5d785947f3d868e850c41cf5fd34022168a75e0e))
- Make repository-dispatch non-blocking to prevent build job failure ([58ef2a76ba0a](https://github.com/BTCDecoded/blvm-consensus/commit/58ef2a76ba0aca06ca6643467ca004b38d119ec2))
- Use REPO_ACCESS_TOKEN for repository-dispatch (org-level secret) ([dbe6396e0dc4](https://github.com/BTCDecoded/blvm-consensus/commit/dbe6396e0dc4cb661e6f789ec1ee2daf25aec796))
- Upgrade cargo-audit to 0.22.0 for Cargo.lock format version 4 support ([660861588448](https://github.com/BTCDecoded/blvm-consensus/commit/660861588448af529fa89f60ec23f78d4290bed9))
- Add --locked flag to cargo-audit installation to use exact dependency versions ([1c237dc68493](https://github.com/BTCDecoded/blvm-consensus/commit/1c237dc684933bf26e09396262f7d7b61df85efc))
- Upgrade Rust to 1.89.0 for Security Audit job (required by cargo-audit 0.22.0) ([72db1e3a13fc](https://github.com/BTCDecoded/blvm-consensus/commit/72db1e3a13fc30e07995fbfc3d022c79d2262415))
- Update serde to 1.0.228 for iroh 0.95 compatibility ([1396e051fd74](https://github.com/BTCDecoded/blvm-consensus/commit/1396e051fd748a6f6ea9107dcd70323edb05fb84))
- Fix Bitcoin difficulty adjustment off-by-one error (with compatibility option) ([0867065d10ac](https://github.com/BTCDecoded/blvm-consensus/commit/0867065d10ac4c4bc08208041c699683c9d60a20))
- Add comprehensive mathematical protections across consensus-critical modules ([9f5e0465d19b](https://github.com/BTCDecoded/blvm-consensus/commit/9f5e0465d19beeff651b0e141a546b95c704a64d))
- feat: Senior Rust engineer improvements - Phase 1-3 ([2989d5fda689](https://github.com/BTCDecoded/blvm-consensus/commit/2989d5fda6897068fb26c11e13b3b4ef06d134fa))
- refactor: Remove bench definitions - moved to bllvm-bench ([361a8cba1dd7](https://github.com/BTCDecoded/blvm-consensus/commit/361a8cba1dd778f4ca3e4ba84e871ecfe5845a0e))
- Fix compilation errors: Convert Vec to SmallVec/Box for production feature ([ef9d71a06773](https://github.com/BTCDecoded/blvm-consensus/commit/ef9d71a06773d6c3b9ca0884e3ae3326761b534e))
- fix: add ctv feature ([a87322012b91](https://github.com/BTCDecoded/blvm-consensus/commit/a87322012b9171287f20689e36a79a97ac25744c))
- Complete edge case coverage: Add CVE-2012-2459 and CVE-2018-17144 tests ([c9bc3285b54a](https://github.com/BTCDecoded/blvm-consensus/commit/c9bc3285b54a4d13df556b7078d260f2a14842f7))
- Fix all compile-time warnings ([bd93dbb34a29](https://github.com/BTCDecoded/blvm-consensus/commit/bd93dbb34a29f66180b5b6d27d9f16c703dc89a1))
- Fix all compilation warnings and complete TODOs ([0a5aacd08e19](https://github.com/BTCDecoded/blvm-consensus/commit/0a5aacd08e1907c3d436921ae243338b160e6410))
- fix: disable sha2-asm for Windows targets ([4694ce838fbf](https://github.com/BTCDecoded/blvm-consensus/commit/4694ce838fbf59c70077d012c234f8eae6d36ae0))
- fix: add explicit x86_64-pc-windows-gnu target config for sha2 ([f53771ac5bf5](https://github.com/BTCDecoded/blvm-consensus/commit/f53771ac5bf536e11c5cdccd0ec56e41915d830a))
- fix: restore sha2 in main dependencies to fix Linux builds ([fbfe921cc10a](https://github.com/BTCDecoded/blvm-consensus/commit/fbfe921cc10aa8e1cd5763257ffbb422c20bfeb9))
- fix: remove duplicate Windows target dependency config ([0982c6c82f64](https://github.com/BTCDecoded/blvm-consensus/commit/0982c6c82f64ff75885b4b246e21bb4ad07c7a33))
- fix: properly disable sha2-asm for Windows using target-specific deps ([fdf4cef339df](https://github.com/BTCDecoded/blvm-consensus/commit/fdf4cef339dfcb4c0883e65963aee952f8fe8256))
- Organize documentation: archive historical/status docs, create README structure ([19bbbb5d51d1](https://github.com/BTCDecoded/blvm-consensus/commit/19bbbb5d51d1de57d30161179017ea18be9b67ee))
- Update .gitignore: remove target/, fuzz/target/, and Cargo.lock from tracking ([f30a3c1aac95](https://github.com/BTCDecoded/blvm-consensus/commit/f30a3c1aac95340191fea20779c6398c7ae204d0))
- Add benchmark_results.txt to .gitignore and remove from tracking ([26d2c5774198](https://github.com/BTCDecoded/blvm-consensus/commit/26d2c5774198b7df9f60403492b0eb4b85ac4c0b))
- Archive historical documentation to bllvm-docs ([ee2d57ac7242](https://github.com/BTCDecoded/blvm-consensus/commit/ee2d57ac7242b43e5dca4d0095a8a47c032116d0))
- fix: pin k256 to exact version ([75601a64bd6a](https://github.com/BTCDecoded/blvm-consensus/commit/75601a64bd6a11e90ddd42890242bedbf79030b9))
- Archive outdated documentation ([8a3f100d6cc7](https://github.com/BTCDecoded/blvm-consensus/commit/8a3f100d6cc7231059bd52f1bb131193118fd6a6))
- feat: add BIP119 CTV validation and integration tests ([4db995e55b9c](https://github.com/BTCDecoded/blvm-consensus/commit/4db995e55b9c10fd151af2ad9fde12a68b3a724f))
- refactor(tests): remove redundant tests and consolidate helpers ([efae1781b438](https://github.com/BTCDecoded/blvm-consensus/commit/efae1781b4380b14c9431f46f379ab1031f6acca))
- refactor(tests): consolidate more duplicate test helpers ([81f1b36a6237](https://github.com/BTCDecoded/blvm-consensus/commit/81f1b36a62372b362790cceff28b60a2bec5d877))
- chore(tests): remove trailing empty lines from mempool_rbf_tests.rs ([81f2a56d7682](https://github.com/BTCDecoded/blvm-consensus/commit/81f2a56d76825d49fe8e08586ca8dd0cef0d96ae))
- feat: Add inline hints to hot functions for LLVM optimization ([62bb71a6d99a](https://github.com/BTCDecoded/blvm-consensus/commit/62bb71a6d99ae9d4ad9d44cd1a36c3dd10977d80))
- feat: Integrate cache-aligned structures and Kani-proven bounds ([f980bda8481c](https://github.com/BTCDecoded/blvm-consensus/commit/f980bda8481c6b7bf76cf261aff1cc61a872126d))
- feat: Expand Kani-proven bounds and consolidate function implementations ([708bd81c5408](https://github.com/BTCDecoded/blvm-consensus/commit/708bd81c5408046a9e1b496820d417826394744e))
- Fix SHA-NI implementation using Bitcoin Core's Shuffle/Unshuffle pattern ([03a29d861d8b](https://github.com/BTCDecoded/blvm-consensus/commit/03a29d861d8b5e7bd8dd85b3c465a97b3545f3c2))
- Fix coverage timeout: add tarpaulin timeout and reduce slow test ranges ([457fb69703ec](https://github.com/BTCDecoded/blvm-consensus/commit/457fb69703ecb51291f8c42e33fde6b3e1c42f85))
- Fix prop_block_subsidy_constant_time: make timeout lenient under coverage ([b3008c5a2d67](https://github.com/BTCDecoded/blvm-consensus/commit/b3008c5a2d67a7b517f715a4dba4281b1638d7a5))
- Check for CARGO_TARPAULIN env var in addition to TARPAULIN ([cedcd1c80a6c](https://github.com/BTCDecoded/blvm-consensus/commit/cedcd1c80a6c9e8078d8fd3b15e9f11a481a600f))
- Fix tarpaulin flag: use --timeout instead of --test-timeout ([bac8cff06745](https://github.com/BTCDecoded/blvm-consensus/commit/bac8cff067454f3201f50d568ad73d8139631dd2))
- Make performance tests more lenient to handle system load variations ([084e7aba1e54](https://github.com/BTCDecoded/blvm-consensus/commit/084e7aba1e54f83047be5d0716be774f2392329c))
- Add orchestrator trigger: trigger release orchestrator on push to main ([6ea329ac1baa](https://github.com/BTCDecoded/blvm-consensus/commit/6ea329ac1baa846fe8ad607666d5cbf48723355a))
- Standardize CI workflow: security depends on setup, build depends on all checks ([9271377212ab](https://github.com/BTCDecoded/blvm-consensus/commit/9271377212abf650c4b4155ea08e3f84ac240981))
- Fix CI: performance test boundary and tarpaulin timeouts ([1ee22cba19b1](https://github.com/BTCDecoded/blvm-consensus/commit/1ee22cba19b127867a43cb4f590e9fc451aa82ed))
- Fix property test ranges: use helper functions for conditional ranges ([41f52d06f851](https://github.com/BTCDecoded/blvm-consensus/commit/41f52d06f851162645f1442453c0930905c15574))
- Add independent release workflow for bllvm-consensus ([586d30a62695](https://github.com/BTCDecoded/blvm-consensus/commit/586d30a62695b2682e5b5b06a7cb00f590bb1f74))
- Increase block subsidy performance test timeout to 10ms ([82eacdcb97e9](https://github.com/BTCDecoded/blvm-consensus/commit/82eacdcb97e94aca1635a7aa845b5eec183e7f94))
- Add release job to CI workflow ([1cfbaf32910c](https://github.com/BTCDecoded/blvm-consensus/commit/1cfbaf32910c64a89b78e7f3432c9f8f32492b64))
- Fix version determination to only match package version ([e9b28a42259b](https://github.com/BTCDecoded/blvm-consensus/commit/e9b28a42259bed024284c9a780b715d732db1f46))
- Fix version extraction: use grep instead of awk ([69e8b419c7c1](https://github.com/BTCDecoded/blvm-consensus/commit/69e8b419c7c14787a21e50c6656545225eb7517a))
- Commit Cargo.toml changes before publish ([d00563ba4c43](https://github.com/BTCDecoded/blvm-consensus/commit/d00563ba4c4373a249d24e5f82ef90c6ddec3606))
- Update kani-verifier version to 0.66 for crates.io compatibility ([796962e982e7](https://github.com/BTCDecoded/blvm-consensus/commit/796962e982e7c5be859beb337200d8efe34fb6ad))
- Regenerate Cargo.lock before publish to fix kani-verifier version ([6337264bddf5](https://github.com/BTCDecoded/blvm-consensus/commit/6337264bddf50360586ea5b43deb465cef33b9a0))
- Fix version update and Cargo.lock regeneration order ([b8c8d6f37751](https://github.com/BTCDecoded/blvm-consensus/commit/b8c8d6f37751febb0fee3c80d6ecf91642a9729e))
- Fix Cargo.lock regeneration order and version update ([981838b08ce0](https://github.com/BTCDecoded/blvm-consensus/commit/981838b08ce0bca5a820b58252d80c14f9990394))
- Improve version update and add verification ([14495de080fa](https://github.com/BTCDecoded/blvm-consensus/commit/14495de080fa1a75465e593e138898152dd85520))
- Enhance release pipeline with mathematical verification and pre-release checks ([fd577ccda104](https://github.com/BTCDecoded/blvm-consensus/commit/fd577ccda1046e3ca21d5e0faa1e0f1db80517b6))
- Fix Kani installation and PATH handling in verify job ([16c4ce25875d](https://github.com/BTCDecoded/blvm-consensus/commit/16c4ce25875d00f757871d9cbce2b722fdbd094a))
- Remove Kani installation step - use pre-installed Kani on runner ([a9ec9bae6639](https://github.com/BTCDecoded/blvm-consensus/commit/a9ec9bae663955001e64fff4b0023947e63d16fa))
- Fix Kani command - use 'cargo kani' instead of 'kani' ([f620485a416d](https://github.com/BTCDecoded/blvm-consensus/commit/f620485a416d74c3d1712cf28b8af87e13a2e04b))
- Simplify Kani verification step name to 'Verify' ([8bfa4d5f8f71](https://github.com/BTCDecoded/blvm-consensus/commit/8bfa4d5f8f71c33959b52608757c0b92cbd3a6e1))
- Revert step name to 'Run Kani proofs' ([ef4ab201a4c6](https://github.com/BTCDecoded/blvm-consensus/commit/ef4ab201a4c6af7bfa955590e8d107c78a4662c6))
- Change job name from 'Mathematical Verification' to 'Verify' ([b397939472b1](https://github.com/BTCDecoded/blvm-consensus/commit/b397939472b1ece7d0a2f90e9642c4550fcfe009))
- Fix Kani proof compilation errors in taproot.rs ([6d4f52cf76a1](https://github.com/BTCDecoded/blvm-consensus/commit/6d4f52cf76a187de2d62c542c185990f1f9d64d4))
- Fix unused variable warnings in Kani proofs ([fe438d716a25](https://github.com/BTCDecoded/blvm-consensus/commit/fe438d716a25c7255d7a0e9db392093c548ee805))
- Fix duplicate kani_proofs modules and syntax error ([9b09f2cf8236](https://github.com/BTCDecoded/blvm-consensus/commit/9b09f2cf823670e0fd9935902c11410254e831fe))
- Fix Kani proof compilation: replace kani::any() with helper functions ([a41daf399af4](https://github.com/BTCDecoded/blvm-consensus/commit/a41daf399af46184c5d517e46e8c73eca1529e0f))
- Fix rustfmt formatting in segwit.rs ([fa90fb9a36ff](https://github.com/BTCDecoded/blvm-consensus/commit/fa90fb9a36ff38029e930263b423ee773286a7a0))
- Fix Kani compilation: replace kani::any() with helper functions ([eb354dd5dc31](https://github.com/BTCDecoded/blvm-consensus/commit/eb354dd5dc31fe0f1bdbdd683e90c406a65fa9eb))
- Fix remaining Kani compilation errors ([b1f195db321b](https://github.com/BTCDecoded/blvm-consensus/commit/b1f195db321be1c395ac5813f58fde7a40bef1cd))
- Fix remaining Kani compilation errors ([9d58d24a4ad1](https://github.com/BTCDecoded/blvm-consensus/commit/9d58d24a4ad1c90ad1d53564e2e609875ab3a428))
- Fix final Kani compilation errors ([b9dda28eeab5](https://github.com/BTCDecoded/blvm-consensus/commit/b9dda28eeab56813b5e5439c1be0b03aaa84aa04))
- Fix rustfmt formatting issues ([09cd971c4149](https://github.com/BTCDecoded/blvm-consensus/commit/09cd971c4149147e3c4c2d6a8c3e85f28512f21c))
- Fix mutable tx in economic.rs Kani proof ([ede7a396f72e](https://github.com/BTCDecoded/blvm-consensus/commit/ede7a396f72ef31873d1845b57ab24099da05a20))
- Fix unwind attributes: use integer literals with source constant comments ([37bf2b83220b](https://github.com/BTCDecoded/blvm-consensus/commit/37bf2b83220ba2f4321c70bdf5765038d8f8bc38))
- Optimize BIP113 Kani proofs: add unwind attributes and reduce bounds for tractability ([22fbdf34714e](https://github.com/BTCDecoded/blvm-consensus/commit/22fbdf34714e076aff52b8524c8e0c7f0f22c667))
- Further reduce BIP113 proof bounds to avoid sort_unstable unwinding issues ([86c73cbe7e13](https://github.com/BTCDecoded/blvm-consensus/commit/86c73cbe7e13b6bc5479d2f5d3ebecdddebe7b0b))
- Add explicit header_count > 0 assumption to help Kani prune paths early ([e25bfddf3fdd](https://github.com/BTCDecoded/blvm-consensus/commit/e25bfddf3fdd9b59dd17feb836dd94e7d0709765))
- Disable kani_bip113_median_time_ge_minimum due to sort_unstable unwinding issues ([1f7b4fc572ef](https://github.com/BTCDecoded/blvm-consensus/commit/1f7b4fc572ef8fa4798de3718fb215a4703087b4))
- Optimize BIP113 proof: use u8 for header_count to help Kani prune paths early ([38e28ee5f4db](https://github.com/BTCDecoded/blvm-consensus/commit/38e28ee5f4dbc99cc60380eb2adab7fbecf4e898))
- Fix cargo-audit version compatibility with Rust 1.88.0 ([394bd5c0906e](https://github.com/BTCDecoded/blvm-consensus/commit/394bd5c0906e537be33b6d0c641902ea7d4f8263))
- Improve Kani verification step with timeout and output filtering ([91991306b186](https://github.com/BTCDecoded/blvm-consensus/commit/91991306b186174b2a2e56d1d0aa78cb7a678098))
- Optimize Kani verification and test execution ([807c472fd3be](https://github.com/BTCDecoded/blvm-consensus/commit/807c472fd3be3800bd5278e104c669690e2301e0))
- Remove all timeouts and maximize Kani proof parallelization ([84b1cfbdbe16](https://github.com/BTCDecoded/blvm-consensus/commit/84b1cfbdbe16114888ad2b2c3cddb182e2980bd1))
- Fix Kani proof: constrain coinbase value to not exceed MAX_MONEY ([3989b56460aa](https://github.com/BTCDecoded/blvm-consensus/commit/3989b56460aa4bb47245d2c4b656087f562d4943))
- Set maximum timeout for Kani verification job ([5c2a30c5c896](https://github.com/BTCDecoded/blvm-consensus/commit/5c2a30c5c896fbd4f49ae71d3b1a40a7e08897ec))
- Fix Kani proof failure and improve error handling ([1f40889910cb](https://github.com/BTCDecoded/blvm-consensus/commit/1f40889910cb9e78c83d60a2caebd7d45243cb5c))
- Split Kani proofs into Fast/Medium and Slow steps ([2318e1944cf3](https://github.com/BTCDecoded/blvm-consensus/commit/2318e1944cf3d202d0756f1bc8a22d5cc2906a3d))
- Reduce Kani parallelism to prevent OOM and add perf tag to verify step ([87c12dc5f7cb](https://github.com/BTCDecoded/blvm-consensus/commit/87c12dc5f7cbdb0d9f3942d67add88fafd281d57))
- Implement tiered Kani proof execution based on event type ([eba2a7130fa7](https://github.com/BTCDecoded/blvm-consensus/commit/eba2a7130fa7a8a544a301881b8a9e0e2403bb2c))
- Add Kani optimization guide and enable faster solver ([6b1764635a9a](https://github.com/BTCDecoded/blvm-consensus/commit/6b1764635a9a2aa0aedb78fad1395b4ce14f6098))
- Optimize Kani proofs while maintaining mathematical validity ([fe341dfda1ec](https://github.com/BTCDecoded/blvm-consensus/commit/fe341dfda1ecb1e12528e3c64eb048ec010cec06))
- Fix Kani jobs flag and formatting ([7a3ebfe83edb](https://github.com/BTCDecoded/blvm-consensus/commit/7a3ebfe83edbae24a6b799548ac1768f4e167d44))
- Change non-verification jobs to use 'builds' runners ([fa8f6e5f0da2](https://github.com/BTCDecoded/blvm-consensus/commit/fa8f6e5f0da264d455f330587a67999fce8334ee))
- Add GitHub attestations for releases ([7b9c569c0cd2](https://github.com/BTCDecoded/blvm-consensus/commit/7b9c569c0cd260c33eac9b67f56ce0216e709354))
- Optimize Kani unwind bounds: remove low-value proofs and reduce bounds ([7c05c6b7eda9](https://github.com/BTCDecoded/blvm-consensus/commit/7c05c6b7eda9108954d4deee14394a2566840612))
- Add skip_verification workflow input ([06cc6213e2fe](https://github.com/BTCDecoded/blvm-consensus/commit/06cc6213e2feaadeba23c00b55f425134e8b2c11))
- Add skip condition to Collect build metadata step ([80f56cca6144](https://github.com/BTCDecoded/blvm-consensus/commit/80f56cca6144792823220685e3e6503fd5f9f8e7))
- Fix: Add workflow_dispatch to build and release job conditions ([483a090c752b](https://github.com/BTCDecoded/blvm-consensus/commit/483a090c752b1b012319ae18006dcfd9206e77cc))
- Fix: Handle 'crate already exists' error gracefully ([ab147a0a2ea5](https://github.com/BTCDecoded/blvm-consensus/commit/ab147a0a2ea547d2497cf375b73a91470fcca62d))
- Fix: Add enhanced debugging for publish step ([3d1329c86e4b](https://github.com/BTCDecoded/blvm-consensus/commit/3d1329c86e4b3395fd1e9485795a66f90496b808))
- Fix: Update release notes to handle missing crates.io versions ([b7b6e85c5306](https://github.com/BTCDecoded/blvm-consensus/commit/b7b6e85c530670f75f064bebf813ed64736038fd))
- Fix: Correct release notes syntax for conditional links ([63979da2d4ad](https://github.com/BTCDecoded/blvm-consensus/commit/63979da2d4ade108240ca219dc6879e206785ff8))
- Add skip_tests workflow input option ([6280b3b9c21b](https://github.com/BTCDecoded/blvm-consensus/commit/6280b3b9c21b4d8173c7b86fdcd81c44cc6acfcd))
- Simplify version tag: untested counts as unverified ([59c537966fa0](https://github.com/BTCDecoded/blvm-consensus/commit/59c537966fa0fa44dafc40899f2b1146802b86a4))
- Fix: Restructure conditional expressions to avoid shell syntax errors ([b109e040cec6](https://github.com/BTCDecoded/blvm-consensus/commit/b109e040cec6187e1d9c4e616c7a4ead1b1c0655))
- Make verify job conditional when skip_verification is true ([daaa633d22fb](https://github.com/BTCDecoded/blvm-consensus/commit/daaa633d22fb7af3a01b2aa95fa9dabf70b21619))
- Fix: Update release job condition to handle skipped verify ([40442c49399a](https://github.com/BTCDecoded/blvm-consensus/commit/40442c49399a6d7d2a0f672abcf704d183e7e5f9))
- Fix: Correct conditional logic for verify dependency ([de4d1082d307](https://github.com/BTCDecoded/blvm-consensus/commit/de4d1082d307061aa87af722ba9c86fc5062ff0a))
- Make test job conditional when skip_tests is true ([37cf610a0f74](https://github.com/BTCDecoded/blvm-consensus/commit/37cf610a0f7463ade66edbabd26a005eb033d31d))
- Fix: Update release job condition to handle skipped tests ([cb732cbddd3a](https://github.com/BTCDecoded/blvm-consensus/commit/cb732cbddd3a71f2b0ad068566757c9f88bc9a01))
- Fix: Avoid shell syntax errors in version determination ([2fd0d2afaf36](https://github.com/BTCDecoded/blvm-consensus/commit/2fd0d2afaf366e51c79ad523ad5371982ddc16ee))
- Fix: Correct heredoc structure in release notes generation ([dd8705e513a6](https://github.com/BTCDecoded/blvm-consensus/commit/dd8705e513a6bbbd98823de6685a53b43ca064bb))
- Fix: Move github.repository expression outside heredoc ([01f580c81663](https://github.com/BTCDecoded/blvm-consensus/commit/01f580c816638445b206672b7369b768240f6193))
- Fix: Remove invalid GITHUB_OUTPUT lines and add version verification ([a58857d9a82b](https://github.com/BTCDecoded/blvm-consensus/commit/a58857d9a82b74dff57fa1799281411038057ab4))
- Fix: Use secrets.CARGO_REGISTRY_TOKEN in if conditions ([b76af4356f1c](https://github.com/BTCDecoded/blvm-consensus/commit/b76af4356f1ceb4011f5c92380f9bc53f660507b))
- Fix: Set CARGO_REGISTRY_TOKEN as job-level env var ([c83c2368f16a](https://github.com/BTCDecoded/blvm-consensus/commit/c83c2368f16a4c7b5804f5041945ee7bf3c61355))
- Fix: Only commit Cargo.toml, not Cargo.lock ([0a24e583b9ce](https://github.com/BTCDecoded/blvm-consensus/commit/0a24e583b9ce067e69b9a3f291ea05f217ef1cb5))
- Add [skip ci] support to prevent CI on version bump commits ([3d470774aaf9](https://github.com/BTCDecoded/blvm-consensus/commit/3d470774aaf91f2c52b8ec67cdbccbda9088f915))
- Fix: Add [skip ci] check to docs job ([805a4b6be6ac](https://github.com/BTCDecoded/blvm-consensus/commit/805a4b6be6ac90e84095410b244d545065a5d036))
- Fix: Reorder conditions so skip_tests/skip_verification work correctly ([fafd17a0a662](https://github.com/BTCDecoded/blvm-consensus/commit/fafd17a0a662fd310833fbcb7c8858b6cee170d2))
- Fix: Remove skip_tests/skip_verification from job conditions ([b93a3459fbe9](https://github.com/BTCDecoded/blvm-consensus/commit/b93a3459fbe90b9fe7ada007f610a37b387085c2))
- Fix: Remove internal skip_check logic, use job-level conditions ([6898dedafdf2](https://github.com/BTCDecoded/blvm-consensus/commit/6898dedafdf26ed67f0fed69599527310cc0a439))
- Fix: Fix syntax error in verify job Kani proofs step ([db1d8a4d2ed3](https://github.com/BTCDecoded/blvm-consensus/commit/db1d8a4d2ed3bd596a5bf9b8b732435cf992c350))
- Fix: Fix broken YAML syntax in test job ([c8dd15ed6b10](https://github.com/BTCDecoded/blvm-consensus/commit/c8dd15ed6b10265a26adc61f08f23d1f18d7af70))
- Fix: Fix all broken YAML syntax from skip_check removal ([c7771cd0259e](https://github.com/BTCDecoded/blvm-consensus/commit/c7771cd0259e7835fcf130b28b1bf755a42d8318))
- Bump version to 0.1.1 for release [skip ci] ([caed267b9e35](https://github.com/BTCDecoded/blvm-consensus/commit/caed267b9e35c2d231d7446fcb1662603a7aa4fa))
- Fix: Remove unsupported custom predicate from attestation ([38459d7b6e23](https://github.com/BTCDecoded/blvm-consensus/commit/38459d7b6e2324f4e99cd6433121443cd57e254b))
- Bump version to 0.1.2 for release [skip ci] ([8f39c4095d6c](https://github.com/BTCDecoded/blvm-consensus/commit/8f39c4095d6c2479cbce70ef2a2aed716208b4f9))
- Improve crates.io version checking and release notes generation ([b5ee38ff1fa6](https://github.com/BTCDecoded/blvm-consensus/commit/b5ee38ff1fa636f4068aa5f47bfb66d9c22427bd))
- Add timeout handling and better error messages for Kani verification ([8607ae1907de](https://github.com/BTCDecoded/blvm-consensus/commit/8607ae1907de713bd1dfa3ca7b101b554443f5ca))
- Bump version to 0.1.3 for release [skip ci] ([8c5d3ecb018d](https://github.com/BTCDecoded/blvm-consensus/commit/8c5d3ecb018da79fc230c10c554f9944c5c1cce5))

## [v0.1.4] - 2025-11-23

### Reconstructed

- Bump version to 0.1.3 for release [skip ci] ([6c1587ae229e](https://github.com/BTCDecoded/blvm-consensus/commit/6c1587ae229e1e6c93bd3184b7a09698e9cec3e0))
- Integrate BIP30, BIP34, BIP90 into connect_block and add comprehensive verification ([8e59123f2528](https://github.com/BTCDecoded/blvm-consensus/commit/8e59123f25289098dc8c87712936edfb40dee81e))
- Fix YAML syntax: correct timeout-minutes indentation ([7caf112a60ae](https://github.com/BTCDecoded/blvm-consensus/commit/7caf112a60ae52ee83c5f857db400193c2945255))
- Bump version to 0.1.4 for release [skip ci] ([cd4e6327fc5a](https://github.com/BTCDecoded/blvm-consensus/commit/cd4e6327fc5a7bea50a506db94faa6383033eff7))

## [v0.1.4-unverified] - 2025-11-23

### Reconstructed

- Bump version to 0.1.4 for release [skip ci] ([9feb22a817ff](https://github.com/BTCDecoded/blvm-consensus/commit/9feb22a817ffb77c5a42f65458968d9b80aa82c0))

## [v0.1.5-unverified] - 2025-11-23

### Reconstructed

- Complete consensus-proof implementation ([d86b084ca92b](https://github.com/BTCDecoded/blvm-consensus/commit/d86b084ca92b87bd059d24f6e3d3d13acba67968))
- feat(verification): Add formal verification to script, SegWit, and Taproot modules ([c45d5fd8eaab](https://github.com/BTCDecoded/blvm-consensus/commit/c45d5fd8eaab38d0bf3dbe679262837b60cae6fa))
- Update consensus validation and build dependencies ([c5e0977e64c2](https://github.com/BTCDecoded/blvm-consensus/commit/c5e0977e64c292975a1507abbf06c81cb65b44bd))
- docs: Organize documentation into structured directories ([6834b2ce581f](https://github.com/BTCDecoded/blvm-consensus/commit/6834b2ce581f313467b0b224344793409ed4e665))
- fuzz: Complete remaining fuzzing infrastructure tasks ([4ffb7727dde2](https://github.com/BTCDecoded/blvm-consensus/commit/4ffb7727dde25af1a7f96bcf8d4c97c6c6a61f47))
- chore: Update codebase with various improvements ([c5caa9381a69](https://github.com/BTCDecoded/blvm-consensus/commit/c5caa9381a695ac026bd93da99c05132b219a16e))
- Fix all compilation errors and test binaries ([4f51c328f574](https://github.com/BTCDecoded/blvm-consensus/commit/4f51c328f574db47e22e431474039470c24de6b0))
- Add benchmark comparison infrastructure and production features benchmarks ([9b12c5dc1015](https://github.com/BTCDecoded/blvm-consensus/commit/9b12c5dc1015c01a9468394cf695ff34709543ee))
- Simplify CI to Linux-only self-hosted runners ([a2ef5baa45ea](https://github.com/BTCDecoded/blvm-consensus/commit/a2ef5baa45ea8cdbd8beed90b35c3acfc7997b13))
- Fix runner label case sensitivity ([e4a97aaf998c](https://github.com/BTCDecoded/blvm-consensus/commit/e4a97aaf998c2ad67e62844fd496ae43f533f76a))
- Update CI workflow to use array format for runner labels ([d5febca4b157](https://github.com/BTCDecoded/blvm-consensus/commit/d5febca4b1573923039ab54f66e53d22c92e471b))
- Update Rust toolchain to 1.82.0 and fix clippy errors ([93258cb94cb2](https://github.com/BTCDecoded/blvm-consensus/commit/93258cb94cb221c5ba6c5049b0ad500d91e37269))
- Fix Rust 1.83 compatibility and clippy errors ([9d3dcc3c9d5c](https://github.com/BTCDecoded/blvm-consensus/commit/9d3dcc3c9d5cba38b5bc3394a9c3876260bfd839))
- Fix remaining clippy errors and rustfmt issues ([0115eea64469](https://github.com/BTCDecoded/blvm-consensus/commit/0115eea6446962b1b0d4c36c7b8725aeefeaaafc))
- Fix test failures: locktime encoding, tx_id calculation, block header validation ([0e54253537e5](https://github.com/BTCDecoded/blvm-consensus/commit/0e54253537e5ba11247b3e3f00e27e70ac316fbd))
- Remove accidentally committed test_compress file ([5990d481ed71](https://github.com/BTCDecoded/blvm-consensus/commit/5990d481ed715e7eb11c6bb9721d64bfee3bd8ba))
- Fix compress_target to match Bitcoin Core's GetCompact algorithm ([e7e112bf4f79](https://github.com/BTCDecoded/blvm-consensus/commit/e7e112bf4f79225a6c07ac66ccfbf0f5577b061a))
- Remove accidentally committed test file ([fed21ab6a2f1](https://github.com/BTCDecoded/blvm-consensus/commit/fed21ab6a2f1c36e088a234307ef029c2c550231))
- Fix round-trip test to allow precision loss in least significant word ([b048ead2b67b](https://github.com/BTCDecoded/blvm-consensus/commit/b048ead2b67bd5f14979921bdf25c6c5a524631a))
- Fix round-trip test: allow precision loss in words 0 and 1 ([b6f89e024874](https://github.com/BTCDecoded/blvm-consensus/commit/b6f89e02487431fdedc8d860611b7ff9c5e2e612))
- Skip problematic test case in round-trip test ([9252f59e3d37](https://github.com/BTCDecoded/blvm-consensus/commit/9252f59e3d3731544bc84486b3db67c18f0ef728))
- Remove accidentally committed debug file ([238512e610eb](https://github.com/BTCDecoded/blvm-consensus/commit/238512e610ebdf6569fea51396dff7b132ae3431))
- Fix remaining test failures ([ae5beaa49565](https://github.com/BTCDecoded/blvm-consensus/commit/ae5beaa49565c771a931192215bb20e1e56b976c))
- Fix mining tests: use valid script pattern for transaction verification ([4e1741a8d106](https://github.com/BTCDecoded/blvm-consensus/commit/4e1741a8d1064887f44d68b684ab7e8d1ce42517))
- Remove accidentally committed test script ([6ae37574c135](https://github.com/BTCDecoded/blvm-consensus/commit/6ae37574c1352a873a63c5e293643db05da923f7))
- Fix and lock Kani proof for compress_target round-trip ([71fd40f6da17](https://github.com/BTCDecoded/blvm-consensus/commit/71fd40f6da17ad17f4d1474d17770341d3dfb9c1))
- chore: trigger CI workflow ([64237388b261](https://github.com/BTCDecoded/blvm-consensus/commit/64237388b261ffd7e053b4f2ab9603d653d04a3b))
- ci: upload build artifacts for downstream dependencies ([70cfec159d18](https://github.com/BTCDecoded/blvm-consensus/commit/70cfec159d18489c421d43921216cb3dfd61b397))
- Fix clippy errors: unused variable and unnecessary casts ([0fe9dc83b52f](https://github.com/BTCDecoded/blvm-consensus/commit/0fe9dc83b52f77396a93f734a2e9d70c02ea5f49))
- Fix security audit: pin cargo-audit to v0.20.0 (compatible with Rust 1.83.0) ([76b572015d58](https://github.com/BTCDecoded/blvm-consensus/commit/76b572015d5826ee3ede439d2676dd6aace5c264))
- Fix property tests: correct target bounds and U256 shift operations ([93242c2d4c09](https://github.com/BTCDecoded/blvm-consensus/commit/93242c2d4c09cbf2c82a80865cedf42d68c9fa08))
- Fix all remaining test failures: overflow protection, property test bounds, and serialization ([c7a0ca2dd4cc](https://github.com/BTCDecoded/blvm-consensus/commit/c7a0ca2dd4cc6e858906f696a23ffa2f5ab2c0f9))
- Fix clippy errors and doctest failures ([7254f5ae09c9](https://github.com/BTCDecoded/blvm-consensus/commit/7254f5ae09c909c173c3cc38d18d6cb511be2493))
- Fix remaining CI failures: test, rustfmt, and make test more lenient ([b6d182fa4ae0](https://github.com/BTCDecoded/blvm-consensus/commit/b6d182fa4ae02cd7c77cde4b8f4c3c1fc258f6ae))
- Fix security audit: use cargo-audit 0.18.0 (compatible with Rust 1.83.0) ([e9197c366f12](https://github.com/BTCDecoded/blvm-consensus/commit/e9197c366f12db353f21b66ab45f3e8298869bd2))
- Fix security audit: use cargo-audit 0.17.6 (compatible with Rust 1.83.0) ([92fdefcd9e66](https://github.com/BTCDecoded/blvm-consensus/commit/92fdefcd9e6610a4c4a2dfa89e183c0da0023c81))
- Fix clippy and rustfmt issues ([b42e8610297e](https://github.com/BTCDecoded/blvm-consensus/commit/b42e8610297e10d97a1bf7490e980457093f10d0))
- Fix all test failures and clippy warnings ([74af092a1cb3](https://github.com/BTCDecoded/blvm-consensus/commit/74af092a1cb3bbb2311eb4d61569312504b2ae3f))
- Fix integration test: coinbase script_sig length requirement ([3337bf6c034e](https://github.com/BTCDecoded/blvm-consensus/commit/3337bf6c034e12269474f146d86d6dddbc848f2c))
- Fix rustfmt formatting in mining.rs ([aebf360416ba](https://github.com/BTCDecoded/blvm-consensus/commit/aebf360416baa206b7c9aeb78623d874cc0d0d9d))
- Fix BIP9 soft fork activation logic ([c36c58215314](https://github.com/BTCDecoded/blvm-consensus/commit/c36c58215314d0bb1f8e9ea785c3b411d0337642))
- Fix BIP9 activation logic: preserve lock-in detection height ([8ba580de77cd](https://github.com/BTCDecoded/blvm-consensus/commit/8ba580de77cd572dc0851272f903b132dfda6c74))
- Fix remaining soft_fork_activation test failures ([fc2e5c4e8b70](https://github.com/BTCDecoded/blvm-consensus/commit/fc2e5c4e8b7091cb3a67232595ad9a6152f907b4))
- Fix rustfmt formatting in soft_fork_activation.rs ([bd4ac290eb03](https://github.com/BTCDecoded/blvm-consensus/commit/bd4ac290eb03732082dadd3e8620c85c5f048d2b))
- Fix time_based_consensus test: correct minimal encoding assertion ([cb0888931567](https://github.com/BTCDecoded/blvm-consensus/commit/cb0888931567b5ab460020c95b8b011daad84652))
- Fix test_bip112_csv_sequence_combinations: correct CSV disabled sequence ([6a6e8a741682](https://github.com/BTCDecoded/blvm-consensus/commit/6a6e8a74168242b81b828fc2e5719b6d3bbe9a80))
- Add CI-aware test helpers for performance tests ([2450639890e5](https://github.com/BTCDecoded/blvm-consensus/commit/2450639890e5e80959816d24ab83afa33b1df026))
- Fix remaining production_integration_tests timeout for CI ([a2b5e0b6e81f](https://github.com/BTCDecoded/blvm-consensus/commit/a2b5e0b6e81fbe2d9ec3ba31c1b50049b01b47e0))
- Fix test coverage step: pin cargo-tarpaulin to compatible version ([722e5efa987d](https://github.com/BTCDecoded/blvm-consensus/commit/722e5efa987da0822af29ce4543be1df6e9eee90))
- Fix compilation errors in benchmarks ([2447ebcae32a](https://github.com/BTCDecoded/blvm-consensus/commit/2447ebcae32a336c38669839dfb80116dea397ec))
- Fix test coverage step: use lowercase 'xml' format ([bc80ce89e52a](https://github.com/BTCDecoded/blvm-consensus/commit/bc80ce89e52a76c2421d6f155fa33d407b34b400))
- Try cargo-audit 0.16.0 for Rust 1.83.0 compatibility ([8f49b54f28cf](https://github.com/BTCDecoded/blvm-consensus/commit/8f49b54f28cf44784ca088531140a11c8f3f3cc8))
- feat: Implement BLLVM optimizations (Phase 1 & 2) with comprehensive testing ([ad2e3415c411](https://github.com/BTCDecoded/blvm-consensus/commit/ad2e3415c41140ac341af74210579d080bf6688f))
- refactor: Improve BLLVM organization and documentation ([1d6b9fb9c185](https://github.com/BTCDecoded/blvm-consensus/commit/1d6b9fb9c18550bed4974d8506510b9d9a692aba))
- Make security audit and coverage non-blocking ([04512790b484](https://github.com/BTCDecoded/blvm-consensus/commit/04512790b484d1195f91989bb7a69c7bf9b0a33b))
- Fix security audit and coverage: update Rust toolchain to 1.88.0 ([03fd48b45020](https://github.com/BTCDecoded/blvm-consensus/commit/03fd48b4502058f36120b1ab62be9618f8b1f14d))
- Update all Rust toolchain versions to 1.88.0 in workflow ([0f89af97b6a5](https://github.com/BTCDecoded/blvm-consensus/commit/0f89af97b6a521ae5c57ea286b89d0f1bdb21cb4))
- Fix: Update rust-toolchain.toml to 1.88.0 ([5d93d4dad547](https://github.com/BTCDecoded/blvm-consensus/commit/5d93d4dad5471d312e0eb2acdaee8726e342f004))
- Fix clippy errors: deprecated functions, unused imports, useless comparisons ([bf5352b2d303](https://github.com/BTCDecoded/blvm-consensus/commit/bf5352b2d303f1044d7e86137b409ce8d2751b4b))
- Fix clippy errors: format! strings and unused imports ([accd50b8fa36](https://github.com/BTCDecoded/blvm-consensus/commit/accd50b8fa364114735acfb4ec040a14efcec816))
- Fix remaining format! string errors in block.rs ([f7b86c750a54](https://github.com/BTCDecoded/blvm-consensus/commit/f7b86c750a5409f9fc33bb202c7253f1cd88bcac))
- Fix: Update cargo-audit to 0.21.0 to support Cargo.lock format version 4 ([530f9988bf1e](https://github.com/BTCDecoded/blvm-consensus/commit/530f9988bf1eb3bf6445b5ed7ea860fc0187dc7c))
- Add benchmarking utilities for reproducible benchmarks ([3c2152e1886c](https://github.com/BTCDecoded/blvm-consensus/commit/3c2152e1886cd5e6c7a1816fb9b700cc07627b47))
- Fix: Use cargo-audit 0.20.0 instead of 0.21.0 (0.21.0 requires Rust 1.89) ([bc537a2125f8](https://github.com/BTCDecoded/blvm-consensus/commit/bc537a2125f81c243f3a2a42458e17b71e7c2f89))
- Update repository references to new names (bllvm-*) ([685de957bb70](https://github.com/BTCDecoded/blvm-consensus/commit/685de957bb709731b68a28253d7f1f17e8c2bd37))
- docs: Add reference to master status document ([66ddc6f18c8b](https://github.com/BTCDecoded/blvm-consensus/commit/66ddc6f18c8b0e47524e7e8ddb7a3ee93611cc29))
- docs: Update bllvm-sdk description to 'developer toolkit' ([00546157316d](https://github.com/BTCDecoded/blvm-consensus/commit/00546157316d6f38bf161f8dd3ec89e1ef1fec80))
- Add realistic block validation benchmark for fair comparison with Bitcoin Core ([cc3106851123](https://github.com/BTCDecoded/blvm-consensus/commit/cc3106851123e9b723dfa0080581a4bde365a331))
- feat: Add Intel SHA-NI single-hash optimization + integrate with block validation ([201d404d9845](https://github.com/BTCDecoded/blvm-consensus/commit/201d404d9845963a5a48fee16d026fa392dd1fd5))
- feat: Add focused performance benchmarks ([aa1685fd77e0](https://github.com/BTCDecoded/blvm-consensus/commit/aa1685fd77e0dc78f24a337d9712273462c9ce56))
- docs: Add performance summary with CPU feature verification ([50742d06834e](https://github.com/BTCDecoded/blvm-consensus/commit/50742d06834e9e9b42923833a7c5bdc1c9c87f48))
- feat: Add low-hanging fruit optimizations ([75ed30c2f5d5](https://github.com/BTCDecoded/blvm-consensus/commit/75ed30c2f5d537c74937d64c797eb447ed1040a1))
- fix: Resolve all compiler warnings ([6ec5bab1448c](https://github.com/BTCDecoded/blvm-consensus/commit/6ec5bab1448c4ec78a8aac98b96d8428bd6c378f))
- fix: Add missing crypto module declaration in lib.rs ([8a047e4361c1](https://github.com/BTCDecoded/blvm-consensus/commit/8a047e4361c105435569d48ce776dfb639d27c0d))
- fix: Update test imports from consensus_proof to bllvm_consensus ([ba96a3fa7e76](https://github.com/BTCDecoded/blvm-consensus/commit/ba96a3fa7e762ca0001503a558b13e62ed544ff6))
- fix: Resolve Clippy and Rustfmt errors ([aaaf990c19a1](https://github.com/BTCDecoded/blvm-consensus/commit/aaaf990c19a1e70f8635235c696c581de9266017))
- fix: Resolve remaining Clippy boolean expression errors ([300cd8aebf65](https://github.com/BTCDecoded/blvm-consensus/commit/300cd8aebf659b69661d0df1114903ade171a97c))
- fix: Remove remaining boolean expression logic bug ([ef8f22b3cb61](https://github.com/BTCDecoded/blvm-consensus/commit/ef8f22b3cb619a4f931c41083c00748d47339f8c))
- fix: Resolve all remaining Clippy boolean expression errors ([aef486393ff1](https://github.com/BTCDecoded/blvm-consensus/commit/aef486393ff165aa3c4a4f07f84fda8f974f8606))
- fix: Resolve final Clippy error (absurd extreme comparison) ([f990433176a8](https://github.com/BTCDecoded/blvm-consensus/commit/f990433176a8e872a8b7623b077160b22afec7f0))
- fix: Correct SHA-NI final hash extraction ([5cdff481dc8e](https://github.com/BTCDecoded/blvm-consensus/commit/5cdff481dc8e83862fd5353b7253caae15e5102f))
- fix: Correct SHA-NI hash extraction with proper reordering ([46b69aeb619f](https://github.com/BTCDecoded/blvm-consensus/commit/46b69aeb619f669271862ccf83c3f68b562a22ea))
- fix(pow): make expand_target public for protocol layer access ([111dea70b7b2](https://github.com/BTCDecoded/blvm-consensus/commit/111dea70b7b246d625bf9435714bf156631f68dc))
- Fix kani conditional compilation: use #[cfg(kani)] instead of #[cfg(feature = "verify")] ([9563af77ee08](https://github.com/BTCDecoded/blvm-consensus/commit/9563af77ee08ba656fcb00292857d720b276d466))
- Fix compilation errors with --all-features ([09285963b304](https://github.com/BTCDecoded/blvm-consensus/commit/09285963b304d98e59e005c924ee6fc4b168e4a0))
- Fix GenericArray type annotation for k256 verify ([184709564fa7](https://github.com/BTCDecoded/blvm-consensus/commit/184709564fa7f82298b4599cb3bb585d415516d5))
- Fix k256 verify: use Sha256::digest for message hash ([12ea87094419](https://github.com/BTCDecoded/blvm-consensus/commit/12ea87094419c64ebe6f734331e83a6993960986))
- Fix clippy and rustfmt errors ([4c9649baada9](https://github.com/BTCDecoded/blvm-consensus/commit/4c9649baada9641ad8639629ec7cf55f6ab17e0f))
- Skip sha_ni tests when SHA-NI is not available ([157bc8d34c46](https://github.com/BTCDecoded/blvm-consensus/commit/157bc8d34c465e27668f4412ebc5cdae0725e76d))
- Ignore sha_ni tests in CI - implementation has bugs ([1da4b024b9ef](https://github.com/BTCDecoded/blvm-consensus/commit/1da4b024b9eff75b15845b0f06819dbb15e29267))
- Fix doctest imports - use correct crate name bllvm_consensus ([72e0be150ea2](https://github.com/BTCDecoded/blvm-consensus/commit/72e0be150ea272f4ed4bd9c44ed60e965440ee02))
- Fix all doctest imports - replace consensus_proof with bllvm_consensus ([2781136738da](https://github.com/BTCDecoded/blvm-consensus/commit/2781136738da6909b3703ee0d133cf69efa10b7a))
- Fix remaining consensus_proof references in doctest code bodies ([28439034dda5](https://github.com/BTCDecoded/blvm-consensus/commit/28439034dda51c35a7dd37a052c37ba39fa6c2b8))
- Fix rsync cache: ensure target cache directory exists before syncing ([ac13d6c0b564](https://github.com/BTCDecoded/blvm-consensus/commit/ac13d6c0b564b047d32eabfaac25d9ccf8051c64))
- Make repository-dispatch non-blocking to prevent build job failure ([ee6fc66e16d5](https://github.com/BTCDecoded/blvm-consensus/commit/ee6fc66e16d5e6b8ddb63ddeaa6c50df20e2db43))
- Use REPO_ACCESS_TOKEN for repository-dispatch (org-level secret) ([6867dd9d9d76](https://github.com/BTCDecoded/blvm-consensus/commit/6867dd9d9d76f83bba07da79d9700886818c43c4))
- Upgrade cargo-audit to 0.22.0 for Cargo.lock format version 4 support ([241ef5dc76fb](https://github.com/BTCDecoded/blvm-consensus/commit/241ef5dc76fbf978f9e6de763955b71f371ef6a1))
- Add --locked flag to cargo-audit installation to use exact dependency versions ([1cba86189ada](https://github.com/BTCDecoded/blvm-consensus/commit/1cba86189adab4f1c252919c30425e07ee9b467f))
- Upgrade Rust to 1.89.0 for Security Audit job (required by cargo-audit 0.22.0) ([0b8ca4b717ec](https://github.com/BTCDecoded/blvm-consensus/commit/0b8ca4b717ec5cd4acc7947f2fd7e516849c1edc))
- Update serde to 1.0.228 for iroh 0.95 compatibility ([4b583fb297de](https://github.com/BTCDecoded/blvm-consensus/commit/4b583fb297de379a792e8bd250defda4d04154e7))
- Fix Bitcoin difficulty adjustment off-by-one error (with compatibility option) ([77cc2051fd78](https://github.com/BTCDecoded/blvm-consensus/commit/77cc2051fd78f47e9ddeb4a6b90540a100277091))
- Add comprehensive mathematical protections across consensus-critical modules ([f4716c80c360](https://github.com/BTCDecoded/blvm-consensus/commit/f4716c80c36062a4e850822e18f4a9082c48f98a))
- feat: Senior Rust engineer improvements - Phase 1-3 ([0517dd6e11ff](https://github.com/BTCDecoded/blvm-consensus/commit/0517dd6e11ff9a0219ee2b79b4903e56f50bd5e6))
- refactor: Remove bench definitions - moved to bllvm-bench ([e201393b9ac6](https://github.com/BTCDecoded/blvm-consensus/commit/e201393b9ac6ff3ac74cfea2dbbf98fc202ceaa3))
- Fix compilation errors: Convert Vec to SmallVec/Box for production feature ([8eb0169b54fd](https://github.com/BTCDecoded/blvm-consensus/commit/8eb0169b54fdb9938324bf685cd3fb1589156e41))
- fix: add ctv feature ([9ac2a2a63fa2](https://github.com/BTCDecoded/blvm-consensus/commit/9ac2a2a63fa2e1d0a330709d28d9f09100c18b78))
- Complete edge case coverage: Add CVE-2012-2459 and CVE-2018-17144 tests ([5555df1f4fcf](https://github.com/BTCDecoded/blvm-consensus/commit/5555df1f4fcfd891c0118b972806dbbfdf1de6af))
- Fix all compile-time warnings ([b55303c174b8](https://github.com/BTCDecoded/blvm-consensus/commit/b55303c174b8453aa0400232ea1df03b2fb1e21c))
- Fix all compilation warnings and complete TODOs ([1a3787598acd](https://github.com/BTCDecoded/blvm-consensus/commit/1a3787598acdbccdcdff0d960fcba33d807db36c))
- fix: disable sha2-asm for Windows targets ([0dc158ee8cc2](https://github.com/BTCDecoded/blvm-consensus/commit/0dc158ee8cc2d83dbaed0f5aeacd1f4bd26f1f15))
- fix: add explicit x86_64-pc-windows-gnu target config for sha2 ([87327a62cb66](https://github.com/BTCDecoded/blvm-consensus/commit/87327a62cb66f079880d29325d9bd0bdedc8d0be))
- fix: restore sha2 in main dependencies to fix Linux builds ([c1740aa479aa](https://github.com/BTCDecoded/blvm-consensus/commit/c1740aa479aa3c0a9a97208ad150d7927ef42648))
- fix: remove duplicate Windows target dependency config ([fe662b36027c](https://github.com/BTCDecoded/blvm-consensus/commit/fe662b36027ce36ab862c4252fe146cd28362a08))
- fix: properly disable sha2-asm for Windows using target-specific deps ([378895add545](https://github.com/BTCDecoded/blvm-consensus/commit/378895add545f63ee7039e67c6792e6d187cfed7))
- Organize documentation: archive historical/status docs, create README structure ([84029a95f62b](https://github.com/BTCDecoded/blvm-consensus/commit/84029a95f62bb419496fdeed9240aed8db29945a))
- Update .gitignore: remove target/, fuzz/target/, and Cargo.lock from tracking ([f8fceda68b0f](https://github.com/BTCDecoded/blvm-consensus/commit/f8fceda68b0f1ee572db5402d8b0b47c4b6af0ce))
- Add benchmark_results.txt to .gitignore and remove from tracking ([c484ed762f53](https://github.com/BTCDecoded/blvm-consensus/commit/c484ed762f531ba28b686b6ccb500f1d91865bfc))
- Archive historical documentation to bllvm-docs ([62835578ac22](https://github.com/BTCDecoded/blvm-consensus/commit/62835578ac22f2429ac25997263a360d2a79c9f5))
- fix: pin k256 to exact version ([66beb13d648c](https://github.com/BTCDecoded/blvm-consensus/commit/66beb13d648c9eb0b8cd1a71cb467deeb5cc5c21))
- Archive outdated documentation ([9bcbc25732dd](https://github.com/BTCDecoded/blvm-consensus/commit/9bcbc25732dd7f3c8c68ef7bd3af694569731acb))
- feat: add BIP119 CTV validation and integration tests ([fc920692c897](https://github.com/BTCDecoded/blvm-consensus/commit/fc920692c89789f4e177f651182453621a8d842e))
- refactor(tests): remove redundant tests and consolidate helpers ([e114a454b209](https://github.com/BTCDecoded/blvm-consensus/commit/e114a454b209aa6b2c84a22b0170d51b9565567d))
- refactor(tests): consolidate more duplicate test helpers ([8f56c2364c99](https://github.com/BTCDecoded/blvm-consensus/commit/8f56c2364c99938c05508cdd3ae02c95cd9121fa))
- chore(tests): remove trailing empty lines from mempool_rbf_tests.rs ([1b9c752e9161](https://github.com/BTCDecoded/blvm-consensus/commit/1b9c752e9161c035b2feedbbf7d082486b49aafe))
- feat: Add inline hints to hot functions for LLVM optimization ([ebbe8d41be39](https://github.com/BTCDecoded/blvm-consensus/commit/ebbe8d41be395955f2c78c032053dd9846fb0a66))
- feat: Integrate cache-aligned structures and Kani-proven bounds ([ef64f233952d](https://github.com/BTCDecoded/blvm-consensus/commit/ef64f233952dacea3a92605f5d715ce4c8c31bce))
- feat: Expand Kani-proven bounds and consolidate function implementations ([5b4761c96a74](https://github.com/BTCDecoded/blvm-consensus/commit/5b4761c96a74f7801084f23cdaa9dd956af5ad10))
- Fix SHA-NI implementation using Bitcoin Core's Shuffle/Unshuffle pattern ([f5de95e083b1](https://github.com/BTCDecoded/blvm-consensus/commit/f5de95e083b172d958ee0aaae9f4a2ef2909a066))
- Fix coverage timeout: add tarpaulin timeout and reduce slow test ranges ([8e272b215fe9](https://github.com/BTCDecoded/blvm-consensus/commit/8e272b215fe99cb7eda181e24523d8d6d0cdbbf3))
- Fix prop_block_subsidy_constant_time: make timeout lenient under coverage ([256cac5caafb](https://github.com/BTCDecoded/blvm-consensus/commit/256cac5caafb81b05cc8da184adf1189a9207000))
- Check for CARGO_TARPAULIN env var in addition to TARPAULIN ([38ca6f8d8746](https://github.com/BTCDecoded/blvm-consensus/commit/38ca6f8d874635a65ad168490353950341f3113b))
- Fix tarpaulin flag: use --timeout instead of --test-timeout ([65024507625a](https://github.com/BTCDecoded/blvm-consensus/commit/65024507625a81b707fa2a0473e04feadeff017b))
- Make performance tests more lenient to handle system load variations ([d38379833973](https://github.com/BTCDecoded/blvm-consensus/commit/d38379833973d555e0ad3c1b8567a3bd98038ec6))
- Add orchestrator trigger: trigger release orchestrator on push to main ([fe562be9d4fd](https://github.com/BTCDecoded/blvm-consensus/commit/fe562be9d4fd1045c5544eb2562fd35d17ffafc9))
- Standardize CI workflow: security depends on setup, build depends on all checks ([4b9e3919814d](https://github.com/BTCDecoded/blvm-consensus/commit/4b9e3919814def07ce6e4f038d0fa52121ef47b4))
- Fix CI: performance test boundary and tarpaulin timeouts ([1f579cb45585](https://github.com/BTCDecoded/blvm-consensus/commit/1f579cb45585059c17b9590d93890af05b1bf781))
- Fix property test ranges: use helper functions for conditional ranges ([d7ef92ea1256](https://github.com/BTCDecoded/blvm-consensus/commit/d7ef92ea1256d5e8b68dc57cba073925c5bbf170))
- Add independent release workflow for bllvm-consensus ([1d1ffdbe01dc](https://github.com/BTCDecoded/blvm-consensus/commit/1d1ffdbe01dc93f56e6a90e0c08b56fac2e2b95b))
- Increase block subsidy performance test timeout to 10ms ([4d96ae84e15a](https://github.com/BTCDecoded/blvm-consensus/commit/4d96ae84e15abd68588ffe90ac70c518c54ad408))
- Add release job to CI workflow ([42edafc8d7ab](https://github.com/BTCDecoded/blvm-consensus/commit/42edafc8d7ab8466bcc01b21781f4a469bbb066e))
- Fix version determination to only match package version ([92e3bef4be46](https://github.com/BTCDecoded/blvm-consensus/commit/92e3bef4be461980048f237e914172c93af464e8))
- Fix version extraction: use grep instead of awk ([f69124436188](https://github.com/BTCDecoded/blvm-consensus/commit/f6912443618895d960ebc45c73143a0674fd493e))
- Commit Cargo.toml changes before publish ([fde05275122f](https://github.com/BTCDecoded/blvm-consensus/commit/fde05275122ffb2fe74d4d4d38abbae1e1996a1d))
- Update kani-verifier version to 0.66 for crates.io compatibility ([2548a3af47e0](https://github.com/BTCDecoded/blvm-consensus/commit/2548a3af47e0ce964d779ebce26e0f51a9f2d49b))
- Regenerate Cargo.lock before publish to fix kani-verifier version ([86f2c730f4dd](https://github.com/BTCDecoded/blvm-consensus/commit/86f2c730f4ddf7e3c811d8e8adb71b8b958fff83))
- Fix version update and Cargo.lock regeneration order ([3e57309385af](https://github.com/BTCDecoded/blvm-consensus/commit/3e57309385af725162f0b03c09465bb017b1d7a5))
- Fix Cargo.lock regeneration order and version update ([c84464a55ae0](https://github.com/BTCDecoded/blvm-consensus/commit/c84464a55ae0fc1d77ec900341ed829fc4e9746a))
- Improve version update and add verification ([736f305a725b](https://github.com/BTCDecoded/blvm-consensus/commit/736f305a725b21934a94d7051366fa9608630357))
- Enhance release pipeline with mathematical verification and pre-release checks ([57034b696a03](https://github.com/BTCDecoded/blvm-consensus/commit/57034b696a03dc8558aa5c4dd6685c79a20e9a6b))
- Fix Kani installation and PATH handling in verify job ([7f32d6f85f87](https://github.com/BTCDecoded/blvm-consensus/commit/7f32d6f85f877a7f1e44c8232fe2087fd52ceeaa))
- Remove Kani installation step - use pre-installed Kani on runner ([434263d615d8](https://github.com/BTCDecoded/blvm-consensus/commit/434263d615d861c07e1218cfdf2c81f92eb08747))
- Fix Kani command - use 'cargo kani' instead of 'kani' ([6c18af6d254f](https://github.com/BTCDecoded/blvm-consensus/commit/6c18af6d254fed0b7d6f167ab112bc5aa0be6690))
- Simplify Kani verification step name to 'Verify' ([c9d7f0a115c1](https://github.com/BTCDecoded/blvm-consensus/commit/c9d7f0a115c1150991b478c63bfffc065b3a8a9f))
- Revert step name to 'Run Kani proofs' ([4fbd92eddbb5](https://github.com/BTCDecoded/blvm-consensus/commit/4fbd92eddbb5e3a8316d5837bda9243414eacc90))
- Change job name from 'Mathematical Verification' to 'Verify' ([8a6a3e9c0ea8](https://github.com/BTCDecoded/blvm-consensus/commit/8a6a3e9c0ea8324fcb81de147e91aa5b7d85bfab))
- Fix Kani proof compilation errors in taproot.rs ([bae5bc22a118](https://github.com/BTCDecoded/blvm-consensus/commit/bae5bc22a11806e67bd7603e5ceeb1aa50635c7a))
- Fix unused variable warnings in Kani proofs ([84fb846086be](https://github.com/BTCDecoded/blvm-consensus/commit/84fb846086be90e38ac49b8db1f6135746c0e66e))
- Fix duplicate kani_proofs modules and syntax error ([892f61874575](https://github.com/BTCDecoded/blvm-consensus/commit/892f6187457547578b6f58249f50597bcd8eedb8))
- Fix Kani proof compilation: replace kani::any() with helper functions ([8232c51b826f](https://github.com/BTCDecoded/blvm-consensus/commit/8232c51b826f1370d0b587e2389e248c328cf9cf))
- Fix rustfmt formatting in segwit.rs ([a82f2a342956](https://github.com/BTCDecoded/blvm-consensus/commit/a82f2a34295659693a30f1c664fec4ba74d7b973))
- Fix Kani compilation: replace kani::any() with helper functions ([23575b838e02](https://github.com/BTCDecoded/blvm-consensus/commit/23575b838e027b0d772d30bd78e52a961d2eddda))
- Fix remaining Kani compilation errors ([8f6184f1e37f](https://github.com/BTCDecoded/blvm-consensus/commit/8f6184f1e37f39b4a9fcdb5297af903fd71b3c6a))
- Fix remaining Kani compilation errors ([9f906ac76baa](https://github.com/BTCDecoded/blvm-consensus/commit/9f906ac76baa431f804867cc1f381b42bc0deb20))
- Fix final Kani compilation errors ([fb0834dfbc3d](https://github.com/BTCDecoded/blvm-consensus/commit/fb0834dfbc3d4e820b771a289c6f8ab6c3252f64))
- Fix rustfmt formatting issues ([8eddd7c557ac](https://github.com/BTCDecoded/blvm-consensus/commit/8eddd7c557acb32992c77d19dd0abea1ce86ecff))
- Fix mutable tx in economic.rs Kani proof ([c46da52b6bed](https://github.com/BTCDecoded/blvm-consensus/commit/c46da52b6bedc75626b8a77e671bb6dc667e04e2))
- Fix unwind attributes: use integer literals with source constant comments ([977adbd3fa56](https://github.com/BTCDecoded/blvm-consensus/commit/977adbd3fa566cf86197c9e0ddbedfa02a527f10))
- Optimize BIP113 Kani proofs: add unwind attributes and reduce bounds for tractability ([97889d1cb71c](https://github.com/BTCDecoded/blvm-consensus/commit/97889d1cb71ceb799996fc08b8466a67003f7059))
- Further reduce BIP113 proof bounds to avoid sort_unstable unwinding issues ([13165fdb796d](https://github.com/BTCDecoded/blvm-consensus/commit/13165fdb796dea144933005030f89c78fa9a95d3))
- Add explicit header_count > 0 assumption to help Kani prune paths early ([abf10ec1d23c](https://github.com/BTCDecoded/blvm-consensus/commit/abf10ec1d23c88c584ad12cad5f9f20709567082))
- Disable kani_bip113_median_time_ge_minimum due to sort_unstable unwinding issues ([1931ef818b65](https://github.com/BTCDecoded/blvm-consensus/commit/1931ef818b652f926e05c068399bf53a53b987d5))
- Optimize BIP113 proof: use u8 for header_count to help Kani prune paths early ([be2196d52e02](https://github.com/BTCDecoded/blvm-consensus/commit/be2196d52e0271c65b34e2d726eebfad90feba6a))
- Fix cargo-audit version compatibility with Rust 1.88.0 ([338c977550d7](https://github.com/BTCDecoded/blvm-consensus/commit/338c977550d7784f951f2abf90caae3027de8d17))
- Improve Kani verification step with timeout and output filtering ([ee4287de0411](https://github.com/BTCDecoded/blvm-consensus/commit/ee4287de0411e828bf53c9e6deb84a4a5e2c61c0))
- Optimize Kani verification and test execution ([3d67fa377ace](https://github.com/BTCDecoded/blvm-consensus/commit/3d67fa377acec682c19b80aa1beaff5087b16872))
- Remove all timeouts and maximize Kani proof parallelization ([286f76faf0d9](https://github.com/BTCDecoded/blvm-consensus/commit/286f76faf0d9185de83b93fc94ec4d0dae96d201))
- Fix Kani proof: constrain coinbase value to not exceed MAX_MONEY ([05f93502b80f](https://github.com/BTCDecoded/blvm-consensus/commit/05f93502b80f8b810ec10ccf625731b15b052858))
- Set maximum timeout for Kani verification job ([0caf6fc5ec58](https://github.com/BTCDecoded/blvm-consensus/commit/0caf6fc5ec58897c86be2d96fb6f5b5587e0450f))
- Fix Kani proof failure and improve error handling ([a66cdd264a54](https://github.com/BTCDecoded/blvm-consensus/commit/a66cdd264a5472d6c51d56050684f7272beb38f4))
- Split Kani proofs into Fast/Medium and Slow steps ([53ce0846a661](https://github.com/BTCDecoded/blvm-consensus/commit/53ce0846a6618f627893ed35c71ab53c1cb54b1a))
- Reduce Kani parallelism to prevent OOM and add perf tag to verify step ([c58b8ae6fc1e](https://github.com/BTCDecoded/blvm-consensus/commit/c58b8ae6fc1e57587e3a63b7ce892a0d4dfe9bd5))
- Implement tiered Kani proof execution based on event type ([0cdb00991ac3](https://github.com/BTCDecoded/blvm-consensus/commit/0cdb00991ac33063e534f75379a75fa5ad2bc394))
- Add Kani optimization guide and enable faster solver ([416157789e9a](https://github.com/BTCDecoded/blvm-consensus/commit/416157789e9a9ebb960e945730a63e3c5c9db309))
- Optimize Kani proofs while maintaining mathematical validity ([f3bd42c124c8](https://github.com/BTCDecoded/blvm-consensus/commit/f3bd42c124c8edbafaee37dc900e2b7f80287dad))
- Fix Kani jobs flag and formatting ([e3ffddae0bb8](https://github.com/BTCDecoded/blvm-consensus/commit/e3ffddae0bb8d994177309054c2b7ec5076b30b4))
- Change non-verification jobs to use 'builds' runners ([abff9138541b](https://github.com/BTCDecoded/blvm-consensus/commit/abff9138541b8c0100a2c05f90c72bd36b34b20b))
- Add GitHub attestations for releases ([6f60c5ff5254](https://github.com/BTCDecoded/blvm-consensus/commit/6f60c5ff52548d7706827bade488ba45cabbe022))
- Optimize Kani unwind bounds: remove low-value proofs and reduce bounds ([61229faafb94](https://github.com/BTCDecoded/blvm-consensus/commit/61229faafb943111c85ee0bf8dd31bb10bbd2ab9))
- Add skip_verification workflow input ([ffe95385b4e3](https://github.com/BTCDecoded/blvm-consensus/commit/ffe95385b4e3e0b85882ecb07c9ca6c14507b760))
- Add skip condition to Collect build metadata step ([d3b52ae8744d](https://github.com/BTCDecoded/blvm-consensus/commit/d3b52ae8744d3b0852975dd085eb4151a960dcf3))
- Fix: Add workflow_dispatch to build and release job conditions ([37e9e0064f58](https://github.com/BTCDecoded/blvm-consensus/commit/37e9e0064f580d42e033a4ca6bde3079532d1ef1))
- Fix: Handle 'crate already exists' error gracefully ([1cbf1cb0226d](https://github.com/BTCDecoded/blvm-consensus/commit/1cbf1cb0226d1a998bc3e15a84aaeaf533b6d019))
- Fix: Add enhanced debugging for publish step ([94b49601f076](https://github.com/BTCDecoded/blvm-consensus/commit/94b49601f0763baf65db854845f8363a4f0394a1))
- Fix: Update release notes to handle missing crates.io versions ([92c843c212dc](https://github.com/BTCDecoded/blvm-consensus/commit/92c843c212dc5e0273c11cd1890c21c26542ddc8))
- Fix: Correct release notes syntax for conditional links ([24f63b8f90d4](https://github.com/BTCDecoded/blvm-consensus/commit/24f63b8f90d4fc7b695b2a91290948aeba6ba3a4))
- Add skip_tests workflow input option ([593eb16415f9](https://github.com/BTCDecoded/blvm-consensus/commit/593eb16415f99cf5d89602ab8cac1d1544df7e86))
- Simplify version tag: untested counts as unverified ([9e1f8e23777b](https://github.com/BTCDecoded/blvm-consensus/commit/9e1f8e23777b61170c9d86282b80a016da54b13d))
- Fix: Restructure conditional expressions to avoid shell syntax errors ([c77a77829470](https://github.com/BTCDecoded/blvm-consensus/commit/c77a7782947073ee499fdb03406f849aecc26d80))
- Make verify job conditional when skip_verification is true ([4255d1e15887](https://github.com/BTCDecoded/blvm-consensus/commit/4255d1e1588786589a40f743c2b0b65e7426096b))
- Fix: Update release job condition to handle skipped verify ([f98f947dc81b](https://github.com/BTCDecoded/blvm-consensus/commit/f98f947dc81bb31e94353762e19749fd18101595))
- Fix: Correct conditional logic for verify dependency ([a49adea3d026](https://github.com/BTCDecoded/blvm-consensus/commit/a49adea3d0263f0e83cae0851c6d4012ba6ca1be))
- Make test job conditional when skip_tests is true ([3e531f67ff44](https://github.com/BTCDecoded/blvm-consensus/commit/3e531f67ff44fefad51cf45a7503bcef7497e813))
- Fix: Update release job condition to handle skipped tests ([e4e0ea20523e](https://github.com/BTCDecoded/blvm-consensus/commit/e4e0ea20523efd7861d271177c5e1c90ca0b099f))
- Fix: Avoid shell syntax errors in version determination ([a28117648fb4](https://github.com/BTCDecoded/blvm-consensus/commit/a28117648fb434d88972a3d8ea9bf35d9ca9773b))
- Fix: Correct heredoc structure in release notes generation ([76f1ca799d45](https://github.com/BTCDecoded/blvm-consensus/commit/76f1ca799d45e21969fae6f81b5f313ed9a47639))
- Fix: Move github.repository expression outside heredoc ([77cfcfdb79d2](https://github.com/BTCDecoded/blvm-consensus/commit/77cfcfdb79d2a456326b32de07ef476a2246072d))
- Fix: Remove invalid GITHUB_OUTPUT lines and add version verification ([3ab44316ec4f](https://github.com/BTCDecoded/blvm-consensus/commit/3ab44316ec4fd41cb79d10c5b6eea91100a894b8))
- Fix: Use secrets.CARGO_REGISTRY_TOKEN in if conditions ([692c811657e8](https://github.com/BTCDecoded/blvm-consensus/commit/692c811657e80f11dfb90bb961ecdedb52ececec))
- Fix: Set CARGO_REGISTRY_TOKEN as job-level env var ([fa0f50d4f8a4](https://github.com/BTCDecoded/blvm-consensus/commit/fa0f50d4f8a46c1507f25391beda96ae221ffc1b))
- Fix: Only commit Cargo.toml, not Cargo.lock ([6f2f53a8e6ef](https://github.com/BTCDecoded/blvm-consensus/commit/6f2f53a8e6efa2646398162d99ed50aca001296c))
- Add [skip ci] support to prevent CI on version bump commits ([c3a4d2627902](https://github.com/BTCDecoded/blvm-consensus/commit/c3a4d26279020ae81c3e2eefd36abb6db2e9bcea))
- Fix: Add [skip ci] check to docs job ([bacf023a2e57](https://github.com/BTCDecoded/blvm-consensus/commit/bacf023a2e57b36687a469ddea7e463b517621be))
- Fix: Reorder conditions so skip_tests/skip_verification work correctly ([82de6fc7c5d8](https://github.com/BTCDecoded/blvm-consensus/commit/82de6fc7c5d8e2838a922774085949ab3c38c8db))
- Fix: Remove skip_tests/skip_verification from job conditions ([0d658a620736](https://github.com/BTCDecoded/blvm-consensus/commit/0d658a6207367fd27141de252041650e3087a576))
- Fix: Remove internal skip_check logic, use job-level conditions ([b7d087dc9d21](https://github.com/BTCDecoded/blvm-consensus/commit/b7d087dc9d213f690ed4b8f68d156a0c0dd77f2e))
- Fix: Fix syntax error in verify job Kani proofs step ([fba007f14b36](https://github.com/BTCDecoded/blvm-consensus/commit/fba007f14b361ee54db9ea66f64ec4f84fc54041))
- Fix: Fix broken YAML syntax in test job ([43a21248fb0e](https://github.com/BTCDecoded/blvm-consensus/commit/43a21248fb0e173b21486d2fd1662883efb9895d))
- Fix: Fix all broken YAML syntax from skip_check removal ([be1c65ef5456](https://github.com/BTCDecoded/blvm-consensus/commit/be1c65ef545669ae26078d7506b3ee5c7948f7ee))
- Bump version to 0.1.1 for release [skip ci] ([58d8cde179a7](https://github.com/BTCDecoded/blvm-consensus/commit/58d8cde179a7d2e62449c87053bf6e8dac917eef))
- Fix: Remove unsupported custom predicate from attestation ([4c1e8c70a13c](https://github.com/BTCDecoded/blvm-consensus/commit/4c1e8c70a13c48a8f3f7f2a03c707ee709cb9228))
- Bump version to 0.1.2 for release [skip ci] ([1fc670bca651](https://github.com/BTCDecoded/blvm-consensus/commit/1fc670bca6512b043306956cf2b372836464e48c))
- Improve crates.io version checking and release notes generation ([8c991370710d](https://github.com/BTCDecoded/blvm-consensus/commit/8c991370710dfcdc5820e3b1506ef025f3a69688))
- Add timeout handling and better error messages for Kani verification ([94ae823f278d](https://github.com/BTCDecoded/blvm-consensus/commit/94ae823f278d4cbc6efa0405c045dd4f0e31e212))
- Bump version to 0.1.3 for release [skip ci] ([5da4077e9eac](https://github.com/BTCDecoded/blvm-consensus/commit/5da4077e9eac92f3d1f3e8d64ae528b7bfcd9cfb))
- Integrate BIP30, BIP34, BIP90 into connect_block and add comprehensive verification ([edc1f200ab28](https://github.com/BTCDecoded/blvm-consensus/commit/edc1f200ab2851fd5184e2c1164315cf3bd35374))
- Fix YAML syntax: correct timeout-minutes indentation ([6ba7821b476d](https://github.com/BTCDecoded/blvm-consensus/commit/6ba7821b476d9f39653225bd3d6ef84a223cd182))
- Fix clippy warnings ([06a97bd30135](https://github.com/BTCDecoded/blvm-consensus/commit/06a97bd30135526d75a513548c2720d667bd6145))
- Fix import errors and remove unused imports ([01891dcbdc1f](https://github.com/BTCDecoded/blvm-consensus/commit/01891dcbdc1f5938f2deeee1eaa062198e2ac8d4))
- Add Witness import to fix compilation errors ([fe2c7a4954f1](https://github.com/BTCDecoded/blvm-consensus/commit/fe2c7a4954f111b52d1d69875766fc0d3b0a9717))
- Fix import errors and function call issues in test files ([cd808fa2d164](https://github.com/BTCDecoded/blvm-consensus/commit/cd808fa2d16449fcec5732ed77cc6f16eb318e68))
- Run cargo fmt to fix formatting issues ([2dd2a51b6365](https://github.com/BTCDecoded/blvm-consensus/commit/2dd2a51b636549d233389051c1711b9770fd8722))
- Fix clippy warnings ([a941960fc022](https://github.com/BTCDecoded/blvm-consensus/commit/a941960fc02209b51193ffa788244c02a222f08d))
- docs: Add BIP66/BIP147 integration plan ([80fe5c5f8d4f](https://github.com/BTCDecoded/blvm-consensus/commit/80fe5c5f8d4fb594f9c1325c160c6c6c44373474))
- fix: Update test to handle Result<bool> return type from verify_signature ([74c900bd2009](https://github.com/BTCDecoded/blvm-consensus/commit/74c900bd2009265864cfe680e20ac21f6a867cac))
- Fix compilation errors and warnings in test files ([32585d331daa](https://github.com/BTCDecoded/blvm-consensus/commit/32585d331daaee01329fb447800495f9eb8e8837))
- Fix cargo fmt formatting in coinbase_maturity.rs ([7fdf109057dc](https://github.com/BTCDecoded/blvm-consensus/commit/7fdf109057dce0cdd9deabb578b73a19306d8b7d))
- Enforce test/verification requirements for build and release ([709968cde278](https://github.com/BTCDecoded/blvm-consensus/commit/709968cde2784cd46b4a0fc790c847cbcdbdf49d))
- Bump version to 0.1.4 for release [skip ci] ([277ed06b6f9a](https://github.com/BTCDecoded/blvm-consensus/commit/277ed06b6f9a61c53ae02382f31aba0008d3a292))
- Fix release notes: use publish step exists output when version already exists ([0b830790477c](https://github.com/BTCDecoded/blvm-consensus/commit/0b830790477c84e8fc97edfaf6a4a3a25d1a8731))
- Fix docs job: restore target cache and clean dep info files ([c91d3ab2d3a7](https://github.com/BTCDecoded/blvm-consensus/commit/c91d3ab2d3a7db4cdecf9058be74d0152a30dd10))
- Bump version to 0.1.5 for release [skip ci] ([c8788e5d48a7](https://github.com/BTCDecoded/blvm-consensus/commit/c8788e5d48a77ac9806190fbf8523b54d230d85a))

## [v0.1.6-unverified] - 2025-11-24

### Reconstructed

- Fix version auto-increment to check crates.io and find available version ([2d5b7428c7b9](https://github.com/BTCDecoded/blvm-consensus/commit/2d5b7428c7b9e5e3f863ac23b90de11591af682f))
- Remove redundant release.yml workflow ([2405a0948557](https://github.com/BTCDecoded/blvm-consensus/commit/2405a094855797a2ff1ea3715b8ae5744d0b06b6))
- Optimize test execution: run tests once with coverage ([209ec0aadda9](https://github.com/BTCDecoded/blvm-consensus/commit/209ec0aadda9b79cc155ea5b0d8981ba63f299d3))
- Fix Kani proof compilation errors ([96f6781138ae](https://github.com/BTCDecoded/blvm-consensus/commit/96f6781138ae572cd9bf5d767566e5c8dc6e31fb))
- Fix Kani proof compilation: use helper functions instead of kani::any for complex types ([a129a7d839c3](https://github.com/BTCDecoded/blvm-consensus/commit/a129a7d839c3e559206f40692196ffbf19747e37))
- Fix remaining Kani compilation errors ([2194c47785bb](https://github.com/BTCDecoded/blvm-consensus/commit/2194c47785bbae8d40e0aa0f6afefb3eebd01e44))
- Fix Kani proof compilation errors and format code ([97e1ecfdf103](https://github.com/BTCDecoded/blvm-consensus/commit/97e1ecfdf10313dd666dfb48c3bff3bae14e75ee))
- Bump version to 0.1.6 for release [skip ci] ([7c1f528086e1](https://github.com/BTCDecoded/blvm-consensus/commit/7c1f528086e10278e96a16431c854590883612ea))

## [v0.1.8] - 2026-04-14

### Reconstructed

- Fix clippy to exclude tests (standard practice) ([128d6b5dc99a](https://github.com/BTCDecoded/blvm-consensus/commit/128d6b5dc99acddf33024e1b9be0dcd14ef39c09))
- Implement undo log pattern and add Kani proofs ([c057fc3980b1](https://github.com/BTCDecoded/blvm-consensus/commit/c057fc3980b1ec99f676c762013dbdde51b8b087))
- Add comprehensive configuration system with Bitcoin Core parity and Commons-specific options ([bef33e8e315e](https://github.com/BTCDecoded/blvm-consensus/commit/bef33e8e315e52cddc0600cda071cfd679e2126a))
- Update coverage workflow to manual-only ([11f3428c91f4](https://github.com/BTCDecoded/blvm-consensus/commit/11f3428c91f4fd22938a2aaab3d83f34be99be4d))
- Format code and update dependencies ([a31c8d0ec7a9](https://github.com/BTCDecoded/blvm-consensus/commit/a31c8d0ec7a990510f2a30adda51cf51cd095e52))
- docs: remove working documents and improve timelessness ([389f19aa4258](https://github.com/BTCDecoded/blvm-consensus/commit/389f19aa42582763daf191453b645811a1ae1912))
- Add BIP Implementation Status section to README ([461beea7c9ba](https://github.com/BTCDecoded/blvm-consensus/commit/461beea7c9ba7e76a3b05a26e64c5af530ac635b))
- Add comprehensive test coverage for config, optimizations, and crypto modules ([6c501f91b229](https://github.com/BTCDecoded/blvm-consensus/commit/6c501f91b22962473d1feb69d8e5088063f69229))
- Add block header validation and BIP activation height verification tests ([6f70e1a4c97d](https://github.com/BTCDecoded/blvm-consensus/commit/6f70e1a4c97dc62a18e4afb780e44c509ac123b8))
- Fix intermittent test failures and update documentation ([43520dbda45c](https://github.com/BTCDecoded/blvm-consensus/commit/43520dbda45c8c51066f7b687eb7707e344d1bd8))
- docs: apply documentation standards - imperative mood, timeless language ([a5e26a7e447a](https://github.com/BTCDecoded/blvm-consensus/commit/a5e26a7e447a1c8415e27147e6892edbab2a0afa))
- docs: remove archive directory ([d9c6ae685dd5](https://github.com/BTCDecoded/blvm-consensus/commit/d9c6ae685dd55a37f5d4b62b2fed8a7092f4c459))
- docs: add dependency version pinning strategy to SECURITY.md ([2796d29a9090](https://github.com/BTCDecoded/blvm-consensus/commit/2796d29a9090fa26dbe916ee812666524e0aa8ba))
- perf: Add transaction hash caching and production optimizations ([cfc10ce594d0](https://github.com/BTCDecoded/blvm-consensus/commit/cfc10ce594d0ac58051c4cf777f541cdc01455b2))
- feat: Add memory prefetching optimization and enhance documentation ([ad211f790a1a](https://github.com/BTCDecoded/blvm-consensus/commit/ad211f790a1a6971cc024a6b22198adfb3b37a62))
- refactor: Rename from bllvm-consensus to blvm-consensus ([dac810fb6d0d](https://github.com/BTCDecoded/blvm-consensus/commit/dac810fb6d0d9fed62dccdbe3ddcc1144abc5572))
- docs: consolidate CONTRIBUTING.md, link to blvm-docs ([e2d956e391d0](https://github.com/BTCDecoded/blvm-consensus/commit/e2d956e391d031b697c93c7601350e5d8b1243f6))
- feat(spam-filtering): make spam filter always available, remove utxo-commitments feature dependency ([af2b6263e9c7](https://github.com/BTCDecoded/blvm-consensus/commit/af2b6263e9c7bf8ff75fabbf0d6522a574800dfa))
- feat(ci): implement strong tier for critical consensus proofs ([1f4a7c05b0d9](https://github.com/BTCDecoded/blvm-consensus/commit/1f4a7c05b0d9609e74615aa0d5bcf94599706ffc))
- feat(ci): Move medium/slow Kani proofs to AWS spot runners ([108eabe47410](https://github.com/BTCDecoded/blvm-consensus/commit/108eabe474105b8351d6218a1809f059cb8e5dec))
- refactor(ci): Remove coverage from default CI workflow ([da121a390c79](https://github.com/BTCDecoded/blvm-consensus/commit/da121a390c7911faea3d8328c5c359650b328f5a))
- fix(block): remove invalid attributes and add assertions ([83a8971a68dc](https://github.com/BTCDecoded/blvm-consensus/commit/83a8971a68dca69774fb3cfe3987520d73236a68))
- refactor: remove useless code and make is_standard_script useful ([a2cfb9475f92](https://github.com/BTCDecoded/blvm-consensus/commit/a2cfb9475f928118f4d06c922c648661f96eb269))
- feat: Major consensus improvements and test coverage expansion ([4f51e4043396](https://github.com/BTCDecoded/blvm-consensus/commit/4f51e404339698c809f8ce63856dca4ff024d8e1))
- Fix property test failures and improve validation error handling ([5eb52fd3728c](https://github.com/BTCDecoded/blvm-consensus/commit/5eb52fd3728c136ec22739e69d92e002d64db6a5))
- fix: Pass AMI ID through job output instead of using secrets in with section ([d28820484495](https://github.com/BTCDecoded/blvm-consensus/commit/d28820484495fccc103c30697e72ab64ad79bd58))
- Fix clippy warnings: update renamed lints and format strings ([eda9350bb952](https://github.com/BTCDecoded/blvm-consensus/commit/eda9350bb9524d535c50cdf96c8842b7a09aabf3))
- Fix test compilation errors: add missing sigversion parameter ([4e0e583168e0](https://github.com/BTCDecoded/blvm-consensus/commit/4e0e583168e0e84e0311838a208ae02e4c307286))
- Fix CI: remove --locked flag and fix formatting ([b2eeb677d77b](https://github.com/BTCDecoded/blvm-consensus/commit/b2eeb677d77b79d2a4b377df01599bd58734cac3))
- Fix compilation errors: add missing parameters and fix return types ([e3b5893766e3](https://github.com/BTCDecoded/blvm-consensus/commit/e3b5893766e32b26b4256e56e9bfb353e49213c1))
- Fix test imports and remove unused SigVersion import ([fdaf745f7982](https://github.com/BTCDecoded/blvm-consensus/commit/fdaf745f7982cf3ffd76ffb12d747b8d6153cc3f))
- Fix borrow checker error in optimizations test ([dbd542a48f61](https://github.com/BTCDecoded/blvm-consensus/commit/dbd542a48f61bfcd3c3066bcfce1a99450db039b))
- Fix two test failures ([cab6a9a243d3](https://github.com/BTCDecoded/blvm-consensus/commit/cab6a9a243d3be9b43d4fe850a9077433bcc96df))
- Fix formatting in reorganization test ([a8159c31ad71](https://github.com/BTCDecoded/blvm-consensus/commit/a8159c31ad71efdbec844a5be8d1318a2f84ff84))
- Fix coinbase_maturity test: provide witnesses for all transactions ([de3e1f8675af](https://github.com/BTCDecoded/blvm-consensus/commit/de3e1f8675af803258f2d3647be8a50dc909c8ab))
- Fix fee_calculation_verification test: use valid UTXO values ([fb6ac466bc20](https://github.com/BTCDecoded/blvm-consensus/commit/fb6ac466bc208d4cca17e4a2cd2fa6fe8463c263))
- Fix merkle root calculation determinism in parallel processing ([c7555fe52b40](https://github.com/BTCDecoded/blvm-consensus/commit/c7555fe52b40c73cc5900e6b81a207fe5a4d4331))
- Fix transaction validation: check before assert for MAX_MONEY ([f7964d53fc0d](https://github.com/BTCDecoded/blvm-consensus/commit/f7964d53fc0d792645abd72c1ab98973f6577801))
- Add timeout to strong tier Kani proofs step ([46cb98bcec53](https://github.com/BTCDecoded/blvm-consensus/commit/46cb98bcec53d5e1887937b3fbb5dc2d73e02bbb))
- Revert "Add timeout to strong tier Kani proofs step" ([33d6b5b07ff1](https://github.com/BTCDecoded/blvm-consensus/commit/33d6b5b07ff136e337dbffdab2989b42e589e089))
- Increase Kani parallelism from 2 to 3 jobs for strong tier proofs ([80671cde6dd8](https://github.com/BTCDecoded/blvm-consensus/commit/80671cde6dd807317fce84a17f8d94a2f78fd55c))
- Reduce strong tier to 10 minimum critical proofs ([807c7b7104f9](https://github.com/BTCDecoded/blvm-consensus/commit/807c7b7104f911f9175ae78cc9e334044712193c))
- Fix doctest failures: correct crate name and function signatures ([1654d6a66cc7](https://github.com/BTCDecoded/blvm-consensus/commit/1654d6a66cc75c443149861dbbb17f37f2a95acf))
- Fix remaining doctest failures in optimizations and utxo_commitments ([8a56fde485cf](https://github.com/BTCDecoded/blvm-consensus/commit/8a56fde485cfaa2abea75da6d38748af1178ec8e))
- Fix UTXO doctest failures: add missing fields and unwrap Results ([32659dbf1a37](https://github.com/BTCDecoded/blvm-consensus/commit/32659dbf1a370cdb08687563b38f82c6fdbcb7e7))
- Fix consensus engine purity and reorganization logic ([6ff5afa30faa](https://github.com/BTCDecoded/blvm-consensus/commit/6ff5afa30faaa54f162a280faf387ed0f6565bad))
- Remove historical documentation summaries ([b88ddbabcff2](https://github.com/BTCDecoded/blvm-consensus/commit/b88ddbabcff218b887b8e89afc4763a09be7908a))
- feat(consensus): improve BIP validation and fix intra-block transaction dependencies ([88796e8911f7](https://github.com/BTCDecoded/blvm-consensus/commit/88796e8911f73e290c7f31476adbd1131b54b040))
- Fix 16 consensus bugs achieving complete Bitcoin Core compatibility ([26933d02c6d4](https://github.com/BTCDecoded/blvm-consensus/commit/26933d02c6d4fbf876896311e952a037d8d99a32))
- Add regression tests for 16 consensus bug fixes ([c71b7f646eb2](https://github.com/BTCDecoded/blvm-consensus/commit/c71b7f646eb2d7da1fb792ed7ddede84f273704e))
- feat(utxo-commitments): Add UTXO Merkle proof verification ([91970492a97f](https://github.com/BTCDecoded/blvm-consensus/commit/91970492a97f156aa87721199dffa02fe76b2b5a))
- Add full transaction validation to UTXO commitments sync ([c877913a7c41](https://github.com/BTCDecoded/blvm-consensus/commit/c877913a7c41966bc1751b36a43b24f16fe24ddf))
- refactor: remove kani, add spec_locked annotations ([d9c0af382ed2](https://github.com/BTCDecoded/blvm-consensus/commit/d9c0af382ed2cf19fa7064239eb0cca216277474))
- docs: fix README naming inconsistencies ([a0a15a49de48](https://github.com/BTCDecoded/blvm-consensus/commit/a0a15a49de4854778b5d2f2d8e947873ad283631))
- feat(consensus): expand property testing coverage 5x with Orange Paper validation ([f96606d3707f](https://github.com/BTCDecoded/blvm-consensus/commit/f96606d3707f54acdb7f654c2011fc24fe475dd1))
- fix(consensus): fix UTXO validation and optimize block validation ([a3b0f33863a5](https://github.com/BTCDecoded/blvm-consensus/commit/a3b0f33863a5d1c73458dc0b1c089efde611a60b))
- perf(block): optimize witness flattening with flat_map ([a049adf31a35](https://github.com/BTCDecoded/blvm-consensus/commit/a049adf31a353b9e3a0c3e1f1173aa5b570cba83))
- feat(spam-filter): enhance spam detection with Taproot support and improved accuracy ([4f72bbd5e8c0](https://github.com/BTCDecoded/blvm-consensus/commit/4f72bbd5e8c0d494562d6694608c29d7e663936e))
- feat(ctv-csfs): implement BIP-119 CTV and BIP-348 CSFS opcodes ([2b9888bffb97](https://github.com/BTCDecoded/blvm-consensus/commit/2b9888bffb971231d9d84cde592bdec94155655a))
- refactor(consensus): replace opcode hex codes with named constants ([e39ec611834d](https://github.com/BTCDecoded/blvm-consensus/commit/e39ec611834d6cbd2b5b8e07875a59c53bf64463))
- docs(bitcoin_hashes): add security comments for exact version pinning ([91a358739e8a](https://github.com/BTCDecoded/blvm-consensus/commit/91a358739e8a9ff623570b791d07c1c6b155be8a))
- feat: implement ECDSA batch verification with block-level batching ([870b1663eedc](https://github.com/BTCDecoded/blvm-consensus/commit/870b1663eedc5ec0037da1402997691a6d983cef))
- feat: add comprehensive performance optimizations and profiling ([468631ea46f9](https://github.com/BTCDecoded/blvm-consensus/commit/468631ea46f9aa22115ca9d7b3194d542d8f9956))
- fix: smallvec macros, PERF_CLIFF, UTXO proof wire serialization, bllvm typos ([1ad61e54561b](https://github.com/BTCDecoded/blvm-consensus/commit/1ad61e54561bee02d317b67e3808456eb6795287))
- feat: IBD hardware tuning module, chunk_threshold for ECDSA/Schnorr batching ([57865a90bae9](https://github.com/BTCDecoded/blvm-consensus/commit/57865a90bae97c8f71f252630eef7713d52d32be))
- perf: IBD optimizations — BIP30 O(1), precomputed tx_ids, script fast paths, chunk tuning ([04d676618cbe](https://github.com/BTCDecoded/blvm-consensus/commit/04d676618cbe74bcaac506af69b9b4a35116528c))
- fix: IBD build fixes + script/block/checkqueue optimizations ([f629cbc1024c](https://github.com/BTCDecoded/blvm-consensus/commit/f629cbc1024c0fb4823e3a3c7ff8681585ddd2f0))
- refactor: secp256k1 fork removal, blvm-secp256k1 default, k256 removal ([3008cab01370](https://github.com/BTCDecoded/blvm-consensus/commit/3008cab0137061d539f4598fafaa0d872cb4bca0))
- gitignore: ignore tests/test_data/**/*.bin ([19341ab30cd5](https://github.com/BTCDecoded/blvm-consensus/commit/19341ab30cd5ff6e3b91e34e3add921fda2727a5))
- refactor: remove Kani/BLLVM, consolidate benches and docs ([40eb34970ddc](https://github.com/BTCDecoded/blvm-consensus/commit/40eb34970ddcbbf79c27df853acc23bcc1122790))
- refactor(consensus): blvm-primitives as shared foundation; modular block and script; slimmer crate ([4c4588194278](https://github.com/BTCDecoded/blvm-consensus/commit/4c45881942781b2f8cacb0262539f5ee17412e65))
- feat(consensus): fork activations, connect path, IBD parity ([076f19857038](https://github.com/BTCDecoded/blvm-consensus/commit/076f19857038ad76741af84496279ed9dfdc5cc3))
- style: rustfmt; deps: crates.io blvm-primitives/muhash (>=0.1, <1) ([79b33905a4f3](https://github.com/BTCDecoded/blvm-consensus/commit/79b33905a4f34f344265d281af6ef2874c68f2ae))
- chore: CI cache keys from Cargo.toml; drop publish lockfile steps (libraries do not commit Cargo.lock) ([1c054e15aab9](https://github.com/BTCDecoded/blvm-consensus/commit/1c054e15aab9ef77ba30529f3ebe94dbed98a6a5))
- ci: BTCDecoded/rust-ci composites and install-rust-toolchain ([9284f4a68e7e](https://github.com/BTCDecoded/blvm-consensus/commit/9284f4a68e7e7a752d05814c6b1cd241936688f0))
- fix(consensus): Core parity for connect, assume-valid, merkle, and script flags ([111f79b3182e](https://github.com/BTCDecoded/blvm-consensus/commit/111f79b3182eec9fbfbdf439f5d27485a687e1aa))
- fix(ci): stabilize cargo-spec-lock build; attestations permission ([90498b214f8b](https://github.com/BTCDecoded/blvm-consensus/commit/90498b214f8b79bd76bf165cc0e0b04dc002ad89))
- ci: drop unverified releases; spec-lock required for every release ([b016d81a6ee1](https://github.com/BTCDecoded/blvm-consensus/commit/b016d81a6ee16acb9ef320f66245315a0a304d44))
- fix: drop blvm-protocol dev-dependency (layering + crates.io) ([d4c35f9382b9](https://github.com/BTCDecoded/blvm-consensus/commit/d4c35f9382b9cd959a1b171cb0bf7c38baaee22d))
- fix: property-tests proptest dep + CSFS early returns ([d142b87aa6bc](https://github.com/BTCDecoded/blvm-consensus/commit/d142b87aa6bc759e168b1ce7e2d0330a5be3f955))
- fix(test): spec_property_tests BlockHeader types match Integer/Natural ([c55fcd49db81](https://github.com/BTCDecoded/blvm-consensus/commit/c55fcd49db81787229d4ae1d810364e80669e240))
- fix(test): invalid PoW nBits must use out-of-range exponent ([7bee8ba4b0c1](https://github.com/BTCDecoded/blvm-consensus/commit/7bee8ba4b0c1af49d5f8de97ffb3b3779f24952f))
- fix(ci): spec-lock env strict mode, Clippy gates, and BIP141 weight test ([c836bb9097da](https://github.com/BTCDecoded/blvm-consensus/commit/c836bb9097da4cd23340606e6513c5d02e5e99f3))
- fix(test): align mine_block error_path test with infallible Result API ([3adca2a8d75b](https://github.com/BTCDecoded/blvm-consensus/commit/3adca2a8d75b2cc0f37ea3ecd3861725e0822e8e))
- fix: resolve clippy -D warnings ([8663bcbd0670](https://github.com/BTCDecoded/blvm-consensus/commit/8663bcbd06708c0a176f7ae741659ba2912b4750))
- fix(verify): spec-lock friendly tx id + weight base size ([6a4e125d89f8](https://github.com/BTCDecoded/blvm-consensus/commit/6a4e125d89f80f4919154a3436612c60d3f6bcd1))
- fix(ci): cargo-audit 0.22.1 (CVSS 4.0 DB); update doctests for API drift ([5074fa23666a](https://github.com/BTCDecoded/blvm-consensus/commit/5074fa23666af5b6287f3eb7c2682818ca48cd03))
- Bump version to 0.1.7 for release [skip ci] ([8d29716400a9](https://github.com/BTCDecoded/blvm-consensus/commit/8d29716400a9fec6ed444a0aa960b64c892f4ed6))
- chore: vendor Orange Paper + pin blvm-spec-lock >=0.1.3 ([b4b95b3eb834](https://github.com/BTCDecoded/blvm-consensus/commit/b4b95b3eb834a4c5ed0f92b83dd8532bd530dbd0))
- Bump version to 0.1.8 for release [skip ci] ([1b62c5756479](https://github.com/BTCDecoded/blvm-consensus/commit/1b62c57564799ceff1b2129a8c1e544d5334a84a))

## [v0.1.9] - 2026-04-21

### Reconstructed

- fix(fuzz): align consensus fuzz harnesses with production types and APIs ([a1952d8f6470](https://github.com/BTCDecoded/blvm-consensus/commit/a1952d8f6470814a371973f5e0ffee0fcb2c30ac))
- ci(verify): inline blvm-spec clone (setup-blvm-spec action missing on rust-ci) ([29fcedc42119](https://github.com/BTCDecoded/blvm-consensus/commit/29fcedc421199618d15e69ee43202dbbe774cb86))
- Revert "ci(verify): inline blvm-spec clone (setup-blvm-spec action missing on rust-ci)" ([5c5766085409](https://github.com/BTCDecoded/blvm-consensus/commit/5c57660854094467597cd12ce4820c6f11adb49f))
- fuzz: expand consensus harnesses and stop tracking corpus ([a7ab0e5f2561](https://github.com/BTCDecoded/blvm-consensus/commit/a7ab0e5f2561beddd7cf3dda9ed0df75dfda45cf))
- fix(consensus)!: validate_block clock; connect/header hardening; stub docs ([6e079f27ebaf](https://github.com/BTCDecoded/blvm-consensus/commit/6e079f27ebaf6afa740411e7b000175578c9ee37))
- docs: hide orange_paper_property_helpers from rustdoc ([e1718012f40c](https://github.com/BTCDecoded/blvm-consensus/commit/e1718012f40c15a2b556fcc19e83140257c40a70))
- refactor(consensus): config, IBD tests, CI, deps, and bench updates ([5d07f56b9ac0](https://github.com/BTCDecoded/blvm-consensus/commit/5d07f56b9ac02c5ab31eaac902837c4dd55f0a87))
- ci: use rust-ci actions for spec-lock and spec setup ([95f63c656731](https://github.com/BTCDecoded/blvm-consensus/commit/95f63c6567313136a4d78df6c3450b8caba71117))
- ci: spec-lock install, release smoke metadata, trim dead setup ([c4140e9f4bc0](https://github.com/BTCDecoded/blvm-consensus/commit/c4140e9f4bc04ec26c5cf2bfb3448ce85c7b3466))
- ci(fuzz): shard consensus fuzz, one build per shard job ([f67451667ef0](https://github.com/BTCDecoded/blvm-consensus/commit/f67451667ef0a0ee4872aa400111fba3d42107c5))
- ci(fuzz): shard consensus fuzz, one build + artifact shards ([e717a4e7c652](https://github.com/BTCDecoded/blvm-consensus/commit/e717a4e7c65214514a6933ff3c096a51476d0a00))
- Bump version to 0.1.9 for release [skip ci] ([21712c1889b8](https://github.com/BTCDecoded/blvm-consensus/commit/21712c1889b8e659389a94d17559c31a594df671))

## [v0.1.10] - 2026-04-21

### Reconstructed

- Add comprehensive fuzzer for transaction sighash computation ([a64fbaa89bcb](https://github.com/BTCDecoded/blvm-consensus/commit/a64fbaa89bcb2aedff4c5caf6343e953ea640cc2))
- add sigop_validation target and corpus seeds ([0561abbafcdf](https://github.com/BTCDecoded/blvm-consensus/commit/0561abbafcdf4bd783de10fce801573bd3ad61ce))
- fuzz: add sequence_locks_validation target with invariant checks and corpus seeds ([154f2f13afc3](https://github.com/BTCDecoded/blvm-consensus/commit/154f2f13afc3b87bda64253fdf7a66704f335b37))
- add witness_validation target and corpus seeds ([dd45a083bff5](https://github.com/BTCDecoded/blvm-consensus/commit/dd45a083bff533eb745846a043f35e6aef769bb0))
- Corpus seed placement adjustment ([ac26d69bb873](https://github.com/BTCDecoded/blvm-consensus/commit/ac26d69bb873006c8679023c2d4f896512fe2e29))
- update to blvm_consensus ([a67a341ac2f8](https://github.com/BTCDecoded/blvm-consensus/commit/a67a341ac2f8814810327d33aa455063efddc12f))
- fix(consensus): Core parity for connect, assume-valid, merkle, and script flags ([b5042ca94506](https://github.com/BTCDecoded/blvm-consensus/commit/b5042ca945069fd27c78dd7f7df32cb85915363e))
- fix(ci): stabilize cargo-spec-lock build; attestations permission ([a4bed3ed9f0b](https://github.com/BTCDecoded/blvm-consensus/commit/a4bed3ed9f0b2dcd55c3247190dbd7b6fcbe85ba))
- ci: drop unverified releases; spec-lock required for every release ([7cc35d2ecdc3](https://github.com/BTCDecoded/blvm-consensus/commit/7cc35d2ecdc33d016d77e22ac73bc476dc352b4b))
- fix: drop blvm-protocol dev-dependency (layering + crates.io) ([0ee5811c8bbd](https://github.com/BTCDecoded/blvm-consensus/commit/0ee5811c8bbd2d00d6e224d85c8b1d6fedcf96b8))
- bip66_validation fuzz_target ([e47b2c47f59b](https://github.com/BTCDecoded/blvm-consensus/commit/e47b2c47f59b2ec53c5e6a2b9fc813785c3dbb6e))
- fixing false positive ([e8fdd0fe7c09](https://github.com/BTCDecoded/blvm-consensus/commit/e8fdd0fe7c0940c7374b0f7da926f59dc5cb676e))
- add missing closing parenthesis in degenerate_empty seed ([191ab8a5491e](https://github.com/BTCDecoded/blvm-consensus/commit/191ab8a5491e119da7d4309ba3aa48820da0165d))
- use full u32 flags to allow SCRIPT_VERIFY_WITNESS coverage ([b70eeebdb6f1](https://github.com/BTCDecoded/blvm-consensus/commit/b70eeebdb6f17be9d99aae91e51ec7023b2050d5))
- ci(fuzz): shard consensus fuzz, one build + artifact shards ([f9c2f882e9ed](https://github.com/BTCDecoded/blvm-consensus/commit/f9c2f882e9ede93df18f65de2677d16b3083cea4))
- fix(sequence_locks): reject prev_height overflow for i64 [skip_tests] [skip_verify] [skip_docs] ([b27c2378e07b](https://github.com/BTCDecoded/blvm-consensus/commit/b27c2378e07bf8ccfa1fe6d3a59afcb53b0aacf3))
- fix(fuzz): economic_validation i64::MIN + version_bits activation overflow [skip_tests] [skip_verify] [skip_docs] ([248dbac4484a](https://github.com/BTCDecoded/blvm-consensus/commit/248dbac4484a3ceb7243204a8884472319f3209b))
- Bump version to 0.1.10 for release [skip ci] ([e5d9013502d4](https://github.com/BTCDecoded/blvm-consensus/commit/e5d9013502d4ecd8ec2a509cd44b327f92026759))

## [v0.1.12] - 2026-05-07

### Reconstructed

- ci: gate build and release on fuzz-build + fuzz pair ([97b0986097c7](https://github.com/BTCDecoded/blvm-consensus/commit/97b0986097c75d3cb9fd97f06f3be197456318dd))
- docs(consensus): standalone-repo links; remove vendored blvm-spec tree [skip ci] ([f4f2ef3b0304](https://github.com/BTCDecoded/blvm-consensus/commit/f4f2ef3b0304f764fa3a8addb83ac399c91bed33))
- fuzz: path parent consensus, crates.io protocol; trim CI sibling checkouts [skip ci] ([63bb61c4ba8a](https://github.com/BTCDecoded/blvm-consensus/commit/63bb61c4ba8aecccb141696d46099f3a72bb7101))
- fuzz: document local patch vs CI strip for consensus fuzz [skip ci] ([8220a16271e0](https://github.com/BTCDecoded/blvm-consensus/commit/8220a16271e0b3c58a9964d289f8f20fbe3f0300))
- chore: prune test cruft and stray artifacts [skip ci] ([9bf8099db7cb](https://github.com/BTCDecoded/blvm-consensus/commit/9bf8099db7cbda45871556305ac1d068f211e2ad))
- docs(readme): remove verification badges from header [skip ci] ([ba4247bf7c68](https://github.com/BTCDecoded/blvm-consensus/commit/ba4247bf7c688794979493151124cba2c862aa18))
- docs(security): use security@thebitcoincommons.org for disclosures ([b3792fd92920](https://github.com/BTCDecoded/blvm-consensus/commit/b3792fd9292014f2b8509c5de7eafd529c3d017a))
- ci: fetch version list once from crates.io instead of per-iteration API calls [skip ci] ([f766a3f65278](https://github.com/BTCDecoded/blvm-consensus/commit/f766a3f65278b1d849e4ffc3c23e69b14754d49b))
- refactor(crypto): make secp256k1 (crates.io) optional via secp256k1-fallback feature ([12c36805d560](https://github.com/BTCDecoded/blvm-consensus/commit/12c36805d56098c8e73188c1d66293459ec625c0))
- refactor(crypto): migrate script/signature and bip348 off hardcoded secp256k1 dep ([60eb99bd303a](https://github.com/BTCDecoded/blvm-consensus/commit/60eb99bd303a5753f56e7c4c5de864f2b37cfe73))
- perf(ibd): eliminate rayon oversubscription across IBD hot paths ([0225a1ce1f27](https://github.com/BTCDecoded/blvm-consensus/commit/0225a1ce1f27e0cf6fcd66c7fa0e1bf887d241af))
- fix(crypto): gate secp256k1-fallback paths with not(blvm-secp256k1); fix test ? placement ([6dd8c3369c7a](https://github.com/BTCDecoded/blvm-consensus/commit/6dd8c3369c7a6969d56548a7d4c872d327b26bd7))
- style: cargo fmt ([a2d629135dfd](https://github.com/BTCDecoded/blvm-consensus/commit/a2d629135dfd9e15db01167d11e529441924f227))
- fix(test): update value offset for blvm-primitives 0.1.13 extended framing ([f7905a0d7289](https://github.com/BTCDecoded/blvm-consensus/commit/f7905a0d728922aa7ea49667d481085266f3d983))
- Bump version to 0.1.12 for release [skip ci] ([9c803d2afecf](https://github.com/BTCDecoded/blvm-consensus/commit/9c803d2afecf005ce83523daa7ede81e8ab732a2))

## [v0.1.13] - 2026-05-11

### Reconstructed

- docs: align header.rs and apply.rs with spec §5.3.1/5.3.2 renumbering ([b41320fde67e](https://github.com/BTCDecoded/blvm-consensus/commit/b41320fde67e8e23c26860e133a968606680467b))
- refine(spec-lock): validate_block_header -> spec_locked("5.3.1", "ValidBlockHeader") ([33348be06285](https://github.com/BTCDecoded/blvm-consensus/commit/33348be06285a43b7f75b667d9c01303211a07ec))
- docs: fix README dependency and MSRV notes vs Cargo.toml ([e47f1ee61086](https://github.com/BTCDecoded/blvm-consensus/commit/e47f1ee61086156258dd7e8a0f9e6d6ec8e09bca))
- chore(versioning): record spec_sha, spec_version, spec_content_sha256 in build metadata ([6d441e84f704](https://github.com/BTCDecoded/blvm-consensus/commit/6d441e84f704891de5991a57fa5ea8859ea59443))
- chore: trim unused and test-only dependencies ([118a4ca79fe4](https://github.com/BTCDecoded/blvm-consensus/commit/118a4ca79fe4df29372bcf1f057492b6590125b0))
- refine(spec-lock): point BIP54 helpers at PROTOCOL §5.4.9 ([fe45a43c6395](https://github.com/BTCDecoded/blvm-consensus/commit/fe45a43c6395bee0cb2a21c84e6052ddb2733369))
- consensus: add #[ensures] to BIP54 activation and coinbase-check functions ([38246d7cdd93](https://github.com/BTCDecoded/blvm-consensus/commit/38246d7cdd939b473a183237d366b62d7313b7f5))
- fix(docs): satisfy rustdoc under -D warnings (CI) ([652e75669d53](https://github.com/BTCDecoded/blvm-consensus/commit/652e75669d5331a603c3d80ecb491bd4566fcbe5))
- ci(verify): pin blvm-spec-lock 0.1.8 and raise Z3 timeout ([16a665413c75](https://github.com/BTCDecoded/blvm-consensus/commit/16a665413c7550e546571cc63b4b93efb2835808))
- ci(fuzz): add setup-blvm-spec to fuzz-build job ([cf0964bb15b9](https://github.com/BTCDecoded/blvm-consensus/commit/cf0964bb15b944baa4d7b2c1aa14685b1e6e31c0))
- ci: add setup-blvm-spec to every cargo-compilation job ([71a96dd2def4](https://github.com/BTCDecoded/blvm-consensus/commit/71a96dd2def461b50905bc5f67e1638531d378da))
- ci: extract consensus-checkout composite action ([54d1e8354725](https://github.com/BTCDecoded/blvm-consensus/commit/54d1e83547250249f0234b86f3b6630bab5f2886))
- ci: fix local action — checkout must precede local action reference ([07780de7ae7e](https://github.com/BTCDecoded/blvm-consensus/commit/07780de7ae7e1be030d41349bf9b177a95fb90e9))
- ci: force-refresh blvm-spec on persistent self-hosted runners ([d5648a4faec8](https://github.com/BTCDecoded/blvm-consensus/commit/d5648a4faec8bf173de2e66cc27685badf580570))
- ci(fuzz): add diagnostics and fix release-job spec refresh ([861af67ccf62](https://github.com/BTCDecoded/blvm-consensus/commit/861af67ccf624f5635ddb72a1ed59d7cf72d008c))
- Bump version to 0.1.13 for release [skip ci] ([e9387e063cce](https://github.com/BTCDecoded/blvm-consensus/commit/e9387e063cce931d4fed890e6af0f2e63525cd21))

## [v0.1.15] - 2026-05-12

### Reconstructed

- ci: trigger downstream build-chain after successful publish ([e5ac88698d3b](https://github.com/BTCDecoded/blvm-consensus/commit/e5ac88698d3bb3cd29b5766bd2908c883d2ff55f))
- ci(fuzz): replace 8-shard matrix with single parallel job using xargs -P$(nproc) [skip ci] ([2836cc903724](https://github.com/BTCDecoded/blvm-consensus/commit/2836cc9037244d928101d9b2426cc2d008847298))
- ci: merge fuzz-build into fuzz job ([1c77371dc7eb](https://github.com/BTCDecoded/blvm-consensus/commit/1c77371dc7ebca3ac050da59a97d6e91f9c7ffed))
- ci: fix secrets context in step if expression ([a417b9f19b92](https://github.com/BTCDecoded/blvm-consensus/commit/a417b9f19b9218af46e7f2fecafd217d38474596))
- fix: replace aarch64 _prefetch with no-op to fix MSRV (stabilised in 1.87, MSRV is 1.83) ([d4fbbe13166c](https://github.com/BTCDecoded/blvm-consensus/commit/d4fbbe13166ca5a62584151fb0d9fbe6b1e37408))
- fix: use inline asm for aarch64 prefetch instead of unstable _prefetch ([1de839ebcecf](https://github.com/BTCDecoded/blvm-consensus/commit/1de839ebcecfbd65962cebbec3bdf7d0a59d3bd6))
- fix: remove secrets context from if: condition in ci.yml ([138d2a433003](https://github.com/BTCDecoded/blvm-consensus/commit/138d2a4330032e12fcd488b01c9771dbaf7fd000))
- Bump version to 0.1.15 for release [skip ci] ([cc7396577a56](https://github.com/BTCDecoded/blvm-consensus/commit/cc7396577a5625bae27439769a20a1013ec6280f))

## [v0.1.16] - 2026-05-15

### Reconstructed

- refactor: extract sum_output_values and coinbase_or_empty_short_circuit helpers ([3c2c9388ebab](https://github.com/BTCDecoded/blvm-consensus/commit/3c2c9388ebab7b973780fa12b31c6d1b7c6c8d06))
- style: apply cargo fmt to transaction.rs ([9881b29c2750](https://github.com/BTCDecoded/blvm-consensus/commit/9881b29c275002a0bb558093e349336e392d4322))
- test(utxo): fix flaky overlay creation timing and unique outpoints ([2f18883dab43](https://github.com/BTCDecoded/blvm-consensus/commit/2f18883dab43b60d09feeb129c9b0064b3cfa108))
- Bump version to 0.1.16 for release [skip ci] ([3d7e3a7513ca](https://github.com/BTCDecoded/blvm-consensus/commit/3d7e3a7513ca1d98a3317b91db26bc4767fb7cdb))

## [v0.1.17] - 2026-05-15

### Reconstructed

- feat(spec-lock): align #[spec_locked] with PROTOCOL named contracts ([4a100cdc226b](https://github.com/BTCDecoded/blvm-consensus/commit/4a100cdc226b62a0889dc22ff8928fc1d838b23c))
- Bump version to 0.1.17 for release [skip ci] ([2009a8e5534d](https://github.com/BTCDecoded/blvm-consensus/commit/2009a8e5534d129826f928f09668307f56eeaf89))

## [v0.1.18] - 2026-05-17

### Reconstructed

- ci(release): derive next patch from max used version ([3a2fec1fb22a](https://github.com/BTCDecoded/blvm-consensus/commit/3a2fec1fb22a0f136603b0a504cfb2e944ec8337))
- docs: fix reference node RPC testing for blvm binary and Node API ([066e26733ea0](https://github.com/BTCDecoded/blvm-consensus/commit/066e26733ea0b6dec3549e6952858d821e23e375))
- Bump version to 0.1.18 for release [skip ci] ([86ba12ef9d02](https://github.com/BTCDecoded/blvm-consensus/commit/86ba12ef9d0208aecf8c9b973936d2fb3cd6ce83))

## [v0.1.19] - 2026-05-17

### Reconstructed

- fix(consensus): drop expect in taproot witness parse; tidy Cargo.toml comments ([0d7fa8f04881](https://github.com/BTCDecoded/blvm-consensus/commit/0d7fa8f04881b6359b5cf3e8aadf03cd13863216))
- ci: scope runner cargo cache under /tmp/runner-cache/<repository> ([ed8a1f7ddd1a](https://github.com/BTCDecoded/blvm-consensus/commit/ed8a1f7ddd1a31aa2f0294393c9fd81f8ae9d241))
- Bump version to 0.1.19 for release [skip ci] ([71af13e7690b](https://github.com/BTCDecoded/blvm-consensus/commit/71af13e7690bdc8abfa584337934fabe8e53f9d9))

## [v0.1.20] - 2026-05-17

### Reconstructed

- docs(ci): miri notes and workflow README updates ([929fcd781735](https://github.com/BTCDecoded/blvm-consensus/commit/929fcd781735fa59a87770d8762a7387a6406306))
- Bump version to 0.1.20 for release [skip ci] ([9bc7aa966a09](https://github.com/BTCDecoded/blvm-consensus/commit/9bc7aa966a09da0b982a09c482fc6c040bb6baf9))

## [v0.1.21] - 2026-05-18

### Reconstructed

- fix(consensus): make validate_witness_commitment Z3-translatable for spec-lock ([c234e7034c14](https://github.com/BTCDecoded/blvm-consensus/commit/c234e7034c14d15eb7b76f13c104a654425a1220))
- style: rustfmt validate_witness_commitment helper line ([27fc38ed1390](https://github.com/BTCDecoded/blvm-consensus/commit/27fc38ed1390c75b9333bb72106b91f5c3b70587))
- Bump version to 0.1.21 for release [skip ci] ([1b51871800c5](https://github.com/BTCDecoded/blvm-consensus/commit/1b51871800c524127cda90dd212543b3b30d8786))

## [v0.1.22] - 2026-05-27

### Reconstructed

- feat(ci): publish-dev job and develop-chain for crates.io pre-releases ([0600ad4b9edf](https://github.com/BTCDecoded/blvm-consensus/commit/0600ad4b9edfb861908401a5bf7affc450238c5e))
- fix(consensus): audit hardening, mempool policy, and test suites ([1c397de64896](https://github.com/BTCDecoded/blvm-consensus/commit/1c397de648969e8a91e32b1588cf5aeab4bbd922))
- test(witness): use valid BIP141 witness program lengths in extract tests ([da0f8e58d6ab](https://github.com/BTCDecoded/blvm-consensus/commit/da0f8e58d6ab327407569bf2e7a612a1c7297287))
- fix(mempool): reject disabled opcodes in is_standard_script ([6a2dea074b99](https://github.com/BTCDecoded/blvm-consensus/commit/6a2dea074b99cd04796cc81c41d818c548b76950))
- test(script): align stack size limit test with Core post-opcode check ([e2c6ca61799f](https://github.com/BTCDecoded/blvm-consensus/commit/e2c6ca61799fee6a2169db8bfd9837339d695980))
- fix(ci): repair fmt, proptest, fuzz, and taproot parity call sites ([ee6f462d9499](https://github.com/BTCDecoded/blvm-consensus/commit/ee6f462d9499194e2533a8190ed853f49bac79af))
- fix(spec-lock): remove F_SpecLockWitness formula anchor ([b662e4715c59](https://github.com/BTCDecoded/blvm-consensus/commit/b662e4715c590e2dd0d0944cf45a68f6e318277e))
- Bump version to 0.1.22 for release [skip ci] ([386621240f48](https://github.com/BTCDecoded/blvm-consensus/commit/386621240f48e4e43af50cd34db4b9e791704be0))

## [v0.1.23] - 2026-05-27

### Reconstructed

- Bump version to 0.1.23 for release [skip ci] ([2a77a3ff2061](https://github.com/BTCDecoded/blvm-consensus/commit/2a77a3ff2061e50401bece27df42aeded32db9d1))

## [v0.1.24] - 2026-05-27

### Reconstructed

- fix(spec-lock): remove F_SpecLockWitness formula anchor ([fe0402fbea26](https://github.com/BTCDecoded/blvm-consensus/commit/fe0402fbea2658eccf013cb60bd704ff0774441f))
- ci: bump GitHub Actions to Node.js 24 compatible versions [no ci] ([df954dddeb01](https://github.com/BTCDecoded/blvm-consensus/commit/df954dddeb011a803f2c03cbb64262eca5e84f2b))
- fix(consensus): audit hardening, script flags, and test suites ([2756ef78e95c](https://github.com/BTCDecoded/blvm-consensus/commit/2756ef78e95c0b3e34422d3df374d888d0736e2e))
- merge(develop): audit hardening, script flags, and BIP54 network helpers ([96c933c513cd](https://github.com/BTCDecoded/blvm-consensus/commit/96c933c513cded243ff90d55af1c1bc56703a67d))
- Bump version to 0.1.24 for release [skip ci] ([1a3f118d9a03](https://github.com/BTCDecoded/blvm-consensus/commit/1a3f118d9a03fedc8ed4b8f16e802790dbed633a))

## [v0.1.25] - 2026-05-28

### Reconstructed

- fix(consensus): audit hardening — sighash bounds, taproot flags, block_height, test suite ([7f8ed93523cb](https://github.com/BTCDecoded/blvm-consensus/commit/7f8ed93523cb037b30c2565ffafb613e87f9ebc8))
- fix(tests): remove pre-existing useless_conversion clippy warnings ([31d3894c0902](https://github.com/BTCDecoded/blvm-consensus/commit/31d3894c09028a6d82b90b2f7aba58536e75dbf5))
- fix(deps): upgrade lru from 0.12 to 0.16 to resolve RUSTSEC-2026-0002 ([7f6b1516fa42](https://github.com/BTCDecoded/blvm-consensus/commit/7f6b1516fa427e7e7bdbf1494798c7c5bf769568))
- fix(ci): harden blvm-spec-lock cargo install against missing toolchain ([b0bfd4147367](https://github.com/BTCDecoded/blvm-consensus/commit/b0bfd41473678f8df94ebab7bad1a22a8ed4bdf6))
- chore(scripts): add spec-lock-verify.sh for local CI parity ([6865d441b29c](https://github.com/BTCDecoded/blvm-consensus/commit/6865d441b29c70efa1b33dc74904fab3ed0f2f5a))
- Bump version to 0.1.25 for release [skip ci] ([6cc63fdb6d45](https://github.com/BTCDecoded/blvm-consensus/commit/6cc63fdb6d45177bffd96556802f34a2b06f43ff))

## [v0.1.26] - 2026-06-04

### Reconstructed

- feat(consensus): spec-lock verification closure — witnesses, annotations, CI gates ([2b7379ee0355](https://github.com/BTCDecoded/blvm-consensus/commit/2b7379ee0355b94ec945fd87e03d1ea54be8f66d))
- fix(consensus): thread chainwork into connect_block_ibd for assume-valid gate ([d2a760838e33](https://github.com/BTCDecoded/blvm-consensus/commit/d2a760838e337a502374024d3bb7fa30a512ae30))
- perf(ibd): skip utxo_set mutation in merge_overlay_changes_to_cache on IBD path ([815a34d16c55](https://github.com/BTCDecoded/blvm-consensus/commit/815a34d16c557797c6402526f233013710d22a83))
- perf(ibd): hoist block_hash computation to eliminate duplicate serialize+hash256 ([534e206f9f5a](https://github.com/BTCDecoded/blvm-consensus/commit/534e206f9f5a9c155cb99c18a4e1a3952dcf785c))
- perf(ibd): skip script flags lookup on assume-valid connect path ([0310550e93c6](https://github.com/BTCDecoded/blvm-consensus/commit/0310550e93c64fff4a1236c5415021c069b34cd7))
- Bump version to 0.1.26 for release [skip ci] ([ad818ef18524](https://github.com/BTCDecoded/blvm-consensus/commit/ad818ef18524bb9f36a582cc7182c1e25213fb05))

## [v0.1.27] - 2026-06-06

### Reconstructed

- ci: align parallel gate column with blvm-node ([f0e300262123](https://github.com/BTCDecoded/blvm-consensus/commit/f0e300262123bbec56a09505edb4b9520b776e68))
- test: raise line coverage toward Phase B with suite expansion and script fixes ([9c445a880b8f](https://github.com/BTCDecoded/blvm-consensus/commit/9c445a880b8fc4ef8ad0921c30d278fe77191f55))
- docs: align SPEC_LOCK_DEPENDENCY with timeless spec wording ([6eb28b657106](https://github.com/BTCDecoded/blvm-consensus/commit/6eb28b6571063bb91515a84694b59553f670a5c7))
- ci: fix invalid job if expressions in workflow ([75651669f8ea](https://github.com/BTCDecoded/blvm-consensus/commit/75651669f8ea51cfea6410b14304b106348502d8))
- Bump version to 0.1.27 for release [skip ci] ([2da9d848337c](https://github.com/BTCDecoded/blvm-consensus/commit/2da9d848337ce5da00b9f46e9c2ae2bd6de81b1d))

## [v0.1.28] - 2026-06-07

### Reconstructed

- test: close Phase B coverage gate at 60.12% ([9b285ce7046b](https://github.com/BTCDecoded/blvm-consensus/commit/9b285ce7046b8d4e133afc284dc0e3592e7992c9))
- test: add proptest regressions for consensus property tests ([19d305ced2ae](https://github.com/BTCDecoded/blvm-consensus/commit/19d305ced2ae405b5bb5764df63095663ac471e7))
- Bump version to 0.1.28 for release [skip ci] ([e6a09a942b12](https://github.com/BTCDecoded/blvm-consensus/commit/e6a09a942b123efdbf3d2cf45f4b0ca18e39ce53))

## [v0.1.29] - 2026-06-15

### Reconstructed

- fix(consensus): script, sighash, and taproot parity with Bitcoin Core ([f50e819f4204](https://github.com/BTCDecoded/blvm-consensus/commit/f50e819f42042567961357277a3861509b1a6fb7))
- ci(fuzz): install cargo-fuzz with nightly toolchain ([9b24d11f88e2](https://github.com/BTCDecoded/blvm-consensus/commit/9b24d11f88e285d2ab8e8adaddf8468df297f5d0))
- ci(fuzz): pin cargo-fuzz 0.12.0 for rust-toolchain 1.88 ([e366019c253b](https://github.com/BTCDecoded/blvm-consensus/commit/e366019c253b43efcbb8d385096401714a6371bb))
- fix(fuzz): patch blvm-protocol to local checkout for nightly builds ([e8e373dbed89](https://github.com/BTCDecoded/blvm-consensus/commit/e8e373dbed8940d60d6a42eba847f2a6d7c6238f))
- fix(fuzz): resolve blvm-protocol spec path via SPEC_LOCK_SPEC_PATH ([dabc8426cc84](https://github.com/BTCDecoded/blvm-consensus/commit/dabc8426cc8437c12aa7d603679e3acc413d2ce4))
- revert(ci): restore original cargo-fuzz install (0.13.1 cached on runner) ([f8215d2fde30](https://github.com/BTCDecoded/blvm-consensus/commit/f8215d2fde3051f107bc684be3cd65c3887381ad))
- ci(fuzz): install cargo-fuzz with nightly toolchain ([048cadb7df56](https://github.com/BTCDecoded/blvm-consensus/commit/048cadb7df56df6fde43371a2998fe199502c6f9))
- fix(fuzz): pass annex_hash to compute_taproot_signature_hash ([8037162eb5f9](https://github.com/BTCDecoded/blvm-consensus/commit/8037162eb5f9ad9e93b20c4d287eadb1dcf21477))
- Bump version to 0.1.29 for release [skip ci] ([11098a8d7a79](https://github.com/BTCDecoded/blvm-consensus/commit/11098a8d7a79c6144b49adba686efef7f9bcecfe))

## [v0.1.30] - 2026-06-16

### Reconstructed

- chore: MSRV 1.85, edition 2024, pins, and remove stale CHANGELOG ([da611c287c12](https://github.com/BTCDecoded/blvm-consensus/commit/da611c287c12ae435b8608339bd8fb9c7be6fbe2))
- Bump version to 0.1.30 for release [skip ci] ([9d9b0dfef81f](https://github.com/BTCDecoded/blvm-consensus/commit/9d9b0dfef81fbb89129ab87e645ad63e1d7d02ee))

## [v0.1.32] - 2026-06-18

### Reconstructed

- fix(consensus): fork ancestor lookup, IBD connect undo (v0.1.31) ([5883511c9536](https://github.com/BTCDecoded/blvm-consensus/commit/5883511c9536c743f0f2a1768a794560bb42aa2a))
- test(consensus): align reorg suite with shared-prefix ancestor lookup ([662ad7de0150](https://github.com/BTCDecoded/blvm-consensus/commit/662ad7de0150473e599639d16fef537a689ffde2))
- Bump version to 0.1.32 for release [skip ci] ([220f4ab61b4b](https://github.com/BTCDecoded/blvm-consensus/commit/220f4ab61b4b423c06275293ca1e86ef1a9801b6))

## [v0.1.33] - 2026-06-18

### Reconstructed

- feat(consensus): §19 gap closure, Signet BIP325, and spec-lock bindings (v0.1.31) ([dfb99357e96b](https://github.com/BTCDecoded/blvm-consensus/commit/dfb99357e96b9cf95d490a056f5812ee34a4e7a2))
- fix(fuzz): drop [patch.crates-io]; path dep in [dependencies] is enough ([b7d8d91cd988](https://github.com/BTCDecoded/blvm-consensus/commit/b7d8d91cd9883ff2925a6b28ec496aa2b8d29e61))
- fix(fuzz): paths override keeps CI on in-tree blvm-consensus ([d55771668197](https://github.com/BTCDecoded/blvm-consensus/commit/d55771668197329de3724c2077d37ab3a28cabd8))
- Bump version to 0.1.33 for release [skip ci] ([2f3ec4abb144](https://github.com/BTCDecoded/blvm-consensus/commit/2f3ec4abb1442980f20059b6d7518bd2fe4520e7))

## [v0.1.34] - 2026-06-24

### Reconstructed

- ci(release): push tags with GITHUB_TOKEN and workflows permission ([2b202e2d6ad2](https://github.com/BTCDecoded/blvm-consensus/commit/2b202e2d6ad23473011d153407aee2509d873d9f))
- ci(release): create tags via GitHub Release API, not git push ([f5545b3dd696](https://github.com/BTCDecoded/blvm-consensus/commit/f5545b3dd696caa9b2382116176622c2cf83195c))
- Revert "ci(release): create tags via GitHub Release API, not git push" ([343589f2659f](https://github.com/BTCDecoded/blvm-consensus/commit/343589f2659fe31b999ecf7f83a32bd27006d772))
- Revert "ci(release): push tags with GITHUB_TOKEN and workflows permission" ([a54ced33262d](https://github.com/BTCDecoded/blvm-consensus/commit/a54ced33262dfc9057283341492742d880a143d8))
- ci(release): push release tags with REPO_ACCESS_TOKEN ([ca05ee335c47](https://github.com/BTCDecoded/blvm-consensus/commit/ca05ee335c47fe2917c2a8242e314aebe3d4b7f6))
- fix(consensus): script verification, U256 chainwork, and mempool correctness ([d028459f5213](https://github.com/BTCDecoded/blvm-consensus/commit/d028459f5213923b0c9bb7ca7d7c1edaa1c9c83e))
- fix(consensus): clippy dead_code and fuzz Network import ([1d78633e27dc](https://github.com/BTCDecoded/blvm-consensus/commit/1d78633e27dcacb2a7d7be4d897317fdc49f7eee))
- fix(consensus): align size boundary test with CheckTransaction rule ([9ff5a08522b6](https://github.com/BTCDecoded/blvm-consensus/commit/9ff5a08522b65f2f830f58625755f3aeff4614e5))
- fix(consensus): reject non-empty witness on non-witness script paths ([81585106a0c0](https://github.com/BTCDecoded/blvm-consensus/commit/81585106a0c01d48f88d2d1c8bdd9a6dafd7bed5))
- Bump version to 0.1.34 for release [skip ci] ([ee1cdf3697fc](https://github.com/BTCDecoded/blvm-consensus/commit/ee1cdf3697fc6df9d9fbba898b1dc14e40f610a3))

## [v0.1.35] - 2026-08-19

### Reconstructed

- peel: fail-closed apply/economic/mempool (S4) ([520a87bc2090](https://github.com/BTCDecoded/blvm-consensus/commit/520a87bc2090d3213760cfb32bce2d6fed46d599))
- dens-keep-gpu-secp: park consensus leftover (connect/script/reorg/ecdsa) ([aefe48cb944c](https://github.com/BTCDecoded/blvm-consensus/commit/aefe48cb944ce84875a47557fc515efae2717385))
- fix: reorg fail-closed, auto-GPU ECDSA enqueue, and clippy/fmt for CI. ([c6b1924d33ce](https://github.com/BTCDecoded/blvm-consensus/commit/c6b1924d33cebd45a6d5a624c07251c3f8b72da2))
- fix(ci): resolve blvm-secp256k1 from crates.io when patch section is stripped. ([c12558fcc366](https://github.com/BTCDecoded/blvm-consensus/commit/c12558fcc3663e63b6e4fd786cf366125f8a2fe6))
- fix(ci): ecdsa_collect test args, audit deps, and fuzz GPU opt-out. ([7ecbbfc3f258](https://github.com/BTCDecoded/blvm-consensus/commit/7ecbbfc3f2588f804aa395669be20b52d605b823))
- fix(test): use valid BIP141 coinbase witness in weight-limit test. ([5f8c37f5bfbd](https://github.com/BTCDecoded/blvm-consensus/commit/5f8c37f5bfbd7615ecdb7b107f50f3b3ccbe5e1a))
- fix(ci): pass ecdsa_collect in fuzz and correct 1-of-2 P2WSH fixture. ([54c82b432dfd](https://github.com/BTCDecoded/blvm-consensus/commit/54c82b432dfda7a4855e2221695f7a8f19fff17e))
- Bump version to 0.1.35 for release [skip ci] ([83f7b3ed7a74](https://github.com/BTCDecoded/blvm-consensus/commit/83f7b3ed7a74cdd2476a12ac0292e7fdb6e595d1))

## [v0.1.36] - 2026-09-18

### Reconstructed

- docs(consensus): integer subsidy comments; BIP113 even-n T[n/2] [skip ci] ([afaf04bcf1c9](https://github.com/BTCDecoded/blvm-consensus/commit/afaf04bcf1c99a7f2ec6b455ffbb57bbc79dc8c6))
- test: recode BIP68 CSV fixtures to bits 0-15 ([bf034a6386bd](https://github.com/BTCDecoded/blvm-consensus/commit/bf034a6386bd20db2eab52131671a62678e5bde6))
- test: recode sibling BIP68 CSV fixtures to bits 0-15 ([9a3cc5b3fa49](https://github.com/BTCDecoded/blvm-consensus/commit/9a3cc5b3fa49f853fa8cd13a40b0f7adbaa7a5c9))
- style: rustfmt spec_witnesses one-liners ([036974972e73](https://github.com/BTCDecoded/blvm-consensus/commit/036974972e730a15bdbc8969bb3d92982dfd39a0))
- style: rustfmt spec_witnesses one-liners ([b15786f1353d](https://github.com/BTCDecoded/blvm-consensus/commit/b15786f1353dec2a730dd8addd04bb9b5faca909))
- style: rustfmt bip_compliance_tests blank line ([4ea55b7054f6](https://github.com/BTCDecoded/blvm-consensus/commit/4ea55b7054f6ceab51c173e26d71c365f0e33b87))
- chore(clippy): allow intentional Z3 witness identity/eq ops ([36e0f025610c](https://github.com/BTCDecoded/blvm-consensus/commit/36e0f025610c37bfbad289b2e7f4f334402b4cc7))
- chore(clippy): allow intentional Z3 witness identity/eq ops ([457c2e03b12b](https://github.com/BTCDecoded/blvm-consensus/commit/457c2e03b12b4bb6cbce330206ff95f0d371f0e8))
- fix(consensus): restore total_supply #[axiom] bounds for Z3 ([252bfa706a0f](https://github.com/BTCDecoded/blvm-consensus/commit/252bfa706a0f3eadf9c10b53112131a6303bfd32))
- fix(consensus): restore total_supply #[axiom] bounds for Z3 ([54cebb774bb7](https://github.com/BTCDecoded/blvm-consensus/commit/54cebb774bb7658fdb4340b6d5c8d374ed746589))
- fix(consensus): return bool from validate_supply_limit for Z3 ([efcdc8283bbe](https://github.com/BTCDecoded/blvm-consensus/commit/efcdc8283bbe688b9109d776e4c43e04511f2d5d))
- fix(consensus): return bool from validate_supply_limit for Z3 ([9db8716f7761](https://github.com/BTCDecoded/blvm-consensus/commit/9db8716f776124af8b20e0ff1f96b34491c3e184))
- fix(consensus): make validate_supply_limit body Z3-translatable ([ea3aa77bffd4](https://github.com/BTCDecoded/blvm-consensus/commit/ea3aa77bffd4b13be72ae05636658e78987f12a7))
- fix(consensus): make validate_supply_limit body Z3-translatable ([2f8f2e9dc745](https://github.com/BTCDecoded/blvm-consensus/commit/2f8f2e9dc745148df9bba6cfd4f9aa6f8c2a17b2))
- ci: re-trigger pull_request checks after cancelled run ([905d6d14d467](https://github.com/BTCDecoded/blvm-consensus/commit/905d6d14d467641c418d00119dd48be9cee20387))
- ci: re-trigger pull_request checks after cancelled run ([fa9ccc925e18](https://github.com/BTCDecoded/blvm-consensus/commit/fa9ccc925e18a1f2d437f7ea05119e05846eef7f))
- Bump version to 0.1.36 for release [skip ci] ([36c85cdd9be6](https://github.com/BTCDecoded/blvm-consensus/commit/36c85cdd9be6b8b574335d74c3379416c2c5fb87))

## [v0.1.37] - 2026-09-18

### Reconstructed

- Fix incomplete-output fixture to truncate value, not empty-vin+flag ([882acceb5f89](https://github.com/BTCDecoded/blvm-consensus/commit/882acceb5f89110a5a650834b2f0adf696e43504))
- Bump version to 0.1.37 for release [skip ci] ([7872bb9d78bd](https://github.com/BTCDecoded/blvm-consensus/commit/7872bb9d78bd5a1efab9f2bf7d501108dfa773a6))

## [v0.1.38] - 2026-09-18

### Reconstructed

- Fix taproot invalid key aggregation fixture and un-ignore test ([c8591e2a5035](https://github.com/BTCDecoded/blvm-consensus/commit/c8591e2a5035d4ea3a0a8a0eb5e41cbda45e748e))
- Bump version to 0.1.38 for release [skip ci] ([ebe052de5398](https://github.com/BTCDecoded/blvm-consensus/commit/ebe052de53984c2b6d89eb41a22e1cf84f88757f))

## [v0.1.39] - 2026-09-21

### Reconstructed

- Fix mixed SegWit/Taproot block fixture and un-ignore test ([9d8bc9f22a1b](https://github.com/BTCDecoded/blvm-consensus/commit/9d8bc9f22a1bbf4ee25e0a0e9e78e1139c6fd8c0))
- Bump version to 0.1.39 for release [skip ci] ([0a6ee80e6184](https://github.com/BTCDecoded/blvm-consensus/commit/0a6ee80e6184b7f5ed3ba90eaf89dab0a9bf58b2))

## [v0.1.40] - 2026-09-21

### Reconstructed

- Fix BIP113 MTP CLTV validation fixture and un-ignore test ([ddec35d03031](https://github.com/BTCDecoded/blvm-consensus/commit/ddec35d030311ba07394c04593a2515b2b75d109))
- Bump version to 0.1.40 for release [skip ci] ([a61d965adb5e](https://github.com/BTCDecoded/blvm-consensus/commit/a61d965adb5e6dff3adf5b8fc98f69c27345fc22))

## [v0.1.41] - 2026-09-21

### Reconstructed

- Fix orphaned taproot_more_tests P2TR fixture and wire module ([a5c7bb8e4a70](https://github.com/BTCDecoded/blvm-consensus/commit/a5c7bb8e4a709460381ecdd2260ecb7b3ae50dd6))
- Bump version to 0.1.41 for release [skip ci] ([94e552b3f6b2](https://github.com/BTCDecoded/blvm-consensus/commit/94e552b3f6b24a1312a87ba15f1c2c0b1b8d7f80))

## [v0.1.42] - 2026-09-21

### Reconstructed

- Fix orphaned script_more_tests eval_script signature and wire module ([0a2779f093e2](https://github.com/BTCDecoded/blvm-consensus/commit/0a2779f093e2ba04664300f9cf8af0dfaafef1b7))
- Bump version to 0.1.42 for release [skip ci] ([c1c6a196265c](https://github.com/BTCDecoded/blvm-consensus/commit/c1c6a196265c6fb0fb56927398bb7fad56d2be89))

## [v0.1.43] - 2026-09-21

### Reconstructed

- Fix orphaned mempool_rbf_tests: wire module and live APIs (#19) ([f6554ff04e46](https://github.com/BTCDecoded/blvm-consensus/commit/f6554ff04e464795653b3adb449b75b25981f55f))
- Bump version to 0.1.43 for release [skip ci] ([99d76717b5db](https://github.com/BTCDecoded/blvm-consensus/commit/99d76717b5dbc504f3f9c4c50ac7d8457c83714a))

## [v0.1.44] - 2026-09-22

### Reconstructed

- fix(consensus): lock the BIP66 witness to the formula the paper still has ([3fa6c0ba0b62](https://github.com/BTCDecoded/blvm-consensus/commit/3fa6c0ba0b627b504df9cbd704cbc228aaee0ccc))
- Bump version to 0.1.44 for release [skip ci] ([7c2ecd1411d2](https://github.com/BTCDecoded/blvm-consensus/commit/7c2ecd1411d25656ac6a3027e8bb7697e8d8e5a9))

## [v0.1.45] - 2026-10-04

### Reconstructed

- test(consensus): witness the mutation-validated obligations ([9b157643042d](https://github.com/BTCDecoded/blvm-consensus/commit/9b157643042dd59b94151b3457fbf9a8e725b007))
- fix(consensus): reject CVE-2012-2459 mutations during IBD ([fd4c241e293d](https://github.com/BTCDecoded/blvm-consensus/commit/fd4c241e293da484d3b5f2681a5ce74b77f823c3))
- fix(mining): clone header out of Block in create_block_template ([055180eb63cb](https://github.com/BTCDecoded/blvm-consensus/commit/055180eb63cbc0d031e97f5d29d30448b8a8fc12))
- feat(mining): multi-output and declared-txid block templates ([eabd55dfe983](https://github.com/BTCDecoded/blvm-consensus/commit/eabd55dfe983922505cffb4f5abc4e2d7fdaa350))
- feat(mempool): UnexecIf rename, sigop-adjusted vsize, script templates ([ab9063de0760](https://github.com/BTCDecoded/blvm-consensus/commit/ab9063de07600e8d1f40717cb4e599f88d58d531))
- test(consensus): mainnet golden vectors and required Core fixtures ([0b4195883ccd](https://github.com/BTCDecoded/blvm-consensus/commit/0b4195883ccd25c31c65e972887b9b8ba01e10ea))
- fix(consensus): non-final txs at connect, BIP66 DER fixtures, i64 output sum ([7dfe496ee9a6](https://github.com/BTCDecoded/blvm-consensus/commit/7dfe496ee9a6c4140e31863cf2fffba2a6096d61))
- refactor(script): fold the tapscript checksig path and drop unused script profile counters ([c033f84d9bbb](https://github.com/BTCDecoded/blvm-consensus/commit/c033f84d9bbb8295ce07f9cc1b8d2c73aea11116))
- fix(script): reject disabled opcodes and oversized pushes in a dead branch ([f63df846923f](https://github.com/BTCDecoded/blvm-consensus/commit/f63df846923ff10be1633b5391c78d0bf8bb4ac5))
- fix(script): reject a one-byte zero CHECKMULTISIG dummy under NULLDUMMY ([7203f94b9ba2](https://github.com/BTCDecoded/blvm-consensus/commit/7203f94b9ba2c32bbfa78278ad9c841a270479ec))
- fix(script): keep MINIMALIF in a form spec-lock can translate ([c58431afc30c](https://github.com/BTCDecoded/blvm-consensus/commit/c58431afc30cc9fe045248ea6a390a770df381da))
- fix(consensus): clear clippy and the NULLDUMMY witness dummy ([a549ee67da14](https://github.com/BTCDecoded/blvm-consensus/commit/a549ee67da140a55b77bb537222019655b1e7972))
- Bump version to 0.1.45 for release [skip ci] ([6fc9cf6cea2b](https://github.com/BTCDecoded/blvm-consensus/commit/6fc9cf6cea2b84411bc246cd6ecd60b396f23d0a))

## [v0.1.46] - 2026-10-05

### Reconstructed

- fix(script): decode CLTV and CSV stack numbers with the sign bit ([95c74933ac56](https://github.com/BTCDecoded/blvm-consensus/commit/95c74933ac561f1d1201ab86392d5bed1fd343c6))
- fix(script): reject spends consensus already rejects ([f9b5e389a166](https://github.com/BTCDecoded/blvm-consensus/commit/f9b5e389a1663a79e99cde4b586f71d0cdc0d53e))
- fix(sigop): count a redeem after OP_1NEGATE or OP_RESERVED ([67c76590aad2](https://github.com/BTCDecoded/blvm-consensus/commit/67c76590aad2fcd14770973951ff5007aed26d92))
- fix(ci): satisfy rustfmt and the sigop push formula ([8e3a066a6d02](https://github.com/BTCDecoded/blvm-consensus/commit/8e3a066a6d02d13fc70e9e0a6477942f28661bde))
- fix(consensus): reject a spend before its relative lock elapses ([8cbd5092ce20](https://github.com/BTCDecoded/blvm-consensus/commit/8cbd5092ce2071e1aeddc9e1b23f48d6df2bcf02))
- fix(sigop): prove the push predicate instead of a universal bound ([36628ad9e000](https://github.com/BTCDecoded/blvm-consensus/commit/36628ad9e0004e039e0877e1d48aef030436422e))
- fix(ci): translate the CLTV upper-bound witness ([4a39d182384b](https://github.com/BTCDecoded/blvm-consensus/commit/4a39d182384b608517fc7b75d1e7b41ebe932397))
- fix(ci): keep the CLTV bound witness in comparisons ([18b36cb339aa](https://github.com/BTCDecoded/blvm-consensus/commit/18b36cb339aa177d9d99cfd14e8eb2746a06f35a))
- Bump version to 0.1.46 for release [skip ci] ([41aded968e3f](https://github.com/BTCDecoded/blvm-consensus/commit/41aded968e3f0c18c91da5780740c6996fe99e26))

## [v0.1.47] - 2026-10-05

### Reconstructed

- fix(consensus): reject blocks whose header, coinbase, or witness commitment is wrong ([9328efa2d912](https://github.com/BTCDecoded/blvm-consensus/commit/9328efa2d9125f442911eeb84759d630b8a17669))
- fix(consensus): enforce duplicate coinbases and real witness versions ([ee3047b918f6](https://github.com/BTCDecoded/blvm-consensus/commit/ee3047b918f6a9087f422a231f9c134ecc952abc))
- fix(ci): a witness commitment requires the coinbase nonce ([1e932d8ef26e](https://github.com/BTCDecoded/blvm-consensus/commit/1e932d8ef26e50c13257f75b63690bc2389512df))
- fix(ci): encode regtest coinbase heights and distinct fork coinbases ([b7b7550eeb0e](https://github.com/BTCDecoded/blvm-consensus/commit/b7b7550eeb0e5c358ebad93d69b79a09035d909e))
- Bump version to 0.1.47 for release [skip ci] ([2cca460de6b6](https://github.com/BTCDecoded/blvm-consensus/commit/2cca460de6b619c9ffd9236c1db986fa77340abe))

## [v0.1.48] - 2026-10-05

### Reconstructed

- fix(consensus): reject spends the script and block rules still accepted ([524417f0331c](https://github.com/BTCDecoded/blvm-consensus/commit/524417f0331ce7154c961a2ded7714546d725498))
- fix(test): a pair of max-money inputs is an invalid spend ([d7c15fcab66f](https://github.com/BTCDecoded/blvm-consensus/commit/d7c15fcab66f70ff8d5c4879e33555606212062e))
- fix(spec): prove the CHECKMULTISIG pubkey-count witness ([a7e55fdf7b35](https://github.com/BTCDecoded/blvm-consensus/commit/a7e55fdf7b35f101d668c33fc30d81941011a8e2))
- fix(test): a failed CHECKSIG pushes an empty vector ([414730c941c8](https://github.com/BTCDecoded/blvm-consensus/commit/414730c941c80010047e9e6b1e67287669c407cf))
- fix(spec): keep the pubkey-count witness in comparisons ([1aec0b7a1998](https://github.com/BTCDecoded/blvm-consensus/commit/1aec0b7a19989e91bba77cc537f327a4601a4005))
- Bump version to 0.1.48 for release [skip ci] ([16812b6b0034](https://github.com/BTCDecoded/blvm-consensus/commit/16812b6b0034902a737d0995e662e12701413cd5))

## [v0.1.49] - 2026-10-06

### Reconstructed

- fix(pow): require header bits to match the ancestor window ([2c807dc2a7a3](https://github.com/BTCDecoded/blvm-consensus/commit/2c807dc2a7a3fcc838f21363bb0acdb00d1c6d87))
- fix(script): reject a witness program whose payload is false ([76a4f05b2ad6](https://github.com/BTCDecoded/blvm-consensus/commit/76a4f05b2ad64bcebd7d71918c51646f54c4661d))
- test(consensus): lock rules the chain differential never executes ([22d513127ce1](https://github.com/BTCDecoded/blvm-consensus/commit/22d513127ce1cc82e09861f759ff55b3d6a6241a))
- test(mining): an off-boundary template copies the parent bits ([9969ab91c37b](https://github.com/BTCDecoded/blvm-consensus/commit/9969ab91c37be780dc5b3f893afcc9090774d5d6))
- test(consensus): drop wall-clock bounds from property tests ([8d2bbebb85f5](https://github.com/BTCDecoded/blvm-consensus/commit/8d2bbebb85f53638e31f63ab16251d52999110ae))
- test(consensus): compare script verdicts with libbitcoinconsensus ([3967276b5b56](https://github.com/BTCDecoded/blvm-consensus/commit/3967276b5b56ae8040a0982acdef57892d108e07))
- test(mining): a height-0 template uses the network work limit ([9bd441154e57](https://github.com/BTCDecoded/blvm-consensus/commit/9bd441154e57c175a81def0e2ad17c08a3daebd8))
- fix(script): check the block 659901 signature against the wire transaction ([f18bd2b28772](https://github.com/BTCDecoded/blvm-consensus/commit/f18bd2b28772946a9e47e8ac9a0e9a87cf11af3c))
- Bump version to 0.1.49 for release [skip ci] ([bcbc91c8be69](https://github.com/BTCDecoded/blvm-consensus/commit/bcbc91c8be69a82ef8ce3cfef83bab80faee98ee))

## [v0.1.50] - 2026-10-06

### Reconstructed

- test(consensus): hash the gating run and check block 443992 against the script library ([dfe6ff91f40b](https://github.com/BTCDecoded/blvm-consensus/commit/dfe6ff91f40b946e83d82e1e79ea56c4be29b83f))
- Bump version to 0.1.50 for release [skip ci] ([068cabc6b0b9](https://github.com/BTCDecoded/blvm-consensus/commit/068cabc6b0b90fa99abc26fa3c52b5fb51cb9172))

## [v0.1.51] - 2026-10-06

### Reconstructed

- refactor(block): move production transaction validation out of connect_block_inner ([46621623b08c](https://github.com/BTCDecoded/blvm-consensus/commit/46621623b08c36f7eb724af90562e8adce6c1f99))
- Bump version to 0.1.51 for release [skip ci] ([fee7e880172d](https://github.com/BTCDecoded/blvm-consensus/commit/fee7e880172d4ef71a40697b97ade41829f038f8))

## [v0.1.52] - 2026-10-06

### Reconstructed

- fix(ci): use REPO_ACCESS_TOKEN for release tags when workflows change (#21) ([0c0e74672051](https://github.com/BTCDecoded/blvm-consensus/commit/0c0e746720518d88df8c9ad76c3ba49c7c339d3d))
- Bump version to 0.1.52 for release [skip ci] ([af471744a30f](https://github.com/BTCDecoded/blvm-consensus/commit/af471744a30fba0c49d3eec543d7f841c3fa150c))

## [v0.1.53] - 2026-10-07

### Reconstructed

- feat(consensus): add testnet4 rules and the BIP34 height prefix ([dcac4d5bd349](https://github.com/BTCDecoded/blvm-consensus/commit/dcac4d5bd349099873a024f1b2a5b5a2a3a12d62))
- fix(consensus): cover testnet4 in the CTV and CSFS activation matches ([6e529962f1c4](https://github.com/BTCDecoded/blvm-consensus/commit/6e529962f1c4ed352cdfbfb42303fbcf4eae6d63))
- fix(consensus): encode BIP34 heights 1 through 16 as OP_1 through OP_16 ([0c58b8d8d8a7](https://github.com/BTCDecoded/blvm-consensus/commit/0c58b8d8d8a72c58db1d83048cdec7d931fca718))
- fix(consensus): use OP_1 through OP_16 in the BIP34 test fixtures ([e4c35f619ac7](https://github.com/BTCDecoded/blvm-consensus/commit/e4c35f619ac7904f0559d0e1bcdad3d552ee1d45))
- Bump version to 0.1.53 for release [skip ci] ([5ff6b26653e3](https://github.com/BTCDecoded/blvm-consensus/commit/5ff6b26653e3826662b7417abbf16dd0c2224bc1))

## [v0.1.54] - 2026-10-08

### Reconstructed

- fix(consensus): reject the wire cases the local rules were still accepting ([550c945662bd](https://github.com/BTCDecoded/blvm-consensus/commit/550c945662bdb0219e7def8a8a744296d74d8ff9))
- fix(consensus): count the block-weight prefix in the segwit sum test ([61f2e528ee2c](https://github.com/BTCDecoded/blvm-consensus/commit/61f2e528ee2c9a50da12d31e3e9bcf9571937c91))
- fix(consensus): expect the header weight on an empty segwit block ([f506683d84f0](https://github.com/BTCDecoded/blvm-consensus/commit/f506683d84f0e07a43d7afea22f10c7bdaeb9c5b))
- style(consensus): wrap the empty-block weight assertions ([f2c93249d65e](https://github.com/BTCDecoded/blvm-consensus/commit/f2c93249d65ea491e974edb0da4f06f93386bcda))
- test(consensus): drop the sighash batch timing race ([c491cc8e47d4](https://github.com/BTCDecoded/blvm-consensus/commit/c491cc8e47d4d6d51963cffbcaf6ac9f37d57389))
- Bump version to 0.1.54 for release [skip ci] ([2c7cad2a16d9](https://github.com/BTCDecoded/blvm-consensus/commit/2c7cad2a16d9bc5c7de099da9f7f952c908a3450))

## [v0.1.55] - 2026-10-09

### Reconstructed

- fix(consensus): close the script and mempool gaps the fast paths skipped ([d87363943245](https://github.com/BTCDecoded/blvm-consensus/commit/d87363943245c3d441670e7fa71b9fb3a0e71ea0))
- fix(consensus): require BIP54 locktime of height minus one ([c777f3372795](https://github.com/BTCDecoded/blvm-consensus/commit/c777f337279523390b77482af2dd639b5d99ddf9))
- fix(consensus): satisfy clippy and rustfmt on the parent-median reorg ([e39a60ec2527](https://github.com/BTCDecoded/blvm-consensus/commit/e39a60ec25270d5642b3a6958bb8df22de64c9fb))
- fix(consensus): publish without the crates.io protocol fuzz dependency ([e67eba1eaa29](https://github.com/BTCDecoded/blvm-consensus/commit/e67eba1eaa2986accb7fbb02944035eb953102b4))
- Bump version to 0.1.55 for release [skip ci] ([3b1a1e21e2bc](https://github.com/BTCDecoded/blvm-consensus/commit/3b1a1e21e2bcf75ff16dbb13813a8b58f45c9e38))

## [v0.1.56] - 2026-10-11

### Reconstructed

- fix(consensus): reject a time lock when the prior median is missing ([f7f2e2385936](https://github.com/BTCDecoded/blvm-consensus/commit/f7f2e23859367232a7b0199b74a02bbd76d7f91b))
- fix(consensus): opt into RBF below 0xfffffffe and build a connectable template ([25327808ed59](https://github.com/BTCDecoded/blvm-consensus/commit/25327808ed59dd416053401e2486fbd4e1a21a2c))
- style(consensus): order imports the way CI rustfmt does ([c9556ec92b31](https://github.com/BTCDecoded/blvm-consensus/commit/c9556ec92b318049233f27d6f8f0cde4c0f31016))
- test(consensus): signal RBF with a sequence below 0xfffffffe ([0e220d27a35d](https://github.com/BTCDecoded/blvm-consensus/commit/0e220d27a35d12b46a5c9bd5c15505f1cc44f245))
- Bump version to 0.1.56 for release [skip ci] ([258ec0d72837](https://github.com/BTCDecoded/blvm-consensus/commit/258ec0d72837adf326dbefd725696ca791dece99))

## [v0.1.57] - 2026-10-11

### Reconstructed

- fix(consensus): accept a false witness program and require a minimal push ([e154a18b56b7](https://github.com/BTCDecoded/blvm-consensus/commit/e154a18b56b722ad212ea348c6d6dc65deb1520b))
- test(consensus): accept an all-zero future witness program ([c5707738dba9](https://github.com/BTCDecoded/blvm-consensus/commit/c5707738dba910a736fe40faa54aa702a3a4e273))
- fix(consensus): reject a witness program whose stack top is false ([81f0406873fa](https://github.com/BTCDecoded/blvm-consensus/commit/81f0406873fab63d23dd3d53c89632a95ac6383b))
- Bump version to 0.1.57 for release [skip ci] ([e8b78a95a431](https://github.com/BTCDecoded/blvm-consensus/commit/e8b78a95a431224700e74ed8d30e8634093b81e1))

## [v0.1.58] - 2026-10-11

### Reconstructed

- fix(consensus): export the witness-program predicate ([74a2bad52e09](https://github.com/BTCDecoded/blvm-consensus/commit/74a2bad52e09eb3c040a3fcb04c0a7ffcb5a804b))
- Bump version to 0.1.58 for release [skip ci] ([d74f28a6037b](https://github.com/BTCDecoded/blvm-consensus/commit/d74f28a6037bfad6bd7e49284aed070ae9aece13))

## [v0.1.59] - 2026-10-11

### Reconstructed

- refactor(consensus): compare a relative lock with one predicate ([d9455b129532](https://github.com/BTCDecoded/blvm-consensus/commit/d9455b129532fbe3220fdf74801c74cd58a9f5c7))
- Bump version to 0.1.59 for release [skip ci] ([b9a06046ed11](https://github.com/BTCDecoded/blvm-consensus/commit/b9a06046ed115ac949eb5f83cebc388f5c7e099f))

## [v0.1.60] - 2026-10-15

### Reconstructed

- perf(consensus): skip witness-script copies and batch a buried signature ([91c71c987fc3](https://github.com/BTCDecoded/blvm-consensus/commit/91c71c987fc33ac44fec148ea782973bd92c4751))
- style(consensus): satisfy rustfmt and clippy on the witness-script path ([8785e229c796](https://github.com/BTCDecoded/blvm-consensus/commit/8785e229c79667b436df881b4d92b2500f0246cd))
- Bump version to 0.1.60 for release [skip ci] ([949afdfb1895](https://github.com/BTCDecoded/blvm-consensus/commit/949afdfb1895509ed87548d49c545c48b041479b))

## [v0.1.61] - 2026-10-18

### Reconstructed

- test(consensus): lock ancestor bits, BIP94, and testnet4 CTV ([3f7db28c364a](https://github.com/BTCDecoded/blvm-consensus/commit/3f7db28c364ad86d3bfed675a3fe88371176a4be))
- chore(consensus): restore the monorepo path patch ([6fe8065b110e](https://github.com/BTCDecoded/blvm-consensus/commit/6fe8065b110ebad5dbbe348a383eecf8777a6236))
- test(consensus): lock the arithmetic around the consensus fixes ([b64db450b531](https://github.com/BTCDecoded/blvm-consensus/commit/b64db450b531e4516f789ee04e6e435cdde3e76f))
- test(consensus): make property tests check the rule they name ([3e66f15ce87f](https://github.com/BTCDecoded/blvm-consensus/commit/3e66f15ce87fb021ca53c41b1fd739eddcc7efc9))
- fix(consensus): reject a non-push P2SH scriptSig and an uncompressed witness key ([bea14b3591fb](https://github.com/BTCDecoded/blvm-consensus/commit/bea14b3591fbd92f2a8af2a162e05943d016e92b))
- fix(consensus): pair nested P2WSH signatures from the top ([f5b21461b640](https://github.com/BTCDecoded/blvm-consensus/commit/f5b21461b640003e104c7299f357abe8fab26095))
- fix(consensus): detect witness programs at their real lengths ([5700d5d4096f](https://github.com/BTCDecoded/blvm-consensus/commit/5700d5d4096fe36fddaa234d3559728c057c3b57))
- fix(consensus): keep the BIP34 witness translatable ([fb951bb82a4a](https://github.com/BTCDecoded/blvm-consensus/commit/fb951bb82a4a5998de8fc6d63cf648dca272a7ec))
- Bump version to 0.1.61 for release [skip ci] ([1cf24e480956](https://github.com/BTCDecoded/blvm-consensus/commit/1cf24e4809562dab5e95e2e79fa663ef847e2ae3))

## [v0.1.62] - 2026-10-19

### Reconstructed

- test(consensus): include the witness program push length ([d11b6bec55ad](https://github.com/BTCDecoded/blvm-consensus/commit/d11b6bec55ad7725227f930def6fd7a11b8f60ba))
- Bump version to 0.1.62 for release [skip ci] ([2ba365a7ab21](https://github.com/BTCDecoded/blvm-consensus/commit/2ba365a7ab216a5c8571c85e919e4adca6578aa5))

## [v0.1.63] - 2026-10-20

### Reconstructed

- docs: state what verify and the mutation gate actually cover. ([389680ef676d](https://github.com/BTCDecoded/blvm-consensus/commit/389680ef676d3ee38f4b53941404aebdd9187de5))
- Bump version to 0.1.63 for release [skip ci] ([eaf67999e0a0](https://github.com/BTCDecoded/blvm-consensus/commit/eaf67999e0a0773cc02722681744e4f134b32c7c))

## [v0.1.64] - 2026-10-20

### Reconstructed

- docs: stop calling the crate mathematically locked. ([ed2fac0839f2](https://github.com/BTCDecoded/blvm-consensus/commit/ed2fac0839f25978bc4c6298ee8354b4c9f83420))
- Bump version to 0.1.64 for release [skip ci] ([c049ac695621](https://github.com/BTCDecoded/blvm-consensus/commit/c049ac695621666047ea56d034389893b94bd0ac))

## [v0.1.65] - 2026-10-20

### Reconstructed

- docs: use the Orange Paper section numbers. ([2f0fd16a562e](https://github.com/BTCDecoded/blvm-consensus/commit/2f0fd16a562e7e463d65f0ce70a8ebca831fe1d4))
- Bump version to 0.1.65 for release [skip ci] ([2566f56fb2f4](https://github.com/BTCDecoded/blvm-consensus/commit/2566f56fb2f483f8850d53a40886ca9e0c35cf31))

## [v0.1.66] - 2026-10-20

### Reconstructed

- fix(consensus): close the hunt locks for scripts, templates, and reorg ([69117d1dd270](https://github.com/BTCDecoded/blvm-consensus/commit/69117d1dd2709874a3a1c6b36d292912034e1120))
- fix(consensus): give a declared legacy spend empty witness stacks ([a8d3460c4fa5](https://github.com/BTCDecoded/blvm-consensus/commit/a8d3460c4fa5dc0cd5cc7246685ff929fb0ec2c1))
- fix(consensus): let a second OP_ELSE invert the conditional ([a4a1ac96c836](https://github.com/BTCDecoded/blvm-consensus/commit/a4a1ac96c836b3b809b8727642445bd887d63fe7))
- fix(consensus): check the zero-hash signature in verify_script ([e48cc7568caf](https://github.com/BTCDecoded/blvm-consensus/commit/e48cc7568cafd86d3e452765dc59164875b7a3ea))
- Bump version to 0.1.66 for release [skip ci] ([8c2e1d37fc04](https://github.com/BTCDecoded/blvm-consensus/commit/8c2e1d37fc049fe5d6276734d83ca0fa2f085416))

## [v0.1.67] - 2026-10-21

### Reconstructed

- fix(consensus): reject a block header that misses its proof of work ([bbdaccbbf980](https://github.com/BTCDecoded/blvm-consensus/commit/bbdaccbbf980b3a51856ad1947c6707358f1aeba))
- Bump version to 0.1.67 for release [skip ci] ([04486b7618d0](https://github.com/BTCDecoded/blvm-consensus/commit/04486b7618d0829f5896a0189133abd9edfeaf3d))

## [v0.1.68] - 2026-10-21

### Reconstructed

- fix(consensus): run a P2SH redeem script and reject a relative lock that spends a missing coin ([435f9949b3d0](https://github.com/BTCDecoded/blvm-consensus/commit/435f9949b3d0f61ce14f6f333f9f58543cce9fdf))
- fix(consensus): record spent coins on the IBD undo path ([59357b7e651f](https://github.com/BTCDecoded/blvm-consensus/commit/59357b7e651fd6448b3b80fd0d6797399bb011e4))
- Bump version to 0.1.68 for release [skip ci] ([a9fb32d002a5](https://github.com/BTCDecoded/blvm-consensus/commit/a9fb32d002a5c29963625ae9725cd8266178186e))

## [v0.1.69] - 2026-10-24

### Reconstructed

- fix(consensus): check a key-path spend without production and load the newer vectors ([59a30f3921d2](https://github.com/BTCDecoded/blvm-consensus/commit/59a30f3921d24c06f101413cc27b12d8f50974c7))
- fix(consensus): borrow script bytes on the check and sighash paths ([7dd171b3ce67](https://github.com/BTCDecoded/blvm-consensus/commit/7dd171b3ce67e2d9d4b1fa1e7479259113931935))
- fix(consensus): format, satisfy clippy, and skip an empty prevout index ([cc37eb7c9163](https://github.com/BTCDecoded/blvm-consensus/commit/cc37eb7c9163eeaee28288aba8ea9467b1f45a3b))
- Bump version to 0.1.69 for release [skip ci] ([5d98ed8b4261](https://github.com/BTCDecoded/blvm-consensus/commit/5d98ed8b42610b4d233efea0a759cc686301aff4))

## [v0.1.70] - 2026-10-24

### Reconstructed

- Bump version to 0.1.70 for release [skip ci] ([994480ddb6d0](https://github.com/BTCDecoded/blvm-consensus/commit/994480ddb6d03a828b4c00654521986d7551fcaf))

## [v0.1.71] - 2026-10-29

### Reconstructed

- fix(consensus): keep the reorg failure reason and rebuild a missing undo log. ([e2b0e7702561](https://github.com/BTCDecoded/blvm-consensus/commit/e2b0e770256125afc2dd05f1723696a01796d42f))
- Bump version to 0.1.71 for release [skip ci] ([e16c1cfad95d](https://github.com/BTCDecoded/blvm-consensus/commit/e16c1cfad95d6e62e992c5c980714b7b87643ced))

## [v0.1.72] - 2026-10-30

### Reconstructed

- fix(consensus): pin the subsidy schedule and script-number OP_ADD ([01c8af8813e0](https://github.com/BTCDecoded/blvm-consensus/commit/01c8af8813e058e7cd1ea6dcd79bfb69d398e639))
- Bump version to 0.1.72 for release [skip ci] ([d37565107d23](https://github.com/BTCDecoded/blvm-consensus/commit/d37565107d239fb1a63d2a0af581fc7557aad3a2))

## [v0.1.73] - 2026-11-01

### Reconstructed

- fix(consensus): let NULLDUMMY follow the flag alone ([082ceb1e1718](https://github.com/BTCDecoded/blvm-consensus/commit/082ceb1e1718092b9a6e1afa584c72c09820cd35))
- Bump version to 0.1.73 for release [skip ci] ([a9030c1a4abf](https://github.com/BTCDecoded/blvm-consensus/commit/a9030c1a4abfed13d6049920fd70ec853b58c9e4))

## [v0.1.74] - 2026-11-04

### Reconstructed

- fix(consensus): share the duplicated script and sighash bodies ([0198f65bb655](https://github.com/BTCDecoded/blvm-consensus/commit/0198f65bb655cae285f67104b0d39bb5db1abbae))
- fix(consensus): keep assume-valid checks and recognize pay-to-anchor ([7889adfce1c8](https://github.com/BTCDecoded/blvm-consensus/commit/7889adfce1c8f33cfcb309ab994e5f10d0643ad7))
- style(consensus): format the pay-to-anchor and script-code paths ([706e6f50ae97](https://github.com/BTCDecoded/blvm-consensus/commit/706e6f50ae97760e08b73422831e16227e22b952))
- fix(consensus): match replacement tests to the relay bump ([a8de49e193cb](https://github.com/BTCDecoded/blvm-consensus/commit/a8de49e193cb37dfe083a8630b5381543df6a8bf))
- fix(consensus): reject a replacement whose original does not signal ([5454a1c9c465](https://github.com/BTCDecoded/blvm-consensus/commit/5454a1c9c465391da4f41f531fe235b4219cde1b))
- ci(consensus): verify with spec-lock 0.1.45 ([e9ea2fef942c](https://github.com/BTCDecoded/blvm-consensus/commit/e9ea2fef942c29fab8f417f1b9650b1b956b6ee6))
- Bump version to 0.1.74 for release [skip ci] ([960d31b64da8](https://github.com/BTCDecoded/blvm-consensus/commit/960d31b64da8ed76ac28ad0e0849f6d950a5331f))

## [v0.1.75] - 2026-11-04

### Reconstructed

- fix(consensus): let the node decide whether a replacement must signal ([4d7345b9a207](https://github.com/BTCDecoded/blvm-consensus/commit/4d7345b9a207ecb3771dadbb3cfba5854c3b4bfe))
- fix(consensus): drop the signal bit from the replacement fee property ([abd1670ed408](https://github.com/BTCDecoded/blvm-consensus/commit/abd1670ed40864362d6a4d458281c09a9ec4c8f1))
- Bump version to 0.1.75 for release [skip ci] ([86ae2db60930](https://github.com/BTCDecoded/blvm-consensus/commit/86ae2db60930c90f3d2a500b668451ff5338e255))

## [v0.1.76] - 2026-11-05

### Reconstructed

- fix(consensus): check the supply cap in the function body ([32d20e3fe9e8](https://github.com/BTCDecoded/blvm-consensus/commit/32d20e3fe9e8c8e7aadc7eef5ef6543663947a49))
- docs: count the 13 functions proved from the body ([265b0eadc62c](https://github.com/BTCDecoded/blvm-consensus/commit/265b0eadc62c460399a6381132f5effc8791a6f3))
- docs: say Z3 checks the Rust and Lean checks the spec model ([36c8bd878485](https://github.com/BTCDecoded/blvm-consensus/commit/36c8bd878485435089b86ee55ebbdaa659ffdd05))
- fix(consensus): reject the wrong block, version, and signature ([8e09804f9d28](https://github.com/BTCDecoded/blvm-consensus/commit/8e09804f9d28ce18903b3bc58ffd2fbfd41fd48e))
- fix(consensus): let the supply check ship on the pinned verifier ([4619088085b7](https://github.com/BTCDecoded/blvm-consensus/commit/4619088085b7f9c0e551b51c4dc1793a9cb0cef2))
- ci(consensus): compile tests without the incremental cache ([9cd1aab283cb](https://github.com/BTCDecoded/blvm-consensus/commit/9cd1aab283cb0b4baeb9e471fbde3f92c7562b13))
- fix(consensus): honor DERSIG without a second activation check ([168b06dc94d9](https://github.com/BTCDecoded/blvm-consensus/commit/168b06dc94d9369e5705876f81cb6da95377d6e4))
- test(consensus): a rejected script is an invalid block ([46b7e1bdf4f1](https://github.com/BTCDecoded/blvm-consensus/commit/46b7e1bdf4f1fd10c00760393c54a020f7fb2dda))
- Bump version to 0.1.76 for release [skip ci] ([a6200fd36765](https://github.com/BTCDecoded/blvm-consensus/commit/a6200fd36765ebd6cd76425a3172dfa8aa3cc1c7))

## [v0.1.77] - 2026-11-05

### Reconstructed

- fix(consensus): drop the unread sig cache and close policy gaps ([a79c0c5800bb](https://github.com/BTCDecoded/blvm-consensus/commit/a79c0c5800bbcc364c19c80b124b1367d9e9ecbb))
- style(consensus): format the p2sh sigop assertion ([c9ddb1121117](https://github.com/BTCDecoded/blvm-consensus/commit/c9ddb112111732f5a5115fcae3c5c8340d2486b8))
- Bump version to 0.1.77 for release [skip ci] ([21bb41455491](https://github.com/BTCDecoded/blvm-consensus/commit/21bb41455491b4c4ea7fde34862337723c2fed23))

## [v0.1.78] - 2026-11-06

### Reconstructed

- Keep assume-valid checks on the checked seed and round-trip the undo log. ([5cf1f7e57344](https://github.com/BTCDecoded/blvm-consensus/commit/5cf1f7e57344a1a4c55b0d3d842dd6138f32918d))
- Bump version to 0.1.78 for release [skip ci] ([a967bb09c49d](https://github.com/BTCDecoded/blvm-consensus/commit/a967bb09c49d0d95929f1dc9f3c9a9d8da7fca15))

## [v0.1.79] - 2026-11-06

### Reconstructed

- fix(consensus): count a BIP9 signal only when the version prefix is 001 ([ed239f28e663](https://github.com/BTCDecoded/blvm-consensus/commit/ed239f28e6632394f208a9ee5784e6a9a2d20f23))
- Bump version to 0.1.79 for release [skip ci] ([920a5f6787fc](https://github.com/BTCDecoded/blvm-consensus/commit/920a5f6787fca44584a5161db5955ad094f8c682))

## [v0.1.80] - 2026-11-07

### Reconstructed

- Make spec-lock optional so the node build does not compile it. ([fe108a5dd232](https://github.com/BTCDecoded/blvm-consensus/commit/fe108a5dd232c6a42fc42f7b0d34f08fd0805c97))
- fix(consensus): enforce BIP68 on the unsigned version word ([edcdb883e7c0](https://github.com/BTCDecoded/blvm-consensus/commit/edcdb883e7c06ab3d8dd487780c9125d1905d108))
- fix(consensus): accept header version 0 before BIP34 ([0f40b74095ea](https://github.com/BTCDecoded/blvm-consensus/commit/0f40b74095eab76167df3a3b4153c549a6a088be))
- fix(consensus): reject structural failures instead of returning errors ([640ff3271904](https://github.com/BTCDecoded/blvm-consensus/commit/640ff3271904a4c90478a353c19dcbaf8db6e2e1))
- fix(consensus): treat an overflowing output sum as an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- test(consensus): an overflowing output sum is an invalid transaction ([2cd6980f8f4b](https://github.com/BTCDecoded/blvm-consensus/commit/2cd6980f8f4bd096ebab4c143b02fb29e7df1104))
- Bump version to 0.1.80 for release [skip ci] ([c14831a60898](https://github.com/BTCDecoded/blvm-consensus/commit/c14831a60898cf7444ab944c9d152d7ea9620ee5))

## [v0.1.81] - 2026-11-09

### Reconstructed

- fix(consensus): reject STRICTENC failures and unverified Schnorr slots ([de285af2570e](https://github.com/BTCDecoded/blvm-consensus/commit/de285af2570e28559964bfa748b08cda3a661c8b))
- fix(consensus): treat a missing witness matrix as empty stacks ([f1691a8d1deb](https://github.com/BTCDecoded/blvm-consensus/commit/f1691a8d1deb80f28db5ca641fcb2c43750903af))
- fix(consensus): give the empty reserved-value case one coinbase stack ([ddbc5a890fb4](https://github.com/BTCDecoded/blvm-consensus/commit/ddbc5a890fb45c57b002f2b4f9d2523e822e9fa1))
- docs: drop the 1,000-input cap and the strict-mode Partial failure ([35dd7186a491](https://github.com/BTCDecoded/blvm-consensus/commit/35dd7186a4916e6bdd6edd9f85f8ad97a489390f))
- fix(consensus): accept a bad BIP34 prefix before regtest activation ([5108c43b71dd](https://github.com/BTCDecoded/blvm-consensus/commit/5108c43b71dd84728767e9f5181377dcbfa3ef9a))
- fix(consensus): skip STRICTENC on a 0-of-n multisig ([07d079ecf532](https://github.com/BTCDecoded/blvm-consensus/commit/07d079ecf5327ce0ff358955f7f42373760358c5))
- fix(consensus): give the BIP66 test the hash of its pubkey ([ff1567740d0a](https://github.com/BTCDecoded/blvm-consensus/commit/ff1567740d0a53796dc58be2de27f007b3e0db02))
- fix(consensus): expect STRICTENC to reject an undefined hashtype ([e9b1ad40d8e4](https://github.com/BTCDecoded/blvm-consensus/commit/e9b1ad40d8e4337edaa7742fa4b02f522be6efdd))
- Bump version to 0.1.81 for release [skip ci] ([ba0dd3f729a7](https://github.com/BTCDecoded/blvm-consensus/commit/ba0dd3f729a7aca419de0c4ee22dc302ff6d86a3))

## [v0.1.82] - 2026-11-12

### Reconstructed

- refactor(consensus): move large test modules out of the implementation files ([8142c648586d](https://github.com/BTCDecoded/blvm-consensus/commit/8142c648586d01decaf863ddd84ea69e830b23f3))
- Bump version to 0.1.82 for release [skip ci] ([f63c32856a2d](https://github.com/BTCDecoded/blvm-consensus/commit/f63c32856a2da874296524f40b8cbd35518d8096))
