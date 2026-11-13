# Changelog

All notable changes to `blvm-protocol` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Every section below is reconstructed from git history. Conventional Commits
were not enforced when those commits were written. Merge commits are omitted.

## [Unreleased]

## [v0.1.3] - 2025-11-23

### Reconstructed

- Complete protocol-engine implementation ([197684b37261](https://github.com/BTCDecoded/blvm-protocol/commit/197684b3726181fb748a2678fe8d82a301d651ef))
- Complete protocol-engine implementation ([f56ee724ab57](https://github.com/BTCDecoded/blvm-protocol/commit/f56ee724ab57895a1be81289d1d51b8abf356285))
- Update protocol engine dependencies and tests ([61dbdec18b5d](https://github.com/BTCDecoded/blvm-protocol/commit/61dbdec18b5daf097548a58079c19634fea01679))
- chore: Update codebase with various improvements ([e0673c752341](https://github.com/BTCDecoded/blvm-protocol/commit/e0673c752341abf06e6aa2af8b6a1341d5741da6))
- Add benchmark comparison infrastructure and production features benchmarks ([1a98665832b0](https://github.com/BTCDecoded/blvm-protocol/commit/1a98665832b087cdc4b915dad07a3fde79284d3b))
- Fix YAML syntax errors in CI workflow ([7ad60a5048a4](https://github.com/BTCDecoded/blvm-protocol/commit/7ad60a5048a4d6736379f0cfb5a45028b9bcdc4c))
- Simplify CI to Linux-only self-hosted runners ([51b1a4924379](https://github.com/BTCDecoded/blvm-protocol/commit/51b1a4924379cad1475fdb447acae1675196fb90))
- Fix runner label case sensitivity ([7e7572d4d0b3](https://github.com/BTCDecoded/blvm-protocol/commit/7e7572d4d0b3871343f3e3f131fc9b3abab2a5cc))
- Update CI workflow to use array format for runner labels ([4147ec971158](https://github.com/BTCDecoded/blvm-protocol/commit/4147ec9711581843065cf9a876166c543b71c0af))
- Update Rust toolchain to 1.82.0 ([de46b4061988](https://github.com/BTCDecoded/blvm-protocol/commit/de46b40619886fa025d51127bc12d1069dabf78d))
- chore: trigger CI workflow ([ac3298622635](https://github.com/BTCDecoded/blvm-protocol/commit/ac3298622635960878b1afe9dd2ec7423a05d91e))
- refactor: re-export consensus-proof types and fix build chain ([46429607a6c3](https://github.com/BTCDecoded/blvm-protocol/commit/46429607a6c349d123d3e1fd6290e21184d70d12))
- Fix GitHub Actions path issue: move consensus-proof to parent directory after checkout ([938c33ee1e22](https://github.com/BTCDecoded/blvm-protocol/commit/938c33ee1e22a1c943b9779ed06caf50e33c654e))
- Add cleanup step to handle existing consensus-proof directory ([4f45f35b4f33](https://github.com/BTCDecoded/blvm-protocol/commit/4f45f35b4f33be91bfabfc941263faebb7b90744))
- feat: Re-export BLLVM optimizations from consensus-proof ([b58f3ebd5870](https://github.com/BTCDecoded/blvm-protocol/commit/b58f3ebd58706f051b0ecb87657cb37d683087f2))
- Fix: Update Rust toolchain to 1.88.0 and fix cargo-audit/tarpaulin ([5f100520b0e5](https://github.com/BTCDecoded/blvm-protocol/commit/5f100520b0e5abbd1b641ba51a63e400dd5d3e03))
- Fix: Update rust-toolchain.toml to 1.88.0 ([832d8e7d08d1](https://github.com/BTCDecoded/blvm-protocol/commit/832d8e7d08d1f07ee5dccad863e7ae67c224b6a9))
- Fix: Simplify map_or to is_some_and in features.rs ([79d9fa7cc93c](https://github.com/BTCDecoded/blvm-protocol/commit/79d9fa7cc93c5e8a2572243c1c70215b76c4f8a5))
- Fix: Simplify second map_or to is_some_and in features.rs ([b2354d86d579](https://github.com/BTCDecoded/blvm-protocol/commit/b2354d86d579765d559fe8664e8053d4baf04b3b))
- Fix: Use static cache keys for dependency caches (hashFiles can't access files outside workspace) ([0d0b712ddb3f](https://github.com/BTCDecoded/blvm-protocol/commit/0d0b712ddb3fc7273e7ca22c0950312c6c9fd638))
- Fix: Update cargo-audit to 0.21.0 to support Cargo.lock format version 4 ([a502e15c4612](https://github.com/BTCDecoded/blvm-protocol/commit/a502e15c461222f3616964a0ca51d022b32a58c8))
- Fix: Use cargo-audit 0.20.0 (0.21.0 requires Rust 1.89, we use 1.88.0) ([67b879233ba9](https://github.com/BTCDecoded/blvm-protocol/commit/67b879233ba9ed7930f749b7b353bedec515ceb1))
- Update repository references to new names (bllvm-*) ([6a3edd4fdf35](https://github.com/BTCDecoded/blvm-protocol/commit/6a3edd4fdf35a9f7bf1a37494dbe7892bc898a45))
- docs: Add reference to master status document ([4e0347a1729a](https://github.com/BTCDecoded/blvm-protocol/commit/4e0347a1729ad99a4fcb0443be1b0faed84e77ff))
- docs: Update bllvm-sdk description to 'developer toolkit' ([9de93f542733](https://github.com/BTCDecoded/blvm-protocol/commit/9de93f542733fdc1d54d695956db65161db22c1b))
- Fix compilation errors after separation of concerns refactoring ([1130753b31c1](https://github.com/BTCDecoded/blvm-protocol/commit/1130753b31c114421c97e2453afeb4c89ef60451))
- fix: Update workflow to use correct repository name (bllvm-consensus) ([3b235f2457e8](https://github.com/BTCDecoded/blvm-protocol/commit/3b235f2457e887dcdfc64e24acf99e5fc9a4875d))
- fix: add utxo_commitments re-export when feature enabled ([fc2c07101706](https://github.com/BTCDecoded/blvm-protocol/commit/fc2c0710170639c90793c9f604b2bd3e80f25247))
- Add sigop module re-export for bllvm-node compatibility ([e211575a86fc](https://github.com/BTCDecoded/blvm-protocol/commit/e211575a86fc54d462d71343171e4966c7b07af6))
- Fix clippy warnings: prefix unused parameter with underscore ([fed90197a019](https://github.com/BTCDecoded/blvm-protocol/commit/fed90197a0198456f877838ba0fb1bab86d5462b))
- fix: forward consensus-proof features and add mining module re-export ([374a92bed544](https://github.com/BTCDecoded/blvm-protocol/commit/374a92bed54466512199feda148e2a834ff68f88))
- Fix clippy warnings and formatting ([5379809bed5f](https://github.com/BTCDecoded/blvm-protocol/commit/5379809bed5fbc096fb6170fb5a79ade7da376e2))
- Fix compilation errors: duplicate features and mining module ([973353ef09c6](https://github.com/BTCDecoded/blvm-protocol/commit/973353ef09c6d626372d38edf3f9f1c7039ba6de))
- Fix clippy warnings ([4c9cf16bb975](https://github.com/BTCDecoded/blvm-protocol/commit/4c9cf16bb975d190e4b45a2dd09bb501393a17c3))
- Fix clippy format string warnings ([201eff7a35a4](https://github.com/BTCDecoded/blvm-protocol/commit/201eff7a35a4514b397e703aed39b03d076f5f5d))
- Apply cargo fmt formatting ([7ce105d0de3b](https://github.com/BTCDecoded/blvm-protocol/commit/7ce105d0de3b9a3e8bb527e577f0f467aaa7fcd3))
- Remove unused imports ([367c69192b14](https://github.com/BTCDecoded/blvm-protocol/commit/367c69192b14a18bbd422b7da028de829bb090d3))
- Fix test_filter_header: filter_hash should be same, header_hash should differ ([00de88c31a2a](https://github.com/BTCDecoded/blvm-protocol/commit/00de88c31a2a84efe2181f6d5ac4e0400e30e9b3))
- Make repository-dispatch non-blocking to prevent build job failure ([a85d01a162c5](https://github.com/BTCDecoded/blvm-protocol/commit/a85d01a162c5a734f5813d3c7d540a80b0b6b80c))
- Use REPO_ACCESS_TOKEN for repository-dispatch (org-level secret) ([d21811be9d60](https://github.com/BTCDecoded/blvm-protocol/commit/d21811be9d609b61dacb8067e029e29026822df8))
- Upgrade cargo-audit to 0.22.0 for Cargo.lock format version 4 support ([ec6dd1e72240](https://github.com/BTCDecoded/blvm-protocol/commit/ec6dd1e722405538171ff09ee5e1615b893e70a5))
- Add --locked flag to cargo-audit installation to use exact dependency versions ([a51b5d0a2f2d](https://github.com/BTCDecoded/blvm-protocol/commit/a51b5d0a2f2d7c69e189c698ff12b778f31af4fb))
- Upgrade Rust to 1.89.0 for Security Audit job (required by cargo-audit 0.22.0) ([5d16c98a66d9](https://github.com/BTCDecoded/blvm-protocol/commit/5d16c98a66d9d8057e2f95545cc8683ee2d92e22))
- Update serde to 1.0.228 for iroh 0.95 compatibility ([031b2cbb6aad](https://github.com/BTCDecoded/blvm-protocol/commit/031b2cbb6aad8cc1d964f1a0053584e0ffe90c7c))
- Update Cargo.lock ([77f80ff546a3](https://github.com/BTCDecoded/blvm-protocol/commit/77f80ff546a3f03fe6f29855757aeaf26023f926))
- feat: Update for bllvm-consensus improvements ([68c6c4bc527a](https://github.com/BTCDecoded/blvm-protocol/commit/68c6c4bc527af83ae7f558ac710ab688436e6e3a))
- fix: Re-export tx_inputs! and tx_outputs! macros for bllvm-node ([1e0f6209462b](https://github.com/BTCDecoded/blvm-protocol/commit/1e0f6209462bdd6dc725b3f9401a0d53557f2173))
- Fix compilation errors: Convert Vec to SmallVec/Box for production feature ([e9ca995ae31e](https://github.com/BTCDecoded/blvm-protocol/commit/e9ca995ae31ec620aca013a8ee05bfb7e4f14d04))
- Add comprehensive test coverage for bllvm-protocol ([38faa196c03d](https://github.com/BTCDecoded/blvm-protocol/commit/38faa196c03d1de97f7261fb2071f74d59b9dd01))
- fix: add ctv feature pass-through from bllvm-consensus ([38f0e477a9d4](https://github.com/BTCDecoded/blvm-protocol/commit/38f0e477a9d438028d5816d49b4b87e1a2b04d72))
- Update .gitignore: remove target/ and Cargo.lock from tracking ([f1988b3ed63e](https://github.com/BTCDecoded/blvm-protocol/commit/f1988b3ed63e33e732dd4b55ef81110fb12dac5a))
- chore: update dependencies and payment module ([f150ff2a0462](https://github.com/BTCDecoded/blvm-protocol/commit/f150ff2a04629925cd02f0246af2afb50140fa7b))
- fix: Add missing signature field to PaymentACK test structs ([5f0b98096dc0](https://github.com/BTCDecoded/blvm-protocol/commit/5f0b98096dc0bc786cfc63b57af6dc4526995350))
- fix: Resolve SmallVec type mismatches in transaction structs ([3632019ae095](https://github.com/BTCDecoded/blvm-protocol/commit/3632019ae0958f138cd306834e7c652fcd5fc161))
- Remove verbose workflow name ([8ad26ec3ac90](https://github.com/BTCDecoded/blvm-protocol/commit/8ad26ec3ac90d10077446f1b608b8c9ae0f31d52))
- chore: Update dependencies and formatting ([48428ab51516](https://github.com/BTCDecoded/blvm-protocol/commit/48428ab51516d4d3556822be7eb800a093e9b5fe))
- Clean up verbose workflow names and echo statements ([0721c2914c24](https://github.com/BTCDecoded/blvm-protocol/commit/0721c2914c24dc3de554b91955b265a415864a82))
- Add orchestrator trigger: trigger release orchestrator on push to main ([30e070fb70b0](https://github.com/BTCDecoded/blvm-protocol/commit/30e070fb70b02c643b08a20ed6d775643b445acb))
- Standardize CI workflow: security depends on setup, build depends on all checks ([cee4d8fde2f9](https://github.com/BTCDecoded/blvm-protocol/commit/cee4d8fde2f9e1cfe0cb4df1d5a5e7b83acb2b17))
- Add independent release workflow for bllvm-protocol ([bea80862026a](https://github.com/BTCDecoded/blvm-protocol/commit/bea80862026aef3a75c72669a64fbf1ac1c60e77))
- Add release job to CI workflow ([fddab579e707](https://github.com/BTCDecoded/blvm-protocol/commit/fddab579e7070d950b5f56910bc98a21b0d3ffb1))
- Fix version determination to only match package version ([d88913b160dd](https://github.com/BTCDecoded/blvm-protocol/commit/d88913b160dde471eae9cf0a059b9cb37c47b0fd))
- Fix version extraction: use grep instead of awk ([9bba41a4aadc](https://github.com/BTCDecoded/blvm-protocol/commit/9bba41a4aadc5225d4ee358db0b652f1ae8026df))
- Commit Cargo.toml changes before publish ([bfb5eedf847e](https://github.com/BTCDecoded/blvm-protocol/commit/bfb5eedf847e9870127082404dbcc353f218cb53))
- Fix clippy and fmt issues; remove incorrect verify step ([860eb9eba291](https://github.com/BTCDecoded/blvm-protocol/commit/860eb9eba291a7071271ee51a9732993244e6ab9))
- Fix cargo-audit version compatibility with Rust 1.88.0 ([62b6e363d2fe](https://github.com/BTCDecoded/blvm-protocol/commit/62b6e363d2fe4672938a4e051022f6384d5b755e))
- Optimize test execution ([8ba633c8bfa7](https://github.com/BTCDecoded/blvm-protocol/commit/8ba633c8bfa7735ad0584ab939392e6708728694))
- fix: add builds label to all runs-on tags without perf ([d27b4071b8ad](https://github.com/BTCDecoded/blvm-protocol/commit/d27b4071b8ad61ba6a567d2420477689bf6b49be))
- Add CI improvements: [skip ci] support and REPO_ACCESS_TOKEN ([4e8d4784579d](https://github.com/BTCDecoded/blvm-protocol/commit/4e8d4784579dfb4b198b67ff992c5977e9b560ee))
- Add [skip ci] support to all jobs ([03549c749dd2](https://github.com/BTCDecoded/blvm-protocol/commit/03549c749dd24ed443717d18d679322b4df490e0))
- Fix: Add [skip ci] check to release job condition ([eea6d197a940](https://github.com/BTCDecoded/blvm-protocol/commit/eea6d197a940adc6afeeb729163b3ef3b98f72f5))
- Add workflow_dispatch to build job condition ([dcd8f2da52b5](https://github.com/BTCDecoded/blvm-protocol/commit/dcd8f2da52b5d06d0f1fe3c3690eb29d4dff9a7a))
- Bump version to 0.1.1 and update dependencies for release [skip ci] ([b301ad4fe4e6](https://github.com/BTCDecoded/blvm-protocol/commit/b301ad4fe4e645534a46b1a08dcad1c92c751f3d))
- Fix sed pattern to match entire dependency declaration when publishing ([f1d09b9b4bc7](https://github.com/BTCDecoded/blvm-protocol/commit/f1d09b9b4bc77fa01aaa2b1941c3d841dd7ba519))
- Fix malformed bllvm-consensus dependency in Cargo.toml ([fd0a90d963b8](https://github.com/BTCDecoded/blvm-protocol/commit/fd0a90d963b85a689c24a9386440aec7253a7f2d))
- Bump version to 0.1.2 and update dependencies for release [skip ci] ([90d6b7ad71e1](https://github.com/BTCDecoded/blvm-protocol/commit/90d6b7ad71e14f152dfe432baf0aee4efede3024))
- Add skip_tests input to workflow_dispatch for skipping test execution ([69f43bac7a6f](https://github.com/BTCDecoded/blvm-protocol/commit/69f43bac7a6f1efa0c155d8252f5bc34b5d056be))
- Properly skip test, clippy, fmt, docs, security jobs when skip_tests is true ([3f773a4a65d8](https://github.com/BTCDecoded/blvm-protocol/commit/3f773a4a65d80e14c6c8ad6f7b3599ef832894c9))
- Fix YAML syntax errors in CI workflow ([5903f97a2d51](https://github.com/BTCDecoded/blvm-protocol/commit/5903f97a2d511d637e3849ee7edf456cc9e1a4c1))
- Fix corrupted bllvm-consensus dependency in Cargo.toml ([5150305e90e1](https://github.com/BTCDecoded/blvm-protocol/commit/5150305e90e1d2977abe597e5dd3815045a2f85b))
- Fix release workflow: don't commit crates.io dependency changes ([9b60c4781fde](https://github.com/BTCDecoded/blvm-protocol/commit/9b60c4781fdeb3fc6f34fbf97af62db7a9345ed5))
- Fix YAML: quote step name with colon and remove emoji ([71a25118b5f6](https://github.com/BTCDecoded/blvm-protocol/commit/71a25118b5f619a959973f824b82609472fc3ae4))
- Fix release job: allow workflow_dispatch events ([8bb01b92fd79](https://github.com/BTCDecoded/blvm-protocol/commit/8bb01b92fd79f18a7fa5dbcaf40748c0360e8133))
- Fix release job: run after successful build even with skip_tests ([f6d5b217dce9](https://github.com/BTCDecoded/blvm-protocol/commit/f6d5b217dce9ecc7b534c9dd650eccb7dd06f68f))
- Fix version extraction from cargo search output ([0625555babe5](https://github.com/BTCDecoded/blvm-protocol/commit/0625555babe52f7e52ef187d05f57e5fbd69182d))
- Fix version extraction: use grep instead of sed ([a4f77d166f85](https://github.com/BTCDecoded/blvm-protocol/commit/a4f77d166f8597c1fee012b3533b3a9816f091d6))
- Add --allow-dirty flag to cargo publish commands ([8e2627a3a502](https://github.com/BTCDecoded/blvm-protocol/commit/8e2627a3a502d5930640e36ea9ac692a4440ea5e))

## [v0.1.4] - 2025-11-23

### Reconstructed

- Remove duplicate Network enum, use bllvm-consensus::types::Network ([20c8e9826a9c](https://github.com/BTCDecoded/blvm-protocol/commit/20c8e9826a9c720d75138dabff7288412218f438))
- Enforce test/verification requirements for build and release ([103f16ebbe9d](https://github.com/BTCDecoded/blvm-protocol/commit/103f16ebbe9d86af7cfe6beef53b280029521005))
- Fix publish step to handle already exists errors gracefully ([0df468de05f0](https://github.com/BTCDecoded/blvm-protocol/commit/0df468de05f065555983c0e267dd9dd812f036c0))
- Remove pointless informational step from release workflow ([46f2a472a997](https://github.com/BTCDecoded/blvm-protocol/commit/46f2a472a997cdc986f3f5b6909f6deea013e3d5))
- Fix version existence check in release workflow ([10268b82e5a5](https://github.com/BTCDecoded/blvm-protocol/commit/10268b82e5a5bf2d6657aa8a1de1917be9230397))
- Fix version auto-increment to check crates.io and find available version ([13664d4e1b92](https://github.com/BTCDecoded/blvm-protocol/commit/13664d4e1b9213c4f168b345b4404e11ebcbbb4b))
- Remove redundant release.yml workflow ([1f0ff2f7fe05](https://github.com/BTCDecoded/blvm-protocol/commit/1f0ff2f7fe05f0cc631c9660d69636651c384b1d))
- Fix version check race condition in publish step ([e8c9f299b67b](https://github.com/BTCDecoded/blvm-protocol/commit/e8c9f299b67bcdf3364bab70d5c3fccc41f3a0c6))
- Improve error detection for 'already exists' errors ([b2f715bcf542](https://github.com/BTCDecoded/blvm-protocol/commit/b2f715bcf542a58064d0ce198419b29b406b3803))
- Fix version check to use cargo index in Determine version step ([00120f923b00](https://github.com/BTCDecoded/blvm-protocol/commit/00120f923b00e4e1dc15066bfcb277eca4acc35b))
- Improve version check in Determine version step ([bcb170f0dbad](https://github.com/BTCDecoded/blvm-protocol/commit/bcb170f0dbad1089bc28871e8c167e0f3d0e5659))

## [v0.1.5] - 2025-11-24

### Reconstructed

- Optimize test execution: run tests once with coverage ([d2c3830fb52a](https://github.com/BTCDecoded/blvm-protocol/commit/d2c3830fb52adc397918af3ef301b01dfb101675))

## [v0.1.6] - 2025-11-25

### Reconstructed

- feat: Add FIBRE protocol definitions and packet format ([2f0ec5264a40](https://github.com/BTCDecoded/blvm-protocol/commit/2f0ec5264a40a407dbf2c8e4b6c8dbd17612a91c))
- Fix clippy to exclude tests (standard practice) ([db314b840a7b](https://github.com/BTCDecoded/blvm-protocol/commit/db314b840a7b18593e3980f51e2c92a6467edf08))
- Fix clippy warnings in library code (fibre.rs, lib.rs) ([8f897931c6f4](https://github.com/BTCDecoded/blvm-protocol/commit/8f897931c6f4a6d285de87a6464256670d5996a7))
- Refactor: Use .cargo/config.toml for local dependencies instead of [patch.crates-io] ([bdc4892c5cad](https://github.com/BTCDecoded/blvm-protocol/commit/bdc4892c5cadbd4a0549e0a303257f260d21e503))

## [v0.1.7] - 2026-04-22

### Reconstructed

- Add comprehensive protocol enhancements (Phases 1-3) ([14779678d05a](https://github.com/BTCDecoded/blvm-protocol/commit/14779678d05a3ba0d3955b33944438500881e6c5))
- Fix compilation: temporarily disable wire format module ([6a0ba7af31e3](https://github.com/BTCDecoded/blvm-protocol/commit/6a0ba7af31e36c7acfcab92653af15f9cc0988c4))
- Fix varint error handling - use Serialization error variant ([526aac772081](https://github.com/BTCDecoded/blvm-protocol/commit/526aac7720817036612d020bddf7edaed7bdca51))
- Update README and add convenience re-exports ([f58de1d3c83a](https://github.com/BTCDecoded/blvm-protocol/commit/f58de1d3c83a2ae5c56e50585bcebca77921ab11))
- Add integration status documentation ([8bdf37f628a4](https://github.com/BTCDecoded/blvm-protocol/commit/8bdf37f628a4be6fcab5d28e9ec1f0abaffb2cb2))
- Improve README timelessness and add test coverage analysis ([89614d3e503c](https://github.com/BTCDecoded/blvm-protocol/commit/89614d3e503c1e2aec6e9acc1996cbac63ba9fa5))
- Optimize network message handling with Arc and pre-allocation ([dcd3a956cf85](https://github.com/BTCDecoded/blvm-protocol/commit/dcd3a956cf8512a189aa0f3d19f171cb84444221))
- docs: remove working documents and improve timelessness ([f8ed8ea6edb5](https://github.com/BTCDecoded/blvm-protocol/commit/f8ed8ea6edb536c8099809b05407b02a8459e0df))
- feat: implement protocol validation integration and unified error handling ([bf7c12ba713f](https://github.com/BTCDecoded/blvm-protocol/commit/bf7c12ba713fce8d4cbce6aed2632678d1bac0fd))
- Update coverage workflow to manual-only ([5839fd89c041](https://github.com/BTCDecoded/blvm-protocol/commit/5839fd89c041ef78ef894e955e408b052b445e19))
- Format code and update dependencies ([2503a7f420c4](https://github.com/BTCDecoded/blvm-protocol/commit/2503a7f420c42c7044a2d8872b5fccde901a8216))
- Resolve merge conflict: use ProtocolError type ([0e269db44136](https://github.com/BTCDecoded/blvm-protocol/commit/0e269db44136793151a1066ec84842d1e5e73d80))
- Add Current Implementation Status section to README ([33447a777cbf](https://github.com/BTCDecoded/blvm-protocol/commit/33447a777cbf992599f806a8c283dc19be19a984))
- Add comprehensive test coverage for economic parameters, genesis blocks, and service flags ([85036fb31927](https://github.com/BTCDecoded/blvm-protocol/commit/85036fb319279bcbdf00905860c0c4bb753b10c3))
- Add comprehensive test coverage for wire format, FIBRE, and varint ([8b4c315d0c7a](https://github.com/BTCDecoded/blvm-protocol/commit/8b4c315d0c7a160e3bb1698230dd515bdf4d84e6))
- Add edge case tests for payment protocol and variants ([33a51b7cf0c2](https://github.com/BTCDecoded/blvm-protocol/commit/33a51b7cf0c2cd604e3016a7d05e2837ad716726))
- Update documentation: 6-tier architecture ([a12d440148c6](https://github.com/BTCDecoded/blvm-protocol/commit/a12d440148c6f33ca7afb02c54150aeb174e3d40))
- docs: apply documentation standards - imperative mood, timeless language ([6f40e852d684](https://github.com/BTCDecoded/blvm-protocol/commit/6f40e852d6841cfee46372f9394b81977a233097))
- feat: Add Bitcoin P2P wire format serialization for NetworkAddress ([1d1e2910301e](https://github.com/BTCDecoded/blvm-protocol/commit/1d1e2910301eadac928dfdf0029729aad381cea3))
- feat: Add economic node governance messages via P2P protocol ([f373dadd5708](https://github.com/BTCDecoded/blvm-protocol/commit/f373dadd57087f8013c14f50c202f53debb17aba))
- refactor: Rename from bllvm-protocol to blvm-protocol ([38dbbf15fb10](https://github.com/BTCDecoded/blvm-protocol/commit/38dbbf15fb101742744d843c4081122873c6e2e5))
- docs: consolidate CONTRIBUTING.md, link to blvm-docs ([a9c978b398d6](https://github.com/BTCDecoded/blvm-protocol/commit/a9c978b398d69046ce6cf7967a5ea3253c9b8f76))
- refactor(spam-filtering): add top-level spam_filter re-export ([ea9308c508da](https://github.com/BTCDecoded/blvm-protocol/commit/ea9308c508da28b00f1a10d01270266e13178236))
- feat: Enhance protocol validation, error handling, and network params ([5436e8a4b6d5](https://github.com/BTCDecoded/blvm-protocol/commit/5436e8a4b6d59e5e0f6ba0fc8a4a034177cb5507))
- Update dependencies and fix compilation issues ([6de5e383697c](https://github.com/BTCDecoded/blvm-protocol/commit/6de5e383697c9cd9bbaf15a26bbba084271680c2))
- Fix bllvm_consensus to blvm_consensus reference ([522b2db2cb3d](https://github.com/BTCDecoded/blvm-protocol/commit/522b2db2cb3d8369adfdf8743be0ab69536f6d18))
- feat: add network_time parameter to connect_block call ([028d620ca2f3](https://github.com/BTCDecoded/blvm-protocol/commit/028d620ca2f3d354ef068b4b12b139e673f3b143))
- Implement BIP155 (addrv2) and BIP324 (v2 encrypted transport) ([17fd983f1651](https://github.com/BTCDecoded/blvm-protocol/commit/17fd983f1651c554d209034cb1d565ba990f0bcc))
- docs: fix README naming and remove outdated references ([6c1a51594928](https://github.com/BTCDecoded/blvm-protocol/commit/6c1a5159492868ec495dbea7dccbb3e9514dac47))
- Fix Bitcoin wire protocol serialization for IBD messages ([15115e337722](https://github.com/BTCDecoded/blvm-protocol/commit/15115e3377227ab8058431f45a1bc97edcfbcf6c))
- feat: UtxoSet API, GetData wire serialization, profile feature ([31c765055c8a](https://github.com/BTCDecoded/blvm-protocol/commit/31c765055c8ad5991d1bb3bcc8b61aabb0b13439))
- feat: UtxoSet API, GetData wire serialization, profile feature ([5c05ebe8dadc](https://github.com/BTCDecoded/blvm-protocol/commit/5c05ebe8dadce82f014df390d1947dd50bdd8909))
- refactor: update tests and protocol components ([340c41db9bca](https://github.com/BTCDecoded/blvm-protocol/commit/340c41db9bcaf4af112423512d66bb51e0ed9b4f))
- refactor(protocol): retire v2 transport; local wire framing; commitments and spam filter here ([f00c0033c470](https://github.com/BTCDecoded/blvm-protocol/commit/f00c0033c4702aa22bf52386e9171bf31de024c8))
- chore(protocol): sync lib and feature registry tests ([0ef2e5a21a2b](https://github.com/BTCDecoded/blvm-protocol/commit/0ef2e5a21a2be74791b88b6057084589f382cef6))
- style: rustfmt ([e82c3ba0f7fd](https://github.com/BTCDecoded/blvm-protocol/commit/e82c3ba0f7fde8be6784dfa1fa860926445d47c3))
- chore: stop tracking Cargo.lock; align CI for manifest-only lockfiles ([a0fed5fc33b1](https://github.com/BTCDecoded/blvm-protocol/commit/a0fed5fc33b19357947860359ee633353cb7c733))
- ci: BTCDecoded/rust-ci composites and install-rust-toolchain ([1c18b410399a](https://github.com/BTCDecoded/blvm-protocol/commit/1c18b410399a8f1a106618d3493fd18eea2298ed))
- test: host UTXO commitments integration tests in blvm-protocol ([77f65a4cbd49](https://github.com/BTCDecoded/blvm-protocol/commit/77f65a4cbd49a75c80cf600727925d197b07e07f))
- test: UTXO commitment hardening and production UtxoSet test alignment ([58dc9d0e17da](https://github.com/BTCDecoded/blvm-protocol/commit/58dc9d0e17da0fe13c22da3e2aa190a4f93eff14))
- fix(ci): clippy dead_code, rustfmt, and cargo-audit PATH ([82dac95fbae3](https://github.com/BTCDecoded/blvm-protocol/commit/82dac95fbae38f444a44a71eb9a6362db2bb5f90))
- fix(ci): update only [package] version in release Cargo.toml edits ([6ae04d327a74](https://github.com/BTCDecoded/blvm-protocol/commit/6ae04d327a74fa89207f261f1b937c37c1863a20))
- deps: smallvec 1.15.1 for hyper stack; vendor Orange Paper stub ([00a5d04ac443](https://github.com/BTCDecoded/blvm-protocol/commit/00a5d04ac4438ced050cfdef8db034c3e87b75f4))
- feat(p2p): F2 TCP v1 framed P2P in node_tcp + wire split ([d08b255c0148](https://github.com/BTCDecoded/blvm-protocol/commit/d08b255c01480942e4e19f77e811001bce72cbd8))
- ci(verify): inline blvm-spec clone (rust-ci/setup-blvm-spec not on GitHub) ([4f4e55045e58](https://github.com/BTCDecoded/blvm-protocol/commit/4f4e55045e58f593d9ac477508b0cd9ada1cf38e))
- Revert "ci(verify): inline blvm-spec clone (rust-ci/setup-blvm-spec not on GitHub)" ([2016342e651e](https://github.com/BTCDecoded/blvm-protocol/commit/2016342e651edd7ec5a083a22f52dbe45e5409ad))
- fix(protocol): IBD block context shim uses from_connect_block_ibd_args ([e821567a389d](https://github.com/BTCDecoded/blvm-protocol/commit/e821567a389d60a495211d8379bf9cf00090b7e2))
- fix(ci): config test + clippy for p2p frame and TcpFramedParser ([c7a26aa53beb](https://github.com/BTCDecoded/blvm-protocol/commit/c7a26aa53bebd7ae9115fde7d9a1cdb8def41abd))
- fuzz: add protocol fuzz crate and shard CI smoke runs ([9214f9f5800d](https://github.com/BTCDecoded/blvm-protocol/commit/9214f9f5800d71eded5ce963e25e35d1ac2671ea))
- feat(network)!: remove economic-node P2P messages and wire paths ([ddde3747afd4](https://github.com/BTCDecoded/blvm-protocol/commit/ddde3747afd4a4a53f03c606f1daf92f4a6f84ad))
- fix(protocol): clippy all-targets, public serialize_block ([56a0cc8f24e6](https://github.com/BTCDecoded/blvm-protocol/commit/56a0cc8f24e65648140fb08b485d05fa01cb650b))
- fix(protocol): UTXO commitment 88-byte wire and correct block header hash ([bea867b612d9](https://github.com/BTCDecoded/blvm-protocol/commit/bea867b612d9f9e12d1fb580b9cb0715b7142eb4))
- fix(ci): repair coverage + mempool default test for crates.io split ([5dccf7939383](https://github.com/BTCDecoded/blvm-protocol/commit/5dccf793938397ac25cc7422f7e219f8555ded2d))
- chore: remove vendored blvm-spec; #[spec_locked] is a compile-time no-op when spec absent ([911c33c25a27](https://github.com/BTCDecoded/blvm-protocol/commit/911c33c25a27d12c8060caf6077cc3bc31fbd813))

## [v0.1.8] - 2026-05-09

### Reconstructed

- fuzz: path parent protocol, crates.io consensus; trim CI sibling checkouts [skip ci] ([864253816d1a](https://github.com/BTCDecoded/blvm-protocol/commit/864253816d1a9a46503a8cf18d451bc8fe3fada3))
- fuzz: add [patch.crates-io] mirroring root for local dev [skip ci] ([d656b98c391a](https://github.com/BTCDecoded/blvm-protocol/commit/d656b98c391a57c0dbd1e78031e05037b2e79114))
- docs(security): use security@thebitcoincommons.org for disclosures ([2eb8827a420f](https://github.com/BTCDecoded/blvm-protocol/commit/2eb8827a420fbee18c26967da37cb27786c5fc8b))
- ci: fetch version list once from crates.io instead of per-iteration API calls [skip ci] ([a72c12c8dc32](https://github.com/BTCDecoded/blvm-protocol/commit/a72c12c8dc3203d0b09cbfae486044fb3c197e0e))
- migrate payment.rs and v2_transport.rs to blvm-secp256k1 ([e5115a60dbf3](https://github.com/BTCDecoded/blvm-protocol/commit/e5115a60dbf3b8cfb3bc1e26815750eb5e840094))
- deps: gate BIP324 crypto deps behind bip324 feature; pin hex to =0.4.3 ([d532c30e98d6](https://github.com/BTCDecoded/blvm-protocol/commit/d532c30e98d6e3fc1ed3f16426ebd4f76962e3bb))
- fix: gate bip324/v2_transport by architecture as well as feature ([85e87ecb5657](https://github.com/BTCDecoded/blvm-protocol/commit/85e87ecb5657ce7dab46fd2bc0b147336b7d473f))
- style: cargo fmt ([2c89718e8349](https://github.com/BTCDecoded/blvm-protocol/commit/2c89718e8349ff0379a0451061621e1ab7e70d90))
- chore: drop heavyweight unused dev-dependencies ([2706fddfe2b6](https://github.com/BTCDecoded/blvm-protocol/commit/2706fddfe2b65e81be53cae80276757ec6e0f1e5))
- docs: README, governance stubs, bench paths, testnet compose [skip_ci] [skip ci] ([eeddd46ca346](https://github.com/BTCDecoded/blvm-protocol/commit/eeddd46ca346a8dd826a6d87f6398028c9906f23))

## [v0.1.9] - 2026-05-12

### Reconstructed

- ci: split test compile from run to diagnose blank Error: ([5edf647d819c](https://github.com/BTCDecoded/blvm-protocol/commit/5edf647d819c499f7516ab48436b8ff5cccd0b8d))
- fix(tests): replace secp256k1 crate with blvm_secp256k1 in payment_protocol_tests ([e6a741760719](https://github.com/BTCDecoded/blvm-protocol/commit/e6a741760719d5c24167f7da2be81d5259991d76))
- test: use blvm-secp256k1 in BIP70 tests; drop secp256k1 crate ([1c345c044750](https://github.com/BTCDecoded/blvm-protocol/commit/1c345c0447500216bef3353f6dc0fbb462696f80))
- chore(tests): use [u8; 33] for merchant pubkey in payment_protocol_tests ([1ef431e4060f](https://github.com/BTCDecoded/blvm-protocol/commit/1ef431e4060fd9a76da1f1b952282d79f7826ef3))
- ci(verify): skip Z3/clang install when present; use sudo -n ([e537bfb762bf](https://github.com/BTCDecoded/blvm-protocol/commit/e537bfb762bfc892787e69fa92119abdc4c45739))
- ci(verify): assume Z3/clang pre-installed on runner; drop sudo install ([bc7c7c0bd9ef](https://github.com/BTCDecoded/blvm-protocol/commit/bc7c7c0bd9ef5e44d5592b408e2a0741175f3118))
- ci(fuzz): use workspace fuzz/target on persistent single runner; keep /tmp stash as fallback ([16194d3ddee1](https://github.com/BTCDecoded/blvm-protocol/commit/16194d3ddee1041ef4b9c9e7d8d8084ecc04b073))
- ci(fuzz): replace 8-shard matrix with single parallel job using xargs -P$(nproc) ([077e599827bc](https://github.com/BTCDecoded/blvm-protocol/commit/077e599827bc28372c9b6cd6f88cadb95ee0cd10))

## [v0.1.10] - 2026-05-15

### Reconstructed

- ci: merge fuzz-build into fuzz job ([3d150bf15abe](https://github.com/BTCDecoded/blvm-protocol/commit/3d150bf15abec318fcf90b4b70b8d06a8e6f9963))
- Remove FIBRE wire types from the protocol crate. ([6f1c9fadbc96](https://github.com/BTCDecoded/blvm-protocol/commit/6f1c9fadbc96056466dd59eddc981427ac17ffff))

## [v0.1.11] - 2026-05-17

### Reconstructed

- ci(release): derive next patch from max used version ([173402d4f217](https://github.com/BTCDecoded/blvm-protocol/commit/173402d4f217e045cb7520418bb877465e9fddba))
- ci: scope runner cargo cache under /tmp/runner-cache/<repository> ([79ab0d7b4377](https://github.com/BTCDecoded/blvm-protocol/commit/79ab0d7b43779fb05f9257e04b6eb4295cbb5152))

## [v0.1.12] - 2026-05-17

### Reconstructed

- ci(protocol): extend CI fuzz hooks and documentation ([7916e96cc9cf](https://github.com/BTCDecoded/blvm-protocol/commit/7916e96cc9cf4bbced4e6379914b312fbe640bca))

## [v0.1.13] - 2026-05-27

### Reconstructed

- feat(ci): publish-dev and develop-chain for coordinated dev releases ([333ced3b7bb3](https://github.com/BTCDecoded/blvm-protocol/commit/333ced3b7bb37f3fb1f53f4106f1f75860406bee))
- fix(protocol): network-aware validate_block and block weight check ([2cfad37d1a25](https://github.com/BTCDecoded/blvm-protocol/commit/2cfad37d1a257a66663a1896cda165721dfd9a83))

## [v0.1.14] - 2026-05-27

### Reconstructed

- fix(protocol): BIP9 activation, feature registry, and CI bumps [no ci] ([42ca371c9210](https://github.com/BTCDecoded/blvm-protocol/commit/42ca371c921065016d9d685a10f425fbb47d8e8c))

## [v0.1.15] - 2026-05-28

### Reconstructed

- fix(protocol): wire block witness round-trip, BIP141 weight, TimeContext ([de86425b3ae8](https://github.com/BTCDecoded/blvm-protocol/commit/de86425b3ae8fe1797da360ad2753270736e7021))

## [v0.1.16] - 2026-06-04

### Reconstructed

- fix(protocol): spec-lock drift for UTXO/P2P witnesses and refresh CI spec ([58ec539138a5](https://github.com/BTCDecoded/blvm-protocol/commit/58ec539138a55f8a25f7626b65fc2c69e917a335))

## [v0.1.17] - 2026-06-16

### Reconstructed

- chore: MSRV 1.85, edition 2024, and clippy fixes ([135c6bb22259](https://github.com/BTCDecoded/blvm-protocol/commit/135c6bb222598146d68d129531c927dc358b94e0))

## [v0.1.18] - 2026-06-17

### Reconstructed

- chore: MSRV 1.85, edition 2024, and clippy fixes ([486bc4fd9f8f](https://github.com/BTCDecoded/blvm-protocol/commit/486bc4fd9f8f0b935beaf619d2933d7d0eb2a0ee))

## [v0.1.19] - 2026-06-18

### Reconstructed

- feat(protocol): ProtocolVersion::Signet and connect_block validation context ([4595deb896c0](https://github.com/BTCDecoded/blvm-protocol/commit/4595deb896c0bce16743ca8f9bb38dc2732097e8))

## [v0.1.20] - 2026-06-24

### Reconstructed

- ci(release): push tags with GITHUB_TOKEN and workflows permission ([43856839241d](https://github.com/BTCDecoded/blvm-protocol/commit/43856839241d425be30599c7817a329da293cec9))
- ci(release): create tags via GitHub Release API, not git push ([553fa245e52e](https://github.com/BTCDecoded/blvm-protocol/commit/553fa245e52e90f3cbacf18bbaec59d471012d20))
- Revert "ci(release): create tags via GitHub Release API, not git push" ([b8dbdcfbc0d3](https://github.com/BTCDecoded/blvm-protocol/commit/b8dbdcfbc0d30d47b0cdfd5972303d2dd9c16c43))
- Revert "ci(release): push tags with GITHUB_TOKEN and workflows permission" ([ac96528c288a](https://github.com/BTCDecoded/blvm-protocol/commit/ac96528c288a2fdd60b872e9f1eb307a31506efd))
- ci(release): push release tags with REPO_ACCESS_TOKEN ([8a0e0565eec6](https://github.com/BTCDecoded/blvm-protocol/commit/8a0e0565eec69d610786f1c6fda21e027463b6ee))
- fix(protocol): witness-aware validation, spam filter, and utxo commitment sync ([a38bf4271ccc](https://github.com/BTCDecoded/blvm-protocol/commit/a38bf4271ccca5ae4101d57154fe61b7996a74cd))

## [v0.1.21] - 2026-08-19

### Reconstructed

- peel: protocol comment-only service_flags and spam_filter (S2) ([55e9588047b1](https://github.com/BTCDecoded/blvm-protocol/commit/55e9588047b1b5e3d249b4a13380228b473b9083))
- fix(ci): disable secp CUDA auto-link when building libFuzzer binaries. ([f1f9cb0c1872](https://github.com/BTCDecoded/blvm-protocol/commit/f1f9cb0c1872645167fa1c0b4863f62732281653))

## [v0.1.22] - 2026-09-22

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.23] - 2026-10-04

### Reconstructed

- test(spam_filter): UnexecIf / NullDataOp13 / DataLikeMs template labels ([b34852d26dc1](https://github.com/BTCDecoded/blvm-protocol/commit/b34852d26dc1fbe361e03656e46396bfac65d105))
- feat(spam): filter UnexecIf, OP_13 null-data, magic prefixes, and data-like multisig ([7054f260b6b4](https://github.com/BTCDecoded/blvm-protocol/commit/7054f260b6b4c51194d272c8aa7f540ef00bdd6c))

## [v0.1.24] - 2026-10-05

### Reconstructed

- fix(ci): a regtest coinbase must carry the height and a later time ([e6403a8c1268](https://github.com/BTCDecoded/blvm-protocol/commit/e6403a8c1268416399a606749f57f4f927b5d024))

## [v0.1.25] - 2026-10-05

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.26] - 2026-10-06

### Reconstructed

- fix(protocol): thread the difficulty ancestor into connect ([6901ee6296a8](https://github.com/BTCDecoded/blvm-protocol/commit/6901ee6296a801d6fd8e41420ffa40399d6a611e))
- ci(protocol): test the feature set the fuzz job already builds ([8083f561e5e1](https://github.com/BTCDecoded/blvm-protocol/commit/8083f561e5e17104adde7747dcc735ac06496e60))
- style(protocol): allow the difficulty-ancestor connect argument ([5215d2b2a781](https://github.com/BTCDecoded/blvm-protocol/commit/5215d2b2a781783f3e547eb5e417b9ea5f4769c6))

## [v0.1.27] - 2026-10-06

### Reconstructed

- ci(protocol): drop the production-only test pass ([c7586ea01fb0](https://github.com/BTCDecoded/blvm-protocol/commit/c7586ea01fb0f251929ca6ff66cbb576a72047d1))

## [v0.1.28] - 2026-10-06

### Reconstructed

- fix(ci): use REPO_ACCESS_TOKEN for release tags when workflows change ([7cf5c53820df](https://github.com/BTCDecoded/blvm-protocol/commit/7cf5c53820df86f5d14b2b775e59eda739da4953))

## [v0.1.29] - 2026-10-07

### Reconstructed

- feat(protocol): add testnet4 genesis, params, and features ([c4c406ca04ba](https://github.com/BTCDecoded/blvm-protocol/commit/c4c406ca04baad03c11cd44b1033546dda6983aa))
- fix(protocol): count testnet4 in the protocol variant list ([ee5235572bfb](https://github.com/BTCDecoded/blvm-protocol/commit/ee5235572bfb891555f07d40b5ed4f59ecd45e60))
- fix(protocol): encode BIP34 heights 1 through 16 as OP_1 through OP_16 in tests ([3395c1696928](https://github.com/BTCDecoded/blvm-protocol/commit/3395c169692866d42a200267fb3a414bad432a27))

## [v0.1.30] - 2026-10-08

### Reconstructed

- fix(protocol): take genesis blocks and halving intervals from consensus ([3141a94bddcf](https://github.com/BTCDecoded/blvm-protocol/commit/3141a94bddcf3ce5cdb519bd97f7fa7fd31fbce8))

## [v0.1.31] - 2026-10-09

### Reconstructed

- fix(protocol): keep witness stacks on a tx message ([ed493b082b12](https://github.com/BTCDecoded/blvm-protocol/commit/ed493b082b12f030dd050671366dc02db5b02c8c))
- fix(protocol): carry compact-block witnesses and address time ([b4d4bc7797a1](https://github.com/BTCDecoded/blvm-protocol/commit/b4d4bc7797a1174bfb3a183d4da03a3b74a11b31))
- style(protocol): format the compact-block prefilled transaction ([2948546ae0a7](https://github.com/BTCDecoded/blvm-protocol/commit/2948546ae0a73d8042b7b8023e11c144b79dcd2b))
- test(protocol): reject a getblocktxn index past the end of the block ([8e6d6e5ce395](https://github.com/BTCDecoded/blvm-protocol/commit/8e6d6e5ce3956b5721e16256823000aa47b5075d))

## [v0.1.32] - 2026-10-10

### Reconstructed

- fix(protocol): drop the 10000-transaction block cap ([3d2ad99396cb](https://github.com/BTCDecoded/blvm-protocol/commit/3d2ad99396cb2fca2cc0557b7a76cf48b114fca1))
- fix(protocol): accept a blocktxn through 50,000 transactions ([11f323f24b6f](https://github.com/BTCDecoded/blvm-protocol/commit/11f323f24b6f8e989006a9af215ccdca21c5330f))
- style(protocol): order imports the way CI rustfmt does ([f838d3033b78](https://github.com/BTCDecoded/blvm-protocol/commit/f838d3033b7863f70b1036db3d97168c8c1b2de0))

## [v0.1.33] - 2026-10-18

### Reconstructed

- test(protocol): lock feature activation and filter round trips ([20e6394ad85f](https://github.com/BTCDecoded/blvm-protocol/commit/20e6394ad85f38dffe5a99685c9b1ad23a05b744))
- ci(protocol): install the current spec-lock before verify ([dc9ef8813a94](https://github.com/BTCDecoded/blvm-protocol/commit/dc9ef8813a94a8738dcfa519262ff043d18df045))

## [v0.1.34] - 2026-10-19

### Reconstructed

- fix(protocol): reconstruct compact blocks and answer ban and UTXO messages ([9460987d2f45](https://github.com/BTCDecoded/blvm-protocol/commit/9460987d2f45d79ba0c9a0053e1e712f01cab5b6))
- test(protocol): expect a reconstructed compact block ([2dfa900f1ca4](https://github.com/BTCDecoded/blvm-protocol/commit/2dfa900f1ca48280bd50d4474aabedf11b489076))

## [v0.1.35] - 2026-10-20

### Reconstructed

- fix(protocol): reject a version-0 witness program of the wrong length ([5b8a154ce26d](https://github.com/BTCDecoded/blvm-protocol/commit/5b8a154ce26dbea2e5894e21020f5cec731e3c63))

## [v0.1.36] - 2026-10-21

### Reconstructed

- fix(protocol): count witness framing in the block weight ([261117d7bf75](https://github.com/BTCDecoded/blvm-protocol/commit/261117d7bf752cf00f9fb59f037d962a26a4d187))
- test(protocol): mine the empty-UTXO connect header ([bd8757eb1423](https://github.com/BTCDecoded/blvm-protocol/commit/bd8757eb1423c08d5989c3a727be61f730865fb6))
- test(protocol): mine headers before connect in the integration suite ([72e7dfa34b98](https://github.com/BTCDecoded/blvm-protocol/commit/72e7dfa34b98cfc06db5ccdc800951f989a81c84))
- test(protocol): mine the coinbase header in the commitment round trip ([b34a6a90a2f4](https://github.com/BTCDecoded/blvm-protocol/commit/b34a6a90a2f43558008cfbfd67ad734c38c357f3))

## [v0.1.37] - 2026-10-22

### Reconstructed

- chore: sync package version with crates.io (0.1.33); commit Release version bump ([e8d619bfdcd7](https://github.com/BTCDecoded/blvm-protocol/commit/e8d619bfdcd7974c98e99cb1ac1b215525454203))
- ci: run PR checks ([408f53555ebf](https://github.com/BTCDecoded/blvm-protocol/commit/408f53555ebf1ef7966e8bc1ee538c7865fdf1b8))
- test(protocol): mine regtest proof of work for block connect fixtures ([adfd496a778b](https://github.com/BTCDecoded/blvm-protocol/commit/adfd496a778b7746474ca4ce16d5b5093176f75f))
- style(protocol): rustfmt the hardening test imports ([8b0f4418f739](https://github.com/BTCDecoded/blvm-protocol/commit/8b0f4418f73957bccfd2a9a9d1e72de5c09f426c))
- test(protocol): re-mine header in merkle-root rejection test ([a5a6e819b8d9](https://github.com/BTCDecoded/blvm-protocol/commit/a5a6e819b8d97c95bff807ea56b2241b12da6203))
- style(protocol): restore edition-2024 import order in protocol_integration ([0d3f37e3c2a4](https://github.com/BTCDecoded/blvm-protocol/commit/0d3f37e3c2a4d2343745903da6964af931918007))
- fix(protocol): use Bitcoin Core's default signet magic 0a03cf40 ([c72c298ef89b](https://github.com/BTCDecoded/blvm-protocol/commit/c72c298ef89b0a9fd61abed5fcf8dab2656698a0))
- Bump version to 0.1.37 for release [skip ci] ([43bbadbfd023](https://github.com/BTCDecoded/blvm-protocol/commit/43bbadbfd023ed5537a4f5ff8c04ce00c060dea5))

## [v0.1.38] - 2026-10-24

### Reconstructed

- fix(protocol): build compact filters from borrowed scripts ([7bed68543664](https://github.com/BTCDecoded/blvm-protocol/commit/7bed68543664fc8de25791850f72ef3d2eb5a8e4))
- style(protocol): cargo fmt after 7bed685 ([54f33df4304f](https://github.com/BTCDecoded/blvm-protocol/commit/54f33df4304f3e1154a44b898204fe6daaa1a140))
- fix(protocol): drop needless borrow in BRC-20 JSON check (clippy) ([a4cb8c8203a4](https://github.com/BTCDecoded/blvm-protocol/commit/a4cb8c8203a44aad5db5cbf858a700f761379dbe))
- Bump version to 0.1.38 for release [skip ci] ([f10592fbc894](https://github.com/BTCDecoded/blvm-protocol/commit/f10592fbc8947cf250ee08c2b16c5abd4e437c8e))

## [v0.1.39] - 2026-10-24

### Reconstructed

- Bump version to 0.1.39 for release [skip ci] ([a1ed328e3a22](https://github.com/BTCDecoded/blvm-protocol/commit/a1ed328e3a227d7c10fdcc08dcdbb511faf2ad59))

## [v0.1.40] - 2026-11-05

### Reconstructed

- ci(protocol): verify with spec-lock 0.1.45 ([d71197e825a4](https://github.com/BTCDecoded/blvm-protocol/commit/d71197e825a4e09f1c16f25be5ea0c829f78cb0b))
- docs: call this crate a BLVM tier and point links at the documentation host ([82ef8efb14b5](https://github.com/BTCDecoded/blvm-protocol/commit/82ef8efb14b542f22718cce86f6fcaab3e1cc0e0))
- Bump version to 0.1.40 for release [skip ci] ([58c1b41e5851](https://github.com/BTCDecoded/blvm-protocol/commit/58c1b41e5851a6cd2b0b3b1cc7867e22acf1b937))

## [v0.1.41] - 2026-11-05

### Reconstructed

- ci: install latest blvm-spec-lock again (drop 0.1.45 pin) ([454560e3264e](https://github.com/BTCDecoded/blvm-protocol/commit/454560e3264e02f5ba3dbd8de258e0b7b9653af3))
- ci(protocol): point spec-lock at the runner spec checkout ([b0e55504b420](https://github.com/BTCDecoded/blvm-protocol/commit/b0e55504b420cd3471a2aba3f05ad1748ded9be8))
- Bump version to 0.1.41 for release [skip ci] ([68e9336e70f1](https://github.com/BTCDecoded/blvm-protocol/commit/68e9336e70f17ac9358068a827e97411bf6db7fe))

## [v0.1.42] - 2026-11-06

### Reconstructed

- fix(protocol): reject malformed wire and keep a tx witness ([0e361b6d0e14](https://github.com/BTCDecoded/blvm-protocol/commit/0e361b6d0e14614d9ea7e2fc95885dc507070bba))
- Bump version to 0.1.42 for release [skip ci] ([756589cfbcc2](https://github.com/BTCDecoded/blvm-protocol/commit/756589cfbcc27b4673a7de6faf97f2b95759c8fc))

## [v0.1.43] - 2026-11-06

### Reconstructed

- Match compact-filter and v2 packet encodings to the published wire vectors. ([49036217175e](https://github.com/BTCDecoded/blvm-protocol/commit/49036217175eb5965808ab1726567dcb286ed6ce))
- Bump version to 0.1.43 for release [skip ci] ([401d383a731c](https://github.com/BTCDecoded/blvm-protocol/commit/401d383a731c825a6718033c1b1cd34f55739d4e))

## [v0.1.44] - 2026-11-07

### Reconstructed

- fix(protocol): match BIP152 version 2 short ids on the wtxid and keep the witness ([7dc13f692574](https://github.com/BTCDecoded/blvm-protocol/commit/7dc13f6925741c8fce1bfcfb9d0ef8a9f8fc30fc))
- fix(protocol): pin anyhow and lru to the patched releases ([45cade400d22](https://github.com/BTCDecoded/blvm-protocol/commit/45cade400d222e432adb163657eb002801bf2237))
- Stop pulling spec-lock into the default protocol build. ([7feb6648cae7](https://github.com/BTCDecoded/blvm-protocol/commit/7feb6648cae7a42bee9d762db2c0e741fc407878))
- fix(protocol): inline format arguments clippy rejects ([1a01b770112a](https://github.com/BTCDecoded/blvm-protocol/commit/1a01b770112a23bf6fe9aef4e289317b052ea3cc))
- Bump version to 0.1.44 for release [skip ci] ([69dd3bff7474](https://github.com/BTCDecoded/blvm-protocol/commit/69dd3bff7474bab0c27f5eddbfa99a20fae8907b))

## [v0.1.45] - 2026-11-08

### Reconstructed

- fix(protocol): match activation heights and reject malformed wire ([ccc361b1a343](https://github.com/BTCDecoded/blvm-protocol/commit/ccc361b1a343d1cb5e809754ac17e7756a98c341))
- fix(protocol): keep CSV and CLTV inactive at genesis ([1f649024eb7f](https://github.com/BTCDecoded/blvm-protocol/commit/1f649024eb7f3a59ab19938da8473453a5b7dbd8))
- Bump version to 0.1.45 for release [skip ci] ([42e182a2287b](https://github.com/BTCDecoded/blvm-protocol/commit/42e182a2287b04c808887727b7a9dceeb5e3d917))

## [v0.1.46] - 2026-11-10

### Reconstructed

- test: one witness stack per coinbase input ([73d4f271a32a](https://github.com/BTCDecoded/blvm-protocol/commit/73d4f271a32a418b5081dd431dde2ddb059500a3))
- Bump version to 0.1.46 for release [skip ci] ([299ae197cfbe](https://github.com/BTCDecoded/blvm-protocol/commit/299ae197cfbea9331556c2653ba2971c29b74539))

## [v0.1.47] - 2026-11-11

### Reconstructed

- fix(protocol): match compact-block short ids from one mempool pass ([aeb88a8639a2](https://github.com/BTCDecoded/blvm-protocol/commit/aeb88a8639a2aaff256d32f8a3e5a478f6ff42bd))
- Bump version to 0.1.47 for release [skip ci] ([1bbc6fb60f6a](https://github.com/BTCDecoded/blvm-protocol/commit/1bbc6fb60f6a5f874035bbfe3ca580d8d51d7404))

## [v0.1.48] - 2026-11-12

### Reconstructed

- refactor(protocol): move large test modules out of the implementation files ([f26aa3984435](https://github.com/BTCDecoded/blvm-protocol/commit/f26aa3984435c4a56ebe901904fae019ef2dadae))
- Bump version to 0.1.48 for release [skip ci] ([0bc9307a2235](https://github.com/BTCDecoded/blvm-protocol/commit/0bc9307a2235831fff52548621301b6084a9e809))
