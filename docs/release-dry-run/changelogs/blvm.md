# Changelog

All notable changes to `blvm` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Every section below is reconstructed from git history. Conventional Commits
were not enforced when those commits were written. Merge commits are omitted.

## [Unreleased]

## [v0.1.0-prerelease] - 2025-11-14

### Reconstructed

- Add unified build and release system for BTCDecoded ecosystem ([d928a06707e9](https://github.com/BTCDecoded/blvm/commit/d928a06707e92459c309af6cbde6fd5a47a36162))
- chore: Update documentation and configuration ([2622bb0a75bc](https://github.com/BTCDecoded/blvm/commit/2622bb0a75bc6e6531d2e82aed9287247bb28bac))
- feat: organize documentation and enhance build system ([4ec79b6df2f9](https://github.com/BTCDecoded/blvm/commit/4ec79b6df2f9de6a8677da43591176d2ad8a3660))
- Add workflow logs downloader script ([e90b371aacee](https://github.com/BTCDecoded/blvm/commit/e90b371aacee342098e276a7dd795b85261f51bf))
- Update repository references to new names (bllvm-*) ([dde2cc4867f9](https://github.com/BTCDecoded/blvm/commit/dde2cc4867f9beae01d5724bca33259c63f495ff))
- docs: Add reference to master status document ([7e0141a51639](https://github.com/BTCDecoded/blvm/commit/7e0141a516398e1bba57132a5bb1f05578c3b124))
- Fix release workflow: add tests, fix token, fix script args ([c7a8449ac106](https://github.com/BTCDecoded/blvm/commit/c7a8449ac1062754ddd1c54c429849fe34efe772))
- Auto-create tags if missing in setup-build-env.sh ([f8c332ffbf3d](https://github.com/BTCDecoded/blvm/commit/f8c332ffbf3d987cd93c9834f52fff499d619bcc))
- Fix release_orchestrator workflow: add missing permissions block ([027e7464df5c](https://github.com/BTCDecoded/blvm/commit/027e7464df5c566df31a5ff2c594ab1208474a51))
- Add missing permissions blocks to all reusable workflows ([939864f4d148](https://github.com/BTCDecoded/blvm/commit/939864f4d148d6ac6d4311ca1a8da89509ff9157))
- Fix release_orchestrator: add packages: write permission ([d851600f21a7](https://github.com/BTCDecoded/blvm/commit/d851600f21a702d1bb32cc10f1107a853827399f))
- Update all workflows to use self-hosted runners ([88246157715c](https://github.com/BTCDecoded/blvm/commit/88246157715cd3cceb0fe1414ce4a1964780c80d))
- Fix verify-consensus: set kani to false to avoid runner wait ([1a01f53a4b2c](https://github.com/BTCDecoded/blvm/commit/1a01f53a4b2c18822339e8e5e98b5c99c696d7c4))
- Fix: Use same runner for Kani verification, install Kani dynamically ([cd24d6018162](https://github.com/BTCDecoded/blvm/commit/cd24d601816290fbb94d61af64f696be1a61f7b8))
- Update all workflows to use self-hosted runners and REPO_ACCESS_TOKEN ([001a0d48d49f](https://github.com/BTCDecoded/blvm/commit/001a0d48d49fb9940bf516e80a938d8b60b92695))
- Fix runner label case sensitivity: use Linux/X64 to match runner labels ([8f0484158c2f](https://github.com/BTCDecoded/blvm/commit/8f0484158c2fccc291956a4fb76b995299035f06))
- Fix release workflow: replace deprecated actions-rs/toolchain and fix corrupted cc crate ([cd8fa1095c20](https://github.com/BTCDecoded/blvm/commit/cd8fa1095c2002409b6a5b275713f448480ec029))
- Fix corrupted openssl-sys dependency in release workflow ([91929469ba99](https://github.com/BTCDecoded/blvm/commit/91929469ba99f99308a18d8c642eae50a405add3))
- Comprehensive cargo registry cleanup to fix all corrupted dependencies ([63fb6d31b9fe](https://github.com/BTCDecoded/blvm/commit/63fb6d31b9fefca5b9d76b90c1cf10226c0a87e2))
- Make governance-app optional in release builds for Phase 1 prerelease ([3594ab0d5ba9](https://github.com/BTCDecoded/blvm/commit/3594ab0d5ba9345ceeca7bb9e17bc942ca1427b8))
- Skip doctests in release workflow for Phase 1 prerelease ([0d6465cf1708](https://github.com/BTCDecoded/blvm/commit/0d6465cf170816a17e42c6bc12b310cd1ae54715))
- Fix doctest exclusion: use --lib --bins --tests to skip doctests ([3a5153151b88](https://github.com/BTCDecoded/blvm/commit/3a5153151b88444a3d0ede1475ad92a78bd54792))
- Add timeouts to prevent hanging tests in release workflow ([32a28610539b](https://github.com/BTCDecoded/blvm/commit/32a28610539b5f5da5166df24bcf83db9c89fe4d))
- Add job-level timeout to release workflow ([2f2535dc187e](https://github.com/BTCDecoded/blvm/commit/2f2535dc187ed0f86922a6c3df7a43efe2aa9096))
- Always use latest main branch in Phase 1 prerelease to get bug fixes ([0e74c83ab8bc](https://github.com/BTCDecoded/blvm/commit/0e74c83ab8bc021c19c722f71c28281085d72021))
- Update clone section to also use latest main in Phase 1 ([9ac8bdf1092e](https://github.com/BTCDecoded/blvm/commit/9ac8bdf1092ec06314b38c15bbbf2e7df279ec0d))
- Fix syntax error: use 'fi' instead of '}' to close if statement ([3d82271a680d](https://github.com/BTCDecoded/blvm/commit/3d82271a680d1f3e845b324167bc1ea1d2436447))
- Make test step non-blocking for Phase 1 prerelease ([91d7e5945743](https://github.com/BTCDecoded/blvm/commit/91d7e594574360cd0f5eb67afdad6d8652b8809d))
- Revert: Test failures should block release ([115439c628fb](https://github.com/BTCDecoded/blvm/commit/115439c628fb571d5d004fb3ebc6f3caa78664f9))
- Skip problematic tests in CI environment only ([6e15c2b80804](https://github.com/BTCDecoded/blvm/commit/6e15c2b808049d232f32b90864781485d08951dd))

## [v0.2.0-prerelease] - 2025-11-18

### Reconstructed

- Add test output logging for better debugging in CI ([15b5285a46ff](https://github.com/BTCDecoded/blvm/commit/15b5285a46ffbdb25e789bf680bbdcadaebbe303))
- Document that bllvm-node is library-only (no binary) ([26a8ed8fdceb](https://github.com/BTCDecoded/blvm/commit/26a8ed8fdceb591142970f67774893558bd966c6))
- Add bllvm binary crate and update build system ([57cd13ad2ad7](https://github.com/BTCDecoded/blvm/commit/57cd13ad2ad7b008946821530575ac4f268f1bd4))
- Fix PARENT_DIR handling in setup-build-env.sh for GitHub Actions ([eb9175d860d2](https://github.com/BTCDecoded/blvm/commit/eb9175d860d25b4ede52c2d29aad9783482f6b1d))
- Fix workflow syntax: choice type not valid for workflow_call ([350630da58b7](https://github.com/BTCDecoded/blvm/commit/350630da58b7aff3a8b52fc6c2287545454fff6f))
- Initial commit: bllvm binary crate ([06256a5e86b1](https://github.com/BTCDecoded/blvm/commit/06256a5e86b1c12c5ca0ff7354ebf3358b3ae0d9))
- Add bllvm binary crate to commons repo ([9acf827ab2af](https://github.com/BTCDecoded/blvm/commit/9acf827ab2aff851bb9f690cb2e4f2f9b635f860))
- Fix clap version conflict: use same version as bllvm-node ([a7fd96fce240](https://github.com/BTCDecoded/blvm/commit/a7fd96fce240c05855a09eda73ffad9305777ac5))
- Align dependency versions with bllvm-node exact versions ([db81512c89f7](https://github.com/BTCDecoded/blvm/commit/db81512c89f7e03c062eb7623a735d52c487f582))
- Optimize build performance ([c4eabee1a13e](https://github.com/BTCDecoded/blvm/commit/c4eabee1a13ef7eb96bfb54d309aa32535392e32))
- Add runner performance optimization guide and auto-detect tools ([16295d3a757d](https://github.com/BTCDecoded/blvm/commit/16295d3a757d72527ca15f7dea60ca4bc7edca9b))
- Cleanup: Remove all sccache references and flatten commits ([d247256c675f](https://github.com/BTCDecoded/blvm/commit/d247256c675f495807afe17f74dd5b19f2ae144d))
- Docs: Add guide to remove sccache from runner ([94d4e19478be](https://github.com/BTCDecoded/blvm/commit/94d4e19478be89e5e8eeade893f2609e08c3d555))
- Fix: Add Debug derive to Network enum for logging ([c0ac756e4e05](https://github.com/BTCDecoded/blvm/commit/c0ac756e4e05dc369d09a83cb564698f8dfbff48))
- Fix: Ensure workflow uses latest code from all repos ([24a20b3a0344](https://github.com/BTCDecoded/blvm/commit/24a20b3a03445b10a44aee3c2aa7950e9128410e))
- Fix: Use tokio::select! instead of spawn to avoid Send trait issues ([8a8fedbbb8f4](https://github.com/BTCDecoded/blvm/commit/8a8fedbbb8f4e3111042f52175c1dd8a81206737))
- Fix: Use x86_64-pc-windows-gnu target for Windows cross-compilation on Linux ([b6d6fcbbcc8f](https://github.com/BTCDecoded/blvm/commit/b6d6fcbbcc8f3f2d49af3cc08832bf98ccaffb6f))
- Add CLI options and ENV support for advanced configuration ([8da91fe56804](https://github.com/BTCDecoded/blvm/commit/8da91fe5680413e08e4ffeec4b4758873facf2ea))
- Update README with comprehensive configuration and operation documentation ([b4e61e361f3a](https://github.com/BTCDecoded/blvm/commit/b4e61e361f3ae2dc2394a144b61ea5ea6cd37766))
- Add README validation report ([75c33e296243](https://github.com/BTCDecoded/blvm/commit/75c33e2962433cd946ede41d69a92fd6fa8831bb))
- Add verification bundle signing and release signing workflow ([361703ba8df4](https://github.com/BTCDecoded/blvm/commit/361703ba8df44b39adf59bb41bec6a26dbe927f3))
- Standardize runner labels across all workflows ([d77b6eec04c7](https://github.com/BTCDecoded/blvm/commit/d77b6eec04c7ac023f3f2207ba6d00730a3a6a49))
- Update scripts to use bllvm-commons instead of governance-app ([7986dfb2458d](https://github.com/BTCDecoded/blvm/commit/7986dfb2458dbc895465a546fad504e85eeb5269))
- Add comprehensive test coverage for bllvm system ([8cc8164af0fc](https://github.com/BTCDecoded/blvm/commit/8cc8164af0fc64c1e1d37e17037866b933343764))
- feat: Add base and experimental build variants ([e8ed70f5aa10](https://github.com/BTCDecoded/blvm/commit/e8ed70f5aa1026f9addfda055cab68d1958c27c9))
- feat: Improve Windows cross-compilation support ([2633501676ae](https://github.com/BTCDecoded/blvm/commit/2633501676aed923dd4a040ef9b1fb96234e5cb5))
- Add subcommands for node management and information queries ([09c17178f86f](https://github.com/BTCDecoded/blvm/commit/09c17178f86f88a8eb7688cd7d5eb69f7a8b1f78))
- Add unit tests for subcommands ([c159f4ed659b](https://github.com/BTCDecoded/blvm/commit/c159f4ed659b6557431bc1ce0e060521e25e3983))
- fix: correct workflow_call input types (choice not supported) ([707f5274cd3b](https://github.com/BTCDecoded/blvm/commit/707f5274cd3baf5a1730b24c0cbb3c3203e2da5d))
- fix: remove invalid choice type from workflow_dispatch inputs ([45666318aca5](https://github.com/BTCDecoded/blvm/commit/45666318aca5dba902f8fac081c7f3622c7d77cb))
- fix: only use production feature for repos that have it ([27907beb9622](https://github.com/BTCDecoded/blvm/commit/27907beb962281ebd21a83e7e70d5aa7aa7a4146))
- fix: use bllvm repo instead of commons (renamed), fix production feature for repos that don't have it ([2dcdec0038d3](https://github.com/BTCDecoded/blvm/commit/2dcdec0038d336d1df7f0bedcef79f79be5949bf))
- fix: handle outdated Cargo.lock in release builds ([fd20d2ec601a](https://github.com/BTCDecoded/blvm/commit/fd20d2ec601ae91d153fb22c7cf87002c2f5e472))
- fix: update Cargo.lock before using --locked flag ([778ac439318b](https://github.com/BTCDecoded/blvm/commit/778ac439318b2aa74aa52d35643d2bcf4ec05f10))
- fix: update Cargo.lock before using --locked in release mode ([04a329951538](https://github.com/BTCDecoded/blvm/commit/04a3299515389c47c9e5831b8dfe161e2e7f71ed))
- fix: ensure repos are fully synced with latest main before build ([fad74c104b1a](https://github.com/BTCDecoded/blvm/commit/fad74c104b1abdf0f9d66134d2a222c7fbedc20a))
- feat: add production feature to bllvm package ([e06768447724](https://github.com/BTCDecoded/blvm/commit/e06768447724614745a244988aa84e2de1b995fb))
- fix: add missing features and implement missing functions ([2b5b5d30b3b4](https://github.com/BTCDecoded/blvm/commit/2b5b5d30b3b417a596d524779f19824be6be9c32))
- fix: add iroh feature, fix borrow checker errors, fix node ownership ([a969dcacd058](https://github.com/BTCDecoded/blvm/commit/a969dcacd0582c687d82d6694ab9f59f1d3d3af3))
- fix: restore config parameter usage in feature flag functions ([c6ba3ba05d42](https://github.com/BTCDecoded/blvm/commit/c6ba3ba05d428426204916b8dfda2ad90a33a59b))
- fix: clone path in handle_config_validate call ([86fa146508fa](https://github.com/BTCDecoded/blvm/commit/86fa146508fa4f26501721e5f1581a61567859fe))
- fix: add ref to method in Rpc command, fix node ownership in error case ([4f4697277196](https://github.com/BTCDecoded/blvm/commit/4f46972771969a297e7197c54ca3e54cf62b83cd))
- fix: correct ctv feature mapping to pass through from bllvm-node ([c620327ff112](https://github.com/BTCDecoded/blvm/commit/c620327ff11209f81592a3f62ce10d6ac0c3e8a0))
- fix: add ctv feature to experimental builds for bllvm-protocol, bllvm-node, and bllvm ([eac135c3834d](https://github.com/BTCDecoded/blvm/commit/eac135c3834d37c5f281a92ebd9ec14e1340ae2b))
- fix: add ctv feature to Windows experimental builds in workflows ([c74f31255a66](https://github.com/BTCDecoded/blvm/commit/c74f31255a66d7fa502689e05cdabd804372cb69))
- feat: add iroh transport to experimental builds ([4f859eea3420](https://github.com/BTCDecoded/blvm/commit/4f859eea3420c53842fd966681ab0f6ad16f3529))
- improve: optimize rust-cache placement and configuration in prerelease workflow ([4c7dcdfaf8d9](https://github.com/BTCDecoded/blvm/commit/4c7dcdfaf8d9cdc4587fa2bb75a0c44f8630ddfe))
- improve: optimize rust-cache placement and fix input types in production release workflow ([609e7d0be754](https://github.com/BTCDecoded/blvm/commit/609e7d0be754dbdf1825711e988484a1a2b79c3e))
- fix: replace all commons references with bllvm in production release workflow ([0aa13989bfea](https://github.com/BTCDecoded/blvm/commit/0aa13989bfea62b2e37d0b9069b7f3b20f794f91))
- fix: replace COMMONS_DIR with BLLVM_DIR in prerelease workflow ([78e3cb60209a](https://github.com/BTCDecoded/blvm/commit/78e3cb60209a47f3bac2675dfcbc8179c0b37da0))
- fix: improve deterministic build verification and test compilation error handling ([bd53ce646503](https://github.com/BTCDecoded/blvm/commit/bd53ce6465037947920efbcdc7e9a1ef24720a3f))
- fix: rename archives to include version tag in create-release.sh ([81431e961ef3](https://github.com/BTCDecoded/blvm/commit/81431e961ef3754914bf0b9ee13655ac77a58b8f))

## [v0.3.0-prerelease] - 2025-11-18

### Reconstructed

- refactor: separate bllvm binary and governance tools into distinct archives, remove directory layer ([b3edd5ab508e](https://github.com/BTCDecoded/blvm/commit/b3edd5ab508e8981fee2c876269ff176fda19d3a))
- fix: update checksum validation for new archive structure ([021d14793c6c](https://github.com/BTCDecoded/blvm/commit/021d14793c6c64d8ef38e3f8b25bf1494db78443))
- fix: update checksum verification to work with new directory structure ([f1347d879878](https://github.com/BTCDecoded/blvm/commit/f1347d87987802b1e85ef585c13817a7d01a02d3))
- simplify: remove experimental variant for governance tools (they're the same regardless) ([19a12247a5b8](https://github.com/BTCDecoded/blvm/commit/19a12247a5b861365eacfb4bc21c2b9f1491df71))
- feat: publish individual binaries directly to release alongside archives ([d104ff29839e](https://github.com/BTCDecoded/blvm/commit/d104ff29839eed360fabe4162675dd5b255d8d20))
- fix: rename individual binaries to unique names before publishing to release ([8727ac1b4601](https://github.com/BTCDecoded/blvm/commit/8727ac1b4601b5a4dcbad09db1c09ea74bf3d941))
- fix: ensure checksum files are added to archives with correct paths, no duplication ([d54bc7c12592](https://github.com/BTCDecoded/blvm/commit/d54bc7c12592c079f729ac9bca2403d40e0c1e8e))
- docs: add comprehensive workflow debugging methodology guide ([4ce55eac6d3d](https://github.com/BTCDecoded/blvm/commit/4ce55eac6d3d4ef3140360f08ae766ac60be7b9d))
- fix: unset CC/CXX when ccache is not available to prevent build failures ([1674b420a343](https://github.com/BTCDecoded/blvm/commit/1674b420a34365cc06d791e465906a3c75df38ad))

## [v0.1.1] - 2026-05-07

### Reconstructed

- fix: make file patterns more specific to avoid duplicates and 404 errors ([a07ae7e15fb7](https://github.com/BTCDecoded/blvm/commit/a07ae7e15fb7a91d0a6d27e2e410825be0605f00))
- simplify: include governance tools in bllvm archives, remove separate governance archives and individual binaries ([64c91e3522be](https://github.com/BTCDecoded/blvm/commit/64c91e3522be92c130808071d66e1e21268b0482))
- fix: include governance tools in both bllvm and bllvm-experimental archives ([78333dc8ce42](https://github.com/BTCDecoded/blvm/commit/78333dc8ce421df40e7e6b465585dbdff751daaf))
- cleanup: remove all references to separate governance archives from release ([a3dc7cdc3616](https://github.com/BTCDecoded/blvm/commit/a3dc7cdc36164682f973f2947cb38a5d10c2ed34))
- fix: create both tar.gz and zip for all platforms, improve bllvm-commons collection logging ([98bbf36a897d](https://github.com/BTCDecoded/blvm/commit/98bbf36a897d4dd2f2368162dd923b37c0f90a0c))
- fix: always collect governance tools and add better logging for bllvm-commons inclusion ([d65d581b3cea](https://github.com/BTCDecoded/blvm/commit/d65d581b3cea62428129cb25037d579604694ac8))
- fix: improve MinGW detection to check /usr/bin path as fallback ([b8191deccdf0](https://github.com/BTCDecoded/blvm/commit/b8191deccdf04dcaa9eff094505b1744ed318648))
- fix: prevent duplicate Cargo config entries for Windows target ([7d73cf4a987b](https://github.com/BTCDecoded/blvm/commit/7d73cf4a987b10ad99a66c80b1f2539d52f83d6f))
- fix: properly indent heredoc content to fix YAML syntax error ([f39b6030e7c7](https://github.com/BTCDecoded/blvm/commit/f39b6030e7c736d4884310b75985812922395345))
- fix: use echo instead of heredoc to avoid YAML parsing issues ([5bb8597eccb6](https://github.com/BTCDecoded/blvm/commit/5bb8597eccb660dfad1e922b7c05b41c85bab680))
- fix: don't pass production feature to bllvm-sdk ([3ee38758671d](https://github.com/BTCDecoded/blvm/commit/3ee38758671ddf68e3b8e108888d76f114fabcca))
- fix: update Cargo.lock and add RUSTFLAGS for Windows builds ([31ab438d7be7](https://github.com/BTCDecoded/blvm/commit/31ab438d7be7ed062017f6975515a86809363d0c))
- fix: clean and regenerate Cargo.lock for Windows builds ([11c2f97fea36](https://github.com/BTCDecoded/blvm/commit/11c2f97fea368f587bde3436b91c1cd453439c0e))
- fix: use cargo update instead of removing Cargo.lock for Windows builds ([f790ae0d9f05](https://github.com/BTCDecoded/blvm/commit/f790ae0d9f059144667e8c34f25f32e403ad7226))
- fix: remove unnecessary cargo update step that was causing issues ([a2c466fa5e68](https://github.com/BTCDecoded/blvm/commit/a2c466fa5e68f7b6e278b05ab0f1a106ec1f92a6))
- fix: remove invalid patch.crates-io section for sha2-asm ([4ca92b22708e](https://github.com/BTCDecoded/blvm/commit/4ca92b22708e7baa0554f13b8f48b2a760686651))
- chore: update Cargo.lock ([8fb97ecb0f7b](https://github.com/BTCDecoded/blvm/commit/8fb97ecb0f7b0d52448182d1f5f14231839ccc38))
- Complete release system implementation and validation ([00df259291d4](https://github.com/BTCDecoded/blvm/commit/00df259291d4c4fbbc1565287850c9e3fc26a3dc))
- fix: Update test_parallel_builds to handle non-deterministic HashMap ordering ([274dc6a9d70d](https://github.com/BTCDecoded/blvm/commit/274dc6a9d70d8f28420cdd78aa3eaa8283b2f256))
- security: Update tracing-subscriber to 0.3.20 to fix vulnerability ([5796ce2d75d3](https://github.com/BTCDecoded/blvm/commit/5796ce2d75d312ce301bf2c8e6f32f869fd3fa9b))
- chore: Update dependencies and formatting ([69091e45b3e2](https://github.com/BTCDecoded/blvm/commit/69091e45b3e2238a391a29f31d4f1abde33e7c62))
- Complete orchestrator: conditional builds, use triggering repo refs, crates.io support ([7561619da22a](https://github.com/BTCDecoded/blvm/commit/7561619da22a6587a1dbf0c92b791cb69b22117d))
- Fix orchestrator: correctly detect repository_dispatch event type ([de497d628467](https://github.com/BTCDecoded/blvm/commit/de497d6284671afb88075f7f2d7d6ceec957b222))
- Add debug logging to orchestrator for event diagnosis ([497957004c78](https://github.com/BTCDecoded/blvm/commit/497957004c78257602a27b4335e2b02bd8ccb727))
- Add debug logging to orchestrator for event diagnosis ([ccf22d974852](https://github.com/BTCDecoded/blvm/commit/ccf22d9748528af35bd81dda5b55f24e74a3fba5))
- fix: add perf label to Kani verification workflows ([8b8c6ad2fbb5](https://github.com/BTCDecoded/blvm/commit/8b8c6ad2fbb5ec723d33fb489cd68940f7be7bb6))
- fix: add builds label to all runs-on tags without perf ([4710dbc464e5](https://github.com/BTCDecoded/blvm/commit/4710dbc464e5a2d8a807b85350c92220ab2dfd6c))
- Fix feature placement: Add ZMQ and infrastructure features to base variant ([c454c1b9ce42](https://github.com/BTCDecoded/blvm/commit/c454c1b9ce4295f9895ebd1b349a59c587e24f6b))
- Add ci.yml workflow and disable automatic triggers in other workflows ([85206715ee7e](https://github.com/BTCDecoded/blvm/commit/85206715ee7e71aa03180b45459debc1c2e3d8ed))
- docs: remove working documents and improve timelessness ([7744ae061311](https://github.com/BTCDecoded/blvm/commit/7744ae061311f288f06d5804fcf2dfff9d56dbac))
- Update coverage workflow to manual-only ([6d9653dff69a](https://github.com/BTCDecoded/blvm/commit/6d9653dff69ac881c8a822957e91c5c6ab5ecc97))
- Update coverage workflow and dependencies ([691774dff2e3](https://github.com/BTCDecoded/blvm/commit/691774dff2e33e6bf4faa43fbafce381dc9637b4))
- refactor: Rename from bllvm to blvm ([fa2b332534f8](https://github.com/BTCDecoded/blvm/commit/fa2b332534f8eac6015b22c4dc953dadec7daf26))
- docs: consolidate CONTRIBUTING.md, link to blvm-docs ([f6c153587492](https://github.com/BTCDecoded/blvm/commit/f6c1535874927dcc311f9b0860ba19c7b96314ef))
- feat(ops): Add AWS spot instance infrastructure for Kani proofs and benchmarks ([f54b65df49f0](https://github.com/BTCDecoded/blvm/commit/f54b65df49f0b34b734e22053ebb5f07ba69b123))
- feat(ci): Add workflow to build Kani runner AMI using Packer ([f86235fee246](https://github.com/BTCDecoded/blvm/commit/f86235fee2467f4740fdc7164901a846d8be08cf))
- refactor(ci): Fix naming and remove coverage from default CI ([7c61a919e3f0](https://github.com/BTCDecoded/blvm/commit/7c61a919e3f067b91790e55b2d43404a5f2f61dc))
- ops: Update AWS infrastructure configuration and workflows ([dc533d35a40b](https://github.com/BTCDecoded/blvm/commit/dc533d35a40bd817c0c5aaa75918b960007bb1e1))
- chore: Add trailing newline to workflow file ([44c1595a8fe6](https://github.com/BTCDecoded/blvm/commit/44c1595a8fe6862fa9843bca02ab8033e3d1df1b))
- fix: Remove GITHUB_TOKEN from secrets (system reserved, use github.token instead) ([7a4eca62d29c](https://github.com/BTCDecoded/blvm/commit/7a4eca62d29ca5b65b3d84e78c6c64e2a34f8e4c))
- refactor: rename binary from bllvm to blvm ([4dacff455c23](https://github.com/BTCDecoded/blvm/commit/4dacff455c239d00aaaee9b0d679a60fcfcb3b99))
- feat: update dependencies, CI workflow, and fix typos ([678cd41021e8](https://github.com/BTCDecoded/blvm/commit/678cd41021e8e55a0627c1353d0d1886ee6ced7b))
- Update Cargo.lock with dependency changes ([f96d428dab50](https://github.com/BTCDecoded/blvm/commit/f96d428dab506c102dc8de3006c53fda0c1e9b55))
- docs: remove temporary release validation files ([9875935091e4](https://github.com/BTCDecoded/blvm/commit/9875935091e4750c03e746be17be2497eedc851c))
- feat: RocksDB default, profile feature, config precedence, CI blvm-spec-lock ([a3781bdc28d2](https://github.com/BTCDecoded/blvm/commit/a3781bdc28d29da640940cdcc51d7f2a56838704))
- feat: RocksDB default, profile feature, config precedence, CI blvm-spec-lock ([3a30da8b5d5c](https://github.com/BTCDecoded/blvm/commit/3a30da8b5d5ce208ab35e2ad0196204164715190))
- chore: workflow and docs cleanup, remove Kani runner infrastructure ([21076d21b7dd](https://github.com/BTCDecoded/blvm/commit/21076d21b7ddea25d88222b2ef3aeeb0e682d0d7))
- feat(cli): module lifecycle, migrate, and richer node CLI ([77d5d75c5ee3](https://github.com/BTCDecoded/blvm/commit/77d5d75c5ee3832526ce830fdbd48376365b7d06))
- fix(cli): respect regtest when no usable config file loads ([6fe86038187f](https://github.com/BTCDecoded/blvm/commit/6fe86038187f3040558a85835329a9e6544a5bfe))
- chore: stop tracking Cargo.lock; align CI for manifest-only lockfiles ([e625b570bcf7](https://github.com/BTCDecoded/blvm/commit/e625b570bcf7ced03165e39477ad888b6b35dee5))
- ci: BTCDecoded/rust-ci composites and install-rust-toolchain ([762336ebffc3](https://github.com/BTCDecoded/blvm/commit/762336ebffc33b841eaec758f948a2a266ba2d1d))
- release: Linux packages, variant rebuilds, and coordinated version bumps ([e4c10622dbaa](https://github.com/BTCDecoded/blvm/commit/e4c10622dbaafdc4d97e85187b4dc6da20a9d638))
- chore: patch sibling crates for local workspace builds ([3d41f6fb10de](https://github.com/BTCDecoded/blvm/commit/3d41f6fb10de4045505d26ea5c70711451fcdc23))
- release: document non-default profile risk for consensus builds ([e717177c865d](https://github.com/BTCDecoded/blvm/commit/e717177c865d6b909fab89288f3971ae9bfe4922))
- feat(blvm): pin default node features and sibling primitives patch ([e9a8ee32170c](https://github.com/BTCDecoded/blvm/commit/e9a8ee32170c9d16c79eeca00d76c58d05f342d4))
- docs(security): use security@thebitcoincommons.org for disclosures ([616d79b2795c](https://github.com/BTCDecoded/blvm/commit/616d79b2795c766cabd023338a3215765f169e48))
- ci: overhaul ci.yml with all node/sdk learnings + cleanup workflow [skip_docs] [skip_security] ([e21d57d68bac](https://github.com/BTCDecoded/blvm/commit/e21d57d68bac3338c39bfdce76cf3eb394a121a0))
- fix: fmt, clippy, test fixes for ci readiness [skip_docs] [skip_tests] [skip_security] ([b18504ba0256](https://github.com/BTCDecoded/blvm/commit/b18504ba0256831e931eb7be6b448dfa439b6d23))
- ci: add release job with GitHub Release, binary artifact, checksum, and teardown [skip_tests] [skip_docs] [skip_security] ([928b8b2a3c9d](https://github.com/BTCDecoded/blvm/commit/928b8b2a3c9da206297826ff48b246f3d0eb95f6))

## [v0.1.2] - 2026-05-07

### Reconstructed

- ci: multi-platform release artifacts (deb, rpm, exe), better release notes [skip_tests] [skip_docs] [skip_security] ([135f60ca78d5](https://github.com/BTCDecoded/blvm/commit/135f60ca78d5e6d709b42c7478b8f34b8b618019))
- ci: fix release artifact upload — stage to dir and use glob [skip_tests] [skip_docs] [skip_security] ([dec9342f6872](https://github.com/BTCDecoded/blvm/commit/dec9342f6872d2fd4c4cae7e51dc4042e0a44be1))
- ci: version bump checks git tags as primary source, crates.io as secondary [skip_tests] [skip_docs] [skip_security] ([d98272e5edb5](https://github.com/BTCDecoded/blvm/commit/d98272e5edb5037ca5d55cc913c73442ebeb585d))

## [v0.1.3] - 2026-05-07

### Reconstructed

- ci: fix deb binary path (copy to target/release/ first), trim Windows features to pure-Rust [skip_tests] [skip_docs] [skip_security] ([14aba2ee51bc](https://github.com/BTCDecoded/blvm/commit/14aba2ee51bce5bf0c03a419af999c35a83963f5))

## [v0.1.4] - 2026-05-07

### Reconstructed

- ci: fix Windows linker env vars, surface build errors, fix duplicate H1 in release notes [skip_tests] [skip_docs] [skip_security] ([f7c2875f7fa6](https://github.com/BTCDecoded/blvm/commit/f7c2875f7fa6610c32cf985fcacdef541a8bf983))

## [v0.1.5] - 2026-05-07

### Reconstructed

- ci: add sha2-asm pure-Rust Windows stub, patch before Windows cross-compile [skip_tests] [skip_docs] [skip_security] ([2705e9ef5a88](https://github.com/BTCDecoded/blvm/commit/2705e9ef5a88d14c4fdf7e0ff582fcee0c484bad))
- chore: remove sha2-asm ci stub, lock blvm-secp256k1 0.1.3 ([205c1fced751](https://github.com/BTCDecoded/blvm/commit/205c1fced75180e8570663c91c4d1c3722a4030b))
- ci: publish Linux image to GHCR after release; add Dockerfile [skip_tests] [skip_docs] [skip_security] ([1542e11f49c6](https://github.com/BTCDecoded/blvm/commit/1542e11f49c633be7bea9228677a0aea8a0ee731))

## [v0.1.6] - 2026-05-07

### Reconstructed

- ci: publish Linux image to GHCR after release; add Dockerfile [skip_tests] [skip_docs] [skip_security] [skip_docker] ([c3b690f2376f](https://github.com/BTCDecoded/blvm/commit/c3b690f2376f65ea77bab55573a8c202ca8d24ad))
- ci: restore SECP256K1_NO_ASM=1 for Windows cross-compile step [skip_tests] [skip_docs] [skip_security] [skip_docker] ([76fcb72fecde](https://github.com/BTCDecoded/blvm/commit/76fcb72fecdea4c49a8ac0852f93667bade8cc2e))
- CI: dispatch blvm-release to BTCDecoded/website after GitHub Release ([264e3ee3cd88](https://github.com/BTCDecoded/blvm/commit/264e3ee3cd88af4933f3ee582e47f20de83987e6))
- CI: restore notify-website-deploy job key; dispatch commons-website too ([ac4186981800](https://github.com/BTCDecoded/blvm/commit/ac4186981800957428cc213243173f58ee29e6cc))
- chore: bump blvm-consensus to 0.1.11 [skip_tests] [skip_docs] [skip_security] [skip_docker] ([5a5fa727a533](https://github.com/BTCDecoded/blvm/commit/5a5fa727a5330dd87e4dcde3476596b6f0da45a8))
- ci: ignore RUSTSEC-2026-0118/0119 (hickory-dns via iroh, no fix yet) ([97b8db184b20](https://github.com/BTCDecoded/blvm/commit/97b8db184b207d4518cf6780cfe12bca277b1877))
- chore: bump blvm-consensus to 0.1.12 [skip_tests] [skip_docs] [skip_security] [skip_docker] ([8b2698cdec1c](https://github.com/BTCDecoded/blvm/commit/8b2698cdec1c5d397d2d4024d1dc06848990c206))
- ci: drop --locked from release builds [skip_tests] [skip_docs] [skip_security] [skip_docker] ([9e24dab53788](https://github.com/BTCDecoded/blvm/commit/9e24dab53788223b5e7c0d8c94eb720043730b60))

## [v0.1.7] - 2026-05-08

### Reconstructed

- ci: remove SECP256K1_NO_ASM workaround (fixed in blvm-secp256k1 build.rs) [skip_tests] [skip_docs] [skip_security] [skip_docker] ([b1cb67d1ce9d](https://github.com/BTCDecoded/blvm/commit/b1cb67d1ce9d860a97c32c9c677a26d4c2795120))
- chore: bump blvm-secp256k1 to 0.1.4 [skip_tests] [skip_docs] [skip_security] [skip_docker] ([01a7e282a37b](https://github.com/BTCDecoded/blvm/commit/01a7e282a37b35299d1104242274f6a910896ca1))
- chore: re-run release build [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([f1315e6fcdc3](https://github.com/BTCDecoded/blvm/commit/f1315e6fcdc34a3ecd081fa9eed2e7b261e91a93))

## [v0.1.8] - 2026-05-08

### Reconstructed

- chore: re-run release build [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([228d7899cc13](https://github.com/BTCDecoded/blvm/commit/228d7899cc139d90b059aead90aa7aa6f3fbf858))

## [v0.1.9] - 2026-05-08

### Reconstructed

- chore: re-run release build [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([f4555ce0b52f](https://github.com/BTCDecoded/blvm/commit/f4555ce0b52fcb738185fc2d2ebedeeac9a01446))
- chore: re-run release build [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([d4ecc2668614](https://github.com/BTCDecoded/blvm/commit/d4ecc266861487e8ee9da6b05613a11378fc3ed7))

## [v0.1.10] - 2026-05-08

### Reconstructed

- chore: pin blvm-node to 0.1.4 (Windows cross-compile fixes) [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([b3fe4bd60bbb](https://github.com/BTCDecoded/blvm/commit/b3fe4bd60bbb3295b3d77dd0745785bc3f432eaf))
- revert: restore Cargo.lock, revert over-broad cargo update [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([fdbba8ab36a1](https://github.com/BTCDecoded/blvm/commit/fdbba8ab36a1134d27fe142856ecc84b8f5cd00d))

## [v0.1.11] - 2026-05-08

### Reconstructed

- fix: pin ed25519=3.0.0-rc.4; gate Migrate command behind rocksdb feature ([7e1520ee930d](https://github.com/BTCDecoded/blvm/commit/7e1520ee930da441a3904496df20840bddaed6ab))

## [v0.1.12] - 2026-05-08

### Reconstructed

- chore: pin blvm-secp256k1 to 0.1.5 (Windows linker fix) [skip_tests] [skip_docs] [skip_fuzz] [skip_security] [skip_docker] ([2a6bd83270d5](https://github.com/BTCDecoded/blvm/commit/2a6bd83270d5043d585a68b32b674273a198ecc8))

## [v0.1.13] - 2026-05-09

### Reconstructed

- chore: trigger full CI including GHCR container publish ([22000d1d3afc](https://github.com/BTCDecoded/blvm/commit/22000d1d3afc7c62d970a53fd3e618194f7844f5))
- fix: upgrade cargo-audit 0.21.0 → 0.22.1 (CVSS 4.0 support) ([b7fb3dcab187](https://github.com/BTCDecoded/blvm/commit/b7fb3dcab187aea1000cb358df7153c1868169b6))
- fix: unset CC/CXX/CPP/AR before dev build and test steps ([db1d39df7191](https://github.com/BTCDecoded/blvm/commit/db1d39df719160ebeaa3333317df8f1467ac9cae))
- chore: consistency pass — storage features, CI hardening, dep hygiene ([b156b0b51d86](https://github.com/BTCDecoded/blvm/commit/b156b0b51d86b89b9848b6cb7b92f20a7cf1d866))
- patch: add blvm-secp256k1 path override to [patch.crates-io] ([5800697f8d70](https://github.com/BTCDecoded/blvm/commit/5800697f8d70c1bf649468abc882c74b1f29db00))
- chore: remove redundant direct bytes dependency ([529c5d1f88b6](https://github.com/BTCDecoded/blvm/commit/529c5d1f88b6de6db9ea16179302833a8eed01fa))

## [v0.1.14] - 2026-05-11

### Reconstructed

- docs: README, governance stubs, bench paths, testnet compose [skip_ci] [skip ci] ([b60288b6f3df](https://github.com/BTCDecoded/blvm/commit/b60288b6f3df2e8f5783c71eb4c7c9ab360f126a))
- feat: first-party module registry and enabled_modules config defaults ([8ae7687b14ed](https://github.com/BTCDecoded/blvm/commit/8ae7687b14ed9bfe942adc0a640916151bfe2312))

## [v0.1.15] - 2026-05-12

### Reconstructed

- fix: drop stale blvm-node/zmq and miniscript feature edges from defaults ([3326369b2db2](https://github.com/BTCDecoded/blvm/commit/3326369b2db25969c5c25dcb1b872524a54dfbbe))
- chore: skip pacman installs if packages already present on runner ([e4464ca693ec](https://github.com/BTCDecoded/blvm/commit/e4464ca693ecb2d0048d7497da826dbcde4042ef))
- fix(release): install full mingw-w64-toolchain group for Windows cross-compile on Arch ([379d058abf4d](https://github.com/BTCDecoded/blvm/commit/379d058abf4d0aed93a746dc8abd131ea27d3e13))

## [v0.1.16] - 2026-05-12

### Reconstructed

- chore: update Cargo.lock for blvm-node 0.1.6 and other crate updates ([82a6beaae06c](https://github.com/BTCDecoded/blvm/commit/82a6beaae06c38abaa3c8c15742ec41eeb22917c))
- fix: pin pkcs8 to =0.11.0-rc.11 to resolve ed25519-rc.4 build failure ([2e198544ea12](https://github.com/BTCDecoded/blvm/commit/2e198544ea128fc2c89a45b5fdbf09373ccc18fc))

## [v0.1.17] - 2026-05-12

### Reconstructed

- chore: sync Cargo.lock after pkcs8 =0.11.0-rc.11 pin ([9b60acb633bd](https://github.com/BTCDecoded/blvm/commit/9b60acb633bdf42ecf69fd65e34c4e14993f75d8))

## [v0.1.18] - 2026-05-12

### Reconstructed

- fix: regenerate Cargo.lock after strip-patch-crates-io in docker-ghcr job ([de8e9748be26](https://github.com/BTCDecoded/blvm/commit/de8e9748be2649313232ed4ed98b3be7dc845802))

## [v0.1.19] - 2026-05-12

### Reconstructed

- fix: bump Docker builder to rust:1.88, simplify modules.json to discovery index ([a102c0975e2b](https://github.com/BTCDecoded/blvm/commit/a102c0975e2b7b0d90c6d565a21fe6bc459ee6fa))

## [v0.1.20] - 2026-05-15

### Reconstructed

- docs: example modules config with registry_url, miniscript, zmq, marketplace ([ff8c31c1c062](https://github.com/BTCDecoded/blvm/commit/ff8c31c1c06272ac1667b301b33006da70a11e59))
- chore: default-enable governance and document module registry bootstrap ([5242b01171d9](https://github.com/BTCDecoded/blvm/commit/5242b01171d99098ba7472e0614684b1e7397cf4))
- test(config): include modules table in JSON loading fixture ([7b2cb822a0b2](https://github.com/BTCDecoded/blvm/commit/7b2cb822a0b26a9ef7aa09d094c71a8193ae8ae7))
- fix(deps): require blvm-node >=0.1.10 (avoid 0.1.9 / protocol::fibre) ([ef1e60b18a48](https://github.com/BTCDecoded/blvm/commit/ef1e60b18a4878b05515ab0ca02e28bf511f2be8))
- revert(deps): relax blvm-node semver back to >=0.1, <1 ([41b97aee39e0](https://github.com/BTCDecoded/blvm/commit/41b97aee39e05c5541073bd41456ae5988ea6de3))

## [v0.1.21] - 2026-05-15

### Reconstructed

- ci: publish GHCR after any successful release; sync lock + modules index ([f8941499571a](https://github.com/BTCDecoded/blvm/commit/f8941499571a3bada2b6005427ec543165a7c9a8))
- ci(release): derive next patch from max used version ([9f87abc0b790](https://github.com/BTCDecoded/blvm/commit/9f87abc0b7909959b5c5f40e820b216ed89ba3d5))

## [v0.1.22] - 2026-05-15

### Reconstructed

- ci(release): ship full artifact bundle on GitHub releases; fix GHCR rocks build ([02c1dfe1ac31](https://github.com/BTCDecoded/blvm/commit/02c1dfe1ac31694369fab6d5b3b7bdc116c5fb99))

## [v0.1.23] - 2026-05-16

### Reconstructed

- docs: Stratum module-first CONFIGURATION; add decoupling plan mirror ([02cbce119aab](https://github.com/BTCDecoded/blvm/commit/02cbce119aab10db87f6ddddf75aa718d826960c))

## [v0.1.24] - 2026-05-16

### Reconstructed

- chore: drop bllvm.toml.example; remove Stratum decoupling plan mirror ([1acff37c4dde](https://github.com/BTCDecoded/blvm/commit/1acff37c4ddea6c31c390577bc187e7f7623b024))

## [v0.1.25] - 2026-05-16

### Reconstructed

- docs: point Stratum section at operator docs, not decoupling plan ([605a7429abf1](https://github.com/BTCDecoded/blvm/commit/605a7429abf1fc861e0ee629c0c83a8a71fa4f4a))
- fix(registry): point blvm-fibre at standalone module.toml ([131b823115d5](https://github.com/BTCDecoded/blvm/commit/131b823115d5c6ff2840f2a73c3eb112c00a8ea4))

## [v0.1.26] - 2026-05-16

### Reconstructed

- chore(registry): rely on repo-root module.toml in modules.json ([c2c6ff8b11c9](https://github.com/BTCDecoded/blvm/commit/c2c6ff8b11c99b3684da5decc608804d49a64618))

## [v0.1.27] - 2026-05-18

### Reconstructed

- docs: configuration examples and hierarchy aligned with blvm CLI ([ecf91f96ef50](https://github.com/BTCDecoded/blvm/commit/ecf91f96ef50e22a082a5bbc41a9a978c0542d8f))
- docs(ci): clarify release profile guidance in Cargo.toml ([bca23ed1ef61](https://github.com/BTCDecoded/blvm/commit/bca23ed1ef613871389c6d7fbd03ca53f980d3db))
- ci: refresh umbrella workflows and lockfile ([c88fa4670f9e](https://github.com/BTCDecoded/blvm/commit/c88fa4670f9eb2ce315ffe04a8484cd0f65ba829))
- ci(release): avoid empty CC/CXX when ccache is absent ([b566f99ddeb9](https://github.com/BTCDecoded/blvm/commit/b566f99ddeb91b231b8d39a52e06cd040a8f85b9))

## [v0.1.28] - 2026-05-21

### Reconstructed

- feat: mainnet IBD onboarding for release users ([96826f3fbb18](https://github.com/BTCDecoded/blvm/commit/96826f3fbb1836b03fe580f4ea4c86e2c1ba111b))
- docs: add prioritized mainnet IBD UX plan with CI P0 items ([126c2ec67671](https://github.com/BTCDecoded/blvm/commit/126c2ec6767185058ee68f72f098db7e267af9a7))

## [v0.1.29] - 2026-05-21

### Reconstructed

- chore: remove workspace IBD planning docs from repo ([540ae9f38f69](https://github.com/BTCDecoded/blvm/commit/540ae9f38f69194ad29776599c09754767b312f0))
- docs(blvm): mainnet IBD release path, RPC hints, and script env fix [skip ci] ([b27054834310](https://github.com/BTCDecoded/blvm/commit/b270548343108039191742eba8c66475bf486031))
- fix(ci): unset CC/CXX in clippy/docs so librocksdb-sys builds ([c215e65a7f00](https://github.com/BTCDecoded/blvm/commit/c215e65a7f00ba5a18411f9dfa8cece3d5f13c20))

## [v0.1.30] - 2026-05-27

### Reconstructed

- ci: remove Build(dev,shared) step; promote test/clippy/docs to first tier ([2fa1b1b4a7a5](https://github.com/BTCDecoded/blvm/commit/2fa1b1b4a7a58f378415b30c1a98751395554110))
- ci: remove cleanup-runner-disk workflow [no ci] ([41ada65d88f4](https://github.com/BTCDecoded/blvm/commit/41ada65d88f47e072caa588986b24a798806d9d8))
- ci: re-trigger after blvm-node Debug fix publish ([c734178c6848](https://github.com/BTCDecoded/blvm/commit/c734178c684859568faf00a83f0ee96696667cee))
- fix(cli): network-aware defaults, CoreDataNetwork, and CI action bumps ([47a2c5fc474f](https://github.com/BTCDecoded/blvm/commit/47a2c5fc474fd984a20f81694692d5b1a5535020))

## [v0.1.31] - 2026-05-28

### Reconstructed

- feat(ci): develop channel — nightly binaries and crates.io pre-releases ([cb7a509acc10](https://github.com/BTCDecoded/blvm/commit/cb7a509acc10b63d34b377ec67a0197284af6f6e))
- ci: remove Build(dev,shared) step; promote test/clippy/docs to first tier ([9f1026dd8a7e](https://github.com/BTCDecoded/blvm/commit/9f1026dd8a7e4ea6d41888258797e6ac4e7e4be3))
- fix(ci): repair develop channel CI and merge main ([6596e1b55799](https://github.com/BTCDecoded/blvm/commit/6596e1b557997b68b96993e03cde38f0a4959d36))
- fix(ci): stable fallback when develop crate set is missing on registry ([2fee79ee630e](https://github.com/BTCDecoded/blvm/commit/2fee79ee630eb5267fbbebc17283ea87895b3332))

## [v0.1.32] - 2026-06-04

### Reconstructed

- fix(cli): await IBD watermark flush on SIGTERM/SIGINT shutdown ([6ad412237585](https://github.com/BTCDecoded/blvm/commit/6ad4122375851a3f8f797fdd8d0ead9a52403018))
- ci(release): ship linux-aarch64 binaries for Raspberry Pi 64-bit ([f12682fbc418](https://github.com/BTCDecoded/blvm/commit/f12682fbc418d2a4f9259d1e2b349957a2cfa4b0))
- docs(ibd): raise mainnet parallel chunk sizes in example config ([c65a74198031](https://github.com/BTCDecoded/blvm/commit/c65a741980310d13d5589d09a728c7ef4e60c132))
- fix(deps): bump blvm-node lockfile to 0.1.25 for IBD shutdown API ([1dd453f47842](https://github.com/BTCDecoded/blvm/commit/1dd453f47842f7e9ffada4825a579dd704b211bb))
- fix(deps): bump blvm-node to 0.1.26 (cross-platform io-uring + file I/O guards) ([4da93e8bdb54](https://github.com/BTCDecoded/blvm/commit/4da93e8bdb540bdc8567af82e9797419d9f6aa8a))
- ci: cargo update blvm-* after patch strip to always pick latest crates.io versions ([efb806692f58](https://github.com/BTCDecoded/blvm/commit/efb806692f5876b6210f82efdfb3d7c687c9cb3b))
- Revert "ci: cargo update blvm-* after patch strip to always pick latest crates.io versions" ([b53099b67836](https://github.com/BTCDecoded/blvm/commit/b53099b67836ec748c73f66d580ea4f1e1224106))
- chore: remove Cargo.lock (always resolve latest from crates.io) ([3ed25e8b9438](https://github.com/BTCDecoded/blvm/commit/3ed25e8b9438459160fe9ea58e7169cceaffe26b))

## [v0.1.33] - 2026-06-04

### Reconstructed

- chore: remove stray symlink and test binary ([3d246ca5751d](https://github.com/BTCDecoded/blvm/commit/3d246ca5751dbcc02bcf1da5c4a60b924bfd1948))
- chore: ignore local blvm binaries and .hermes.md ([2db816ba56c4](https://github.com/BTCDecoded/blvm/commit/2db816ba56c41ee9554ec77b5864b5c57bafa6d1))

## [v0.1.34] - 2026-06-05

### Reconstructed

- ci: bump GitHub Actions pins on build workflows ([95bb56b69598](https://github.com/BTCDecoded/blvm/commit/95bb56b6959866a2c2ff2662701700baf6e16589))

## [v0.1.35] - 2026-06-06

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.36] - 2026-06-07

### Reconstructed

- feat(cli): Core drop-in migration flags and storage-aware node startup ([be5f579f9e0f](https://github.com/BTCDecoded/blvm/commit/be5f579f9e0f4579ff6d26eae34abc5880a950e3))
- style: cargo fmt on Core migration log line in main.rs ([cc8cefac8fd3](https://github.com/BTCDecoded/blvm/commit/cc8cefac8fd3444fd589a78a4368410bd5c90ed3))

## [v0.1.37] - 2026-06-15

### Reconstructed

- docs(config): version-pinned module defaults in example and readmes [skip ci] ([2372e0fa23e5](https://github.com/BTCDecoded/blvm/commit/2372e0fa23e58d5edceb3664597aec86439a7bac))

## [v0.1.38] - 2026-06-16

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.39] - 2026-06-17

### Reconstructed

- chore: MSRV 1.85, edition 2024, and pin release CI to 1.88.0 ([04444c722bda](https://github.com/BTCDecoded/blvm/commit/04444c722bdae083bc07598ed78cc6aad52fa564))

## [v0.1.40] - 2026-06-19

### Reconstructed

- feat(cli): compression defaults, RPC auth, and release CI/docs cleanup [skip ci] ([fafb50e61cb0](https://github.com/BTCDecoded/blvm/commit/fafb50e61cb0365fffc2dae9205ce5252c68ed65))
- feat(cli): Signet network support and Core-correct default ports ([e116c325822b](https://github.com/BTCDecoded/blvm/commit/e116c325822b0c16f78a3ea882dc16a520df12e1))
- fix(ci): isolate governance release builds from blvm target dir ([536647f11c48](https://github.com/BTCDecoded/blvm/commit/536647f11c489a56656569b0e82225efe3e557f7))

## [v0.1.41] - 2026-06-19

### Reconstructed

- fix(config): place mainnet IBD example prune keys under storage.pruning ([3351160c0c99](https://github.com/BTCDecoded/blvm/commit/3351160c0c99438ee1355b36fbd68350bf960b49))

## [v0.1.42] - 2026-06-19

### Reconstructed

- docs(release): drop "Bitcoin Low-Level Virtual Machine" from release copy [skip ci] ([864b65f862a6](https://github.com/BTCDecoded/blvm/commit/864b65f862a6a822373d69a5775ef58cc127ec37))
- fix: address blvm#6 CLI and release onboarding findings ([1eee27ff29e0](https://github.com/BTCDecoded/blvm/commit/1eee27ff29e082dd5b99211d711b1898e99a7e07))

## [v0.1.43] - 2026-06-19

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.44] - 2026-06-24

### Reconstructed

- docs: align CLI RPC default ports in README [skip ci] ([9a0086b8d585](https://github.com/BTCDecoded/blvm/commit/9a0086b8d585d054afd5f3cf5bd8adbd9655e275))
- fix(cli): graceful shutdown via shared signal receiver ([789cb0389e30](https://github.com/BTCDecoded/blvm/commit/789cb0389e300abba2a14c5c92e06a7c62e163d3))
- fix(security): force quinn-proto 0.11.15 for RUSTSEC-2026-0185 ([409d35bb9ab8](https://github.com/BTCDecoded/blvm/commit/409d35bb9ab88b61f36bbd503600156ab18dd2c1))

## [v0.1.45] - 2026-06-25

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.46] - 2026-06-25

### Reconstructed

- feat(release): enable heed3 on Windows and Linux aarch64 cross-builds ([9f5d152eaebd](https://github.com/BTCDecoded/blvm/commit/9f5d152eaebdfdf56b405249f150536a36ec8ccf))

## [v0.1.47] - 2026-06-25

### Reconstructed

- feat(release): maximize cross-platform default feature parity ([1ef178b9896b](https://github.com/BTCDecoded/blvm/commit/1ef178b9896bfb958a8eee10c639c0970ecaea41))

## [v0.1.48] - 2026-06-26

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.49] - 2026-10-05

### Reconstructed

- docs(readme): slim landing page; link install site and blvm-docs [skip ci] ([090971257790](https://github.com/BTCDecoded/blvm/commit/090971257790a60b8833086507e422310b4310d1))
- docs(readme): add release artifact matrix; drop stale MSRV line [skip ci] ([fca2be6480d1](https://github.com/BTCDecoded/blvm/commit/fca2be6480d1931fa96ecd3aad92d68a5fd8b3a5))
- docs(readme): show single consensus layer in architecture tree [skip ci] ([bfd1722c83f3](https://github.com/BTCDecoded/blvm/commit/bfd1722c83f3aa5affdea1092744856b6567e3e1))
- docs: add internal ADRs, security audit, and reference plans ([879668d326d1](https://github.com/BTCDecoded/blvm/commit/879668d326d1be96e3e326850f681f6bd8a930df))
- Revert "docs: add internal ADRs, security audit, and reference plans" ([80de692725d4](https://github.com/BTCDecoded/blvm/commit/80de692725d4c6c02087b999e8cab1c9a9656858))
- peel: jemalloc production path, worker_threads=4, ignore local ELF [skip ci] ([506d1b561f5b](https://github.com/BTCDecoded/blvm/commit/506d1b561f5b58f6db488492f9bc7c00968f9304))
- fix(deps): clear the cargo-audit failures blocking release ([36471c60d68d](https://github.com/BTCDecoded/blvm/commit/36471c60d68de519cf242e3d82659cfebfc117ec))
- fix(deps): build the release against the published consensus chain ([553d915261f4](https://github.com/BTCDecoded/blvm/commit/553d915261f4d76f71d0582cc3a32f7074aaebb3))

## [v0.1.50] - 2026-10-06

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.51] - 2026-10-06

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.52] - 2026-10-07

### Reconstructed

- feat(blvm): accept testnet4 on the command line ([274d08f865a5](https://github.com/BTCDecoded/blvm/commit/274d08f865a59ed91c4446e4e3a9e45eae0eb169))
- fix(deps): build the release against the published testnet4 crates ([e418c608f14f](https://github.com/BTCDecoded/blvm/commit/e418c608f14fc49d57e983ec563e7093e797dc45))

## [v0.1.53] - 2026-10-08

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.54] - 2026-10-10

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.55] - 2026-10-11

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.56] - 2026-10-11

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.57] - 2026-10-11

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.58] - 2026-10-11

### Reconstructed

- ci: run the marketing-site dispatch on the self-hosted builder ([562beb33dfbe](https://github.com/BTCDecoded/blvm/commit/562beb33dfbe76b09e12dade355aaf7ce8d9f147))

## [v0.1.59] - 2026-10-11

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.60] - 2026-10-11

### Reconstructed

- No non-merge commits in this tag range.

## [v0.1.61] - 2026-10-15

### Reconstructed

- fix(deps): take rustls 0.23.46, wasmtime 36.0.18, and consensus 0.1.60 ([8d233fc3af8a](https://github.com/BTCDecoded/blvm/commit/8d233fc3af8a90255ecc62852efa844e4a172df4))
- fix(deps): lock blvm-primitives 0.1.27 for consensus 0.1.60 ([909914add678](https://github.com/BTCDecoded/blvm/commit/909914add678700efb5f1246d92776ffd7fb9b47))
- fix(deps): lock blvm-protocol 0.1.32 for primitives 0.1.27 ([2b62f4cbd323](https://github.com/BTCDecoded/blvm/commit/2b62f4cbd323b8c81b20d7698f88d2b56fa9f701))

## [v0.1.62] - 2026-10-18

### Reconstructed

- ci(release): lock crates.io versions after the workspace reset ([3dbfef430247](https://github.com/BTCDecoded/blvm/commit/3dbfef4302475b33f1a980d8a025bc4a2f390e28))
- ci(release): write a lockfile for crates that do not commit one ([8d2df35ccc47](https://github.com/BTCDecoded/blvm/commit/8d2df35ccc47e4de35013b6ecf771c34c60c7f70))
- ci(release): leave blvm-commons off the lockfile step ([d8e21d4a7d04](https://github.com/BTCDecoded/blvm/commit/d8e21d4a7d0494b431bbc292393ec6ead9b7394a))
- ci(release): package blvm when the Windows sdk build fails ([3c1f7e636d81](https://github.com/BTCDecoded/blvm/commit/3c1f7e636d818b9111a414eed1949daf30164f5d))
- ci(release): keep packaging when Windows sdk experimental does not build ([451e7a2fa73c](https://github.com/BTCDecoded/blvm/commit/451e7a2fa73ceb1c9115ef8e7b413ef2ffa61d6b))

## [v0.1.63] - 2026-10-19

### Reconstructed

- fix(release): name the linked crate versions and upload each checksum once ([10cc901cf8dd](https://github.com/BTCDecoded/blvm/commit/10cc901cf8ddbcfcd8ab6f1bf08f31d0e473ce0f))

## [v0.1.64] - 2026-10-21

### Reconstructed

- fix(release): title every blvm release blvm <tag> [skip ci] ([002d2ecf45a3](https://github.com/BTCDecoded/blvm/commit/002d2ecf45a396ab0925b1953d971dee2d57a96e))
- chore(release): link consensus 0.1.66, protocol 0.1.35, and node 0.1.75 ([c516b77692ab](https://github.com/BTCDecoded/blvm/commit/c516b77692abc8afd0e2ab0c5f29c850d65a00ca))
- fix(release): clear the cargo audit gate for the binary ([d3d50ab19f0b](https://github.com/BTCDecoded/blvm/commit/d3d50ab19f0b727a828e0b57b32a522c5c8ac471))

## [v0.1.65] - 2026-10-21

### Reconstructed

- fix(release): link consensus 0.1.67 and keep a hashless assume-valid height from skipping scripts ([19da72017874](https://github.com/BTCDecoded/blvm/commit/19da7201787402cc0f8c2a7ff3d677db5c29108b))

## [v0.1.66] - 2026-10-21

### Reconstructed

- fix(release): link consensus 0.1.68 and node 0.1.76, and exit when the config file is bad ([7bdb1c2fc0e5](https://github.com/BTCDecoded/blvm/commit/7bdb1c2fc0e506c4c80b67b832340a07e22c5ad5))
- fix(release): build the Linux binaries without libcudart ([8948af62cd4c](https://github.com/BTCDecoded/blvm/commit/8948af62cd4c9d28b2acbbc63d1fc80d5ea51871))

## [v0.1.67] - 2026-10-21

### Reconstructed

- fix(release): link protocol 0.1.36 ([4bf2d067cf34](https://github.com/BTCDecoded/blvm/commit/4bf2d067cf34f0adbbe327bda2fb58fb3c8396f3))

## [v0.1.68] - 2026-10-22

### Reconstructed

- ci(release): make the release and prerelease test gates fail when cargo fails. ([5f2e96cd9430](https://github.com/BTCDecoded/blvm/commit/5f2e96cd94302016e27e88cbe44ce91c63ce8892))
- ci(release): test every feature except secp-gpu, which needs CUDA. ([170fee2f4018](https://github.com/BTCDecoded/blvm/commit/170fee2f401863bb646984864e463aa3ddab5064))
- ci: stop teardown and test cleanup from deleting concurrent runs' build dirs. ([32a94820b130](https://github.com/BTCDecoded/blvm/commit/32a94820b130a2156c92c2cd066202e2014b84a2))
- ci: build every Linux binary with BLVM_SECP256K1_NO_GPU=1 ([25f080f320e5](https://github.com/BTCDecoded/blvm/commit/25f080f320e55eb476107e4954e8f519cdb22210))
- ci: leave the package step's NO_GPU to blvm#10 ([dd22d73b1f1c](https://github.com/BTCDecoded/blvm/commit/dd22d73b1f1cd8cf008499332c3422caff064ff1))
- ci: set BLVM_SECP256K1_NO_GPU on bundle, nightly and prerelease packaging steps ([c730ff060086](https://github.com/BTCDecoded/blvm/commit/c730ff060086493baa58a865d07cf1d575f6eed5))

## [v0.1.69] - 2026-10-24

### Reconstructed

- ci: run runner-disk-guard as the first step of every self-hosted build job ([1e85f816204a](https://github.com/BTCDecoded/blvm/commit/1e85f816204a93bf61b85e13a297425b8b6ac2b1))
- ci: pin the release actions, build with --locked, and attest the binaries ([6c9b8e4ee9e6](https://github.com/BTCDecoded/blvm/commit/6c9b8e4ee9e63a6dfac617c017c2e5175ae3f650))
- ci: pin runner-disk-guard to rust-ci d85c57b (fail-fast guard) ([a76ba42357b1](https://github.com/BTCDecoded/blvm/commit/a76ba42357b1b4519bfe17cb4e29f6ebc378d297))
- ci(release): pin Cargo.lock to the published crate set ([e70a13fab171](https://github.com/BTCDecoded/blvm/commit/e70a13fab17175644298b7fa6e8805250516de57))

## [v0.1.70] - 2026-10-29

### Reconstructed

- ci(release): pin Cargo.lock to consensus 0.1.71 and node 0.1.81 ([97b3ffb997e7](https://github.com/BTCDecoded/blvm/commit/97b3ffb997e7524f59b9c19cdef72fdcdb9ed0ac))

## [v0.1.71] - 2026-10-30

### Reconstructed

- ci(release): pin Cargo.lock to secp 0.1.14, consensus 0.1.72, and node 0.1.83 ([59eedba9d743](https://github.com/BTCDecoded/blvm/commit/59eedba9d7430baca9eb576f82d7f6724aaa9553))
- ci(audit): ignore wasmtime RUSTSEC-2026-0424 until the SDK pin moves ([50c64a6ff976](https://github.com/BTCDecoded/blvm/commit/50c64a6ff9764abdf8b5b0d4c43cabdc7f0e7434))

## [v0.1.72] - 2026-11-01

### Reconstructed

- ci(release): pin Cargo.lock to consensus 0.1.73 ([8b9e2b82511d](https://github.com/BTCDecoded/blvm/commit/8b9e2b82511ddfc8427c524abfd9cbce672874b3))

## [v0.1.73] - 2026-11-04

### Reconstructed

- Seed the checked mainnet assume-valid hash from the binary overlay. ([85559abd06fd](https://github.com/BTCDecoded/blvm/commit/85559abd06fd46a46185abc1de7c5d0b7ca5c1f2))
- Bring the module pins and CLI feature writes from dens-keep-wip onto main. ([a88f86c2f39d](https://github.com/BTCDecoded/blvm/commit/a88f86c2f39deb2d285d66b4f10f3bec59f979c6))
- ci(release): pin Cargo.lock to consensus 0.1.75, node 0.1.84, and primitives 0.1.31 ([e37dee1d09e6](https://github.com/BTCDecoded/blvm/commit/e37dee1d09e63a92703a87db5ae809cdf7f705de))

## [v0.1.74] - 2026-11-05

### Reconstructed

- docs: point operator links at the documentation host ([bbd0c1ccf7ba](https://github.com/BTCDecoded/blvm/commit/bbd0c1ccf7ba85847fe0fa2d6fbcbbb7c4c156d9))

## [v0.1.75] - 2026-11-05

### Reconstructed

- ci(release): pin Cargo.lock to consensus 0.1.76, node 0.1.87, and primitives 0.1.32 ([3d39da0adb77](https://github.com/BTCDecoded/blvm/commit/3d39da0adb77ff755ff32dd9a0f00dfc539e09b2))

## [v0.1.76] - 2026-11-06

### Reconstructed

- Drop blvm-fibre from the module registry until downloads exist. ([0449603ad993](https://github.com/BTCDecoded/blvm/commit/0449603ad993ccf7fcd18868e5aef2482a57d256))

## [v0.1.77] - 2026-11-08

### Reconstructed

- peel: jemalloc production path, worker_threads=4, ignore local ELF (S1+S9) ([8506e962d029](https://github.com/BTCDecoded/blvm/commit/8506e962d029bca1f21a09da7b708291f972277b))
- chore(blvm): pass the ibd-dev feature through and stop jemalloc retain [skip ci] ([380bb4b30c21](https://github.com/BTCDecoded/blvm/commit/380bb4b30c219891b3cd30cb8c20affd7089be0f))
- fix(blvm): wire testnet4 and the runtime feature flags ([d6bfa7e081be](https://github.com/BTCDecoded/blvm/commit/d6bfa7e081be5c2418912c386d9744eb2f00ee26))
- Load the wallet index and payment modules by default. ([e03b1671d119](https://github.com/BTCDecoded/blvm/commit/e03b1671d119dba3b33a0463be2fb099dd9b448a))
- Pin miniscript, zmq, and the wallet index in the example config. ([45cca791ca27](https://github.com/BTCDecoded/blvm/commit/45cca791ca27e4f0da997f2960f1df8abab51557))
- Seed the checked mainnet assume-valid hash from the binary overlay. ([cbe91500baab](https://github.com/BTCDecoded/blvm/commit/cbe91500baabcf11caaa60bee04789892b859940))
- fix(blvm): refuse stratum flags when the binary has no stratum feature ([1c3cbd1e41ef](https://github.com/BTCDecoded/blvm/commit/1c3cbd1e41efd8b3954e02af20e10faa9d22cc29))
- Lock the data directory and check stored blocks before the node serves. ([89c23a6f198e](https://github.com/BTCDecoded/blvm/commit/89c23a6f198e96e02854c04f95f22e811c2ab4ac))
- fix(blvm): refuse a missing named config and replace the file on write ([e01398712202](https://github.com/BTCDecoded/blvm/commit/e013987122023d81d8ad9a525dce0fcb1c0616fd))
- Drop blvm-fibre from the module registry until downloads exist. ([903b7aab9351](https://github.com/BTCDecoded/blvm/commit/903b7aab9351cfd717cc58e328d386cde7b14793))
- Default the release build to heed3 only. ([3771ecceb9b0](https://github.com/BTCDecoded/blvm/commit/3771ecceb9b0de1c60263464bfac93e0612999b3))
- feat(blvm): pin blvm-index in the default module set ([4fe0f7e14047](https://github.com/BTCDecoded/blvm/commit/4fe0f7e14047dd1362b21ef5730c5bb37b25a3a1))
- ci(release): pin Cargo.lock to node 0.1.89, sdk 0.1.21, and protocol 0.1.44 ([cb96064eb849](https://github.com/BTCDecoded/blvm/commit/cb96064eb849dfa61739a6b042dbbb2a0e138922))
- style(blvm): format the config writer the way CI rustfmt wants ([74a0eb720a7c](https://github.com/BTCDecoded/blvm/commit/74a0eb720a7cb2ec54d5ee7d6c6f34ed5dd8fb5a))
- fix(blvm): inline the format arguments clippy rejects ([e6fe7200c5dc](https://github.com/BTCDecoded/blvm/commit/e6fe7200c5dc5c250e2b6313dd9bee8d8537410f))
- fix(blvm): test BIP158 clearing from the node's default ([823e023fb69a](https://github.com/BTCDecoded/blvm/commit/823e023fb69a7845f698a963c7c0d67252d75711))
- fix(blvm): inline the feature-gated format arguments ([789edcb8d18d](https://github.com/BTCDecoded/blvm/commit/789edcb8d18d18f896ae4bc7f2e09e3e419796fa))
- fix(blvm): resolve the release feature list to the heed3 default ([1dfb88712746](https://github.com/BTCDecoded/blvm/commit/1dfb8871274646138c3751ed43fcaea60c09fc0a))

## [v0.1.78] - 2026-11-08

### Reconstructed

- fix(blvm): load miniscript on a fresh website install ([202c7f9e365a](https://github.com/BTCDecoded/blvm/commit/202c7f9e365abfc5b723ea6820a1bc22c45ea2e9))

## [v0.1.79] - 2026-11-09

### Reconstructed

- test(blvm): refuse a release whose default modules will not install ([627a92937493](https://github.com/BTCDecoded/blvm/commit/627a929374937b4ee64ab83eea1163306df74021))
- Compile CUDA kernels into the release binary without linking libcudart. ([55d54da410c6](https://github.com/BTCDecoded/blvm/commit/55d54da410c6a1cbd50bbec4253d2ff1109a2810))
- docs: fail the release hash check and name the workflows that exist ([f287b3be35cf](https://github.com/BTCDecoded/blvm/commit/f287b3be35cf63dae5309c982a52c3e1c5435ca2))
- chore(blvm): lock the published consensus, node, protocol, and secp crates ([c911353d4287](https://github.com/BTCDecoded/blvm/commit/c911353d428731dbc7fc2319096425ea0612360a))

## [v0.1.80] - 2026-11-11

### Reconstructed

- chore(blvm): lock the crates published for this release ([c33f405042c8](https://github.com/BTCDecoded/blvm/commit/c33f405042c824e6d151b286a156c3283ff0a915))
