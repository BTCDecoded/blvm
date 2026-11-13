# Changelog

All notable changes to `blvm-spec-lock` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Every section below is reconstructed from git history. Conventional Commits
were not enforced when those commits were written. Merge commits are omitted.

## [Unreleased]

## [v0.1.44] - 2026-10-22

### Reconstructed

- Bump version to 0.1.8 for release [skip ci] ([47ff5981ad70](https://github.com/BTCDecoded/blvm-spec-lock/commit/47ff5981ad7019958192a2cea51d789f16a01d95))
- ci(release): derive next patch from max used version ([7573548ba5dd](https://github.com/BTCDecoded/blvm-spec-lock/commit/7573548ba5dd7923e097cbafa23b13130e8801c9))
- feat(spec-lock): drift reporting and verifier robustness ([c4a7b8f8cb5e](https://github.com/BTCDecoded/blvm-spec-lock/commit/c4a7b8f8cb5ed5bf5024d651acc36a38370b41e7))
- Bump version to 0.1.10 for release [skip ci] ([d28be2a8aff8](https://github.com/BTCDecoded/blvm-spec-lock/commit/d28be2a8aff8c525aad56d241d1f8e057ac437ba))
- fix(parser): restore check-drift parseability for LaTeX-heavy contracts ([b192595bd724](https://github.com/BTCDecoded/blvm-spec-lock/commit/b192595bd724c9cd9b48574ee1282cb395a49244))
- Bump version to 0.1.11 for release [skip ci] ([c24555a11236](https://github.com/BTCDecoded/blvm-spec-lock/commit/c24555a1123696584679a8b009fd3bf6436fc666))
- feat(spec-lock): 0.1.12 — core crate split, verify JSON, formula gates ([289fb8c907cc](https://github.com/BTCDecoded/blvm-spec-lock/commit/289fb8c907ccfb249d97ad1a8946fc59572cfb40))
- style: run cargo fmt for 0.1.12 tree ([f0ed8fe8c308](https://github.com/BTCDecoded/blvm-spec-lock/commit/f0ed8fe8c30835626ded5e908a3cc33b648f29fd))
- Bump version to 0.1.13 for release [skip ci] ([ef9ab69f07e6](https://github.com/BTCDecoded/blvm-spec-lock/commit/ef9ab69f07e6f444ded6466d480049674e439127))
- ci(release): dry-run publish blvm-spec-lock-core only ([5c15a64df2de](https://github.com/BTCDecoded/blvm-spec-lock/commit/5c15a64df2de3fcf3f71a03bfa4ba941c0d85213))
- fix: collapse back to single blvm-spec-lock crate ([a8c3f1f4d627](https://github.com/BTCDecoded/blvm-spec-lock/commit/a8c3f1f4d6272ce85d5a9e030072605250c16c17))
- Bump version to 0.1.14 for release [skip ci] ([102908d8e53f](https://github.com/BTCDecoded/blvm-spec-lock/commit/102908d8e53fef1ca1afdb2bbdf5de5df0d1d016))
- fix(check-drift): exit 0 when only unparseable contracts remain ([d8ab1a39f194](https://github.com/BTCDecoded/blvm-spec-lock/commit/d8ab1a39f194a0ad073db3e0320d29431b4f8ee1))
- Bump version to 0.1.15 for release [skip ci] ([9bd23936d4d6](https://github.com/BTCDecoded/blvm-spec-lock/commit/9bd23936d4d6860df4f6b2232d6ac80d4e7190dd))
- fix(verify): demote spec-derived contract failures to partial status ([14df4d32b7c2](https://github.com/BTCDecoded/blvm-spec-lock/commit/14df4d32b7c27f3a3232872eb053e74ded6414f6))
- Bump version to 0.1.17 for release [skip ci] ([95a694b03d7d](https://github.com/BTCDecoded/blvm-spec-lock/commit/95a694b03d7d8bc80eafe9d7bce4a95b3518569e))
- fix(verify): exit 0 for partial results even under SPEC_LOCK_STRICT=1 ([4d6a6308ceb4](https://github.com/BTCDecoded/blvm-spec-lock/commit/4d6a6308ceb43f055c5eec25c34d26fff610094f))
- Bump version to 0.1.18 for release [skip ci] ([3ab89ba3fc2f](https://github.com/BTCDecoded/blvm-spec-lock/commit/3ab89ba3fc2fc64299f6b2d7d309da8957a7ded9))
- fix(spec-lock): harden verify/drift/enrich and trim deps ([33d4c7ab1d7f](https://github.com/BTCDecoded/blvm-spec-lock/commit/33d4c7ab1d7fd78d4d1f0cf7b5b18c331a28b307))
- Bump version to 0.1.19 for release [skip ci] ([c7ab07bf3c45](https://github.com/BTCDecoded/blvm-spec-lock/commit/c7ab07bf3c4547d0c936b734a6dc5dfc43c7fa40))
- fix(verify): demote spec-derived Z3 counterexamples to Partial ([2bf66acf703c](https://github.com/BTCDecoded/blvm-spec-lock/commit/2bf66acf703ce407b28eb359c5d526d825418933))
- Bump version to 0.1.20 for release [skip ci] ([7c43defcb11f](https://github.com/BTCDecoded/blvm-spec-lock/commit/7c43defcb11f3497a0f351c86ae607902710e7ce))
- fix(spec-lock): spec-derived Z3 counterexamples produce Failed, not Partial ([ac52e5bc56e9](https://github.com/BTCDecoded/blvm-spec-lock/commit/ac52e5bc56e921c9158976dbacfca5da71d76083))
- Bump version to 0.1.21 for release [skip ci] ([b55dd9e9a371](https://github.com/BTCDecoded/blvm-spec-lock/commit/b55dd9e9a371556a0a4229e3bd17eab5b0fadda1))
- fix(verify): treat body-translation failures as Partial, not Failed ([0aae788eafcf](https://github.com/BTCDecoded/blvm-spec-lock/commit/0aae788eafcf5af5e410c49a869ecfd83f772736))
- style(spec-lock): apply cargo fmt to verify.rs ([fbe05088e5b1](https://github.com/BTCDecoded/blvm-spec-lock/commit/fbe05088e5b1bab6287485f68dbf57e1798a16cf))
- Bump version to 0.1.22 for release [skip ci] ([44122cc64e44](https://github.com/BTCDecoded/blvm-spec-lock/commit/44122cc64e44a2247567e025b3b6b4a82776c417))
- fix(verify): treat empty-assignments SAT as translation gap, not failure ([e913a273e197](https://github.com/BTCDecoded/blvm-spec-lock/commit/e913a273e1977bce080c87c9f9761a5110ea0c01))
- Bump version to 0.1.23 for release [skip ci] ([7148dd0c59f6](https://github.com/BTCDecoded/blvm-spec-lock/commit/7148dd0c59f625a518f9e81349d38e9bdce1607f))
- fix(verify): extend vacuous-SAT + translation-gap demotion ([fc8b1dd3868b](https://github.com/BTCDecoded/blvm-spec-lock/commit/fc8b1dd3868be4bcfab085bffebe5ad1849b44e4))
- Bump version to 0.1.24 for release [skip ci] ([e7146980a5cd](https://github.com/BTCDecoded/blvm-spec-lock/commit/e7146980a5cdbac3d9c80b1a676d0063f75c396a))
- feat(spec-lock): close verification pipeline — enrich, translator, callee axioms ([83cd751abfc4](https://github.com/BTCDecoded/blvm-spec-lock/commit/83cd751abfc49a275d75879102013ceb0e089056))
- Bump version to 0.1.25 for release [skip ci] ([595833af6a09](https://github.com/BTCDecoded/blvm-spec-lock/commit/595833af6a0949e2a4980c0a9f70aca21a489bfd))
- fix(verify): |result(payload)| == 4 → result.len() (§10.1.1 CalculateChecksum) ([66e60a680414](https://github.com/BTCDecoded/blvm-spec-lock/commit/66e60a680414a6177a50a8651e2f4859d91ffc8e))
- style: apply rustfmt after verify cardinality fix ([d41590e67921](https://github.com/BTCDecoded/blvm-spec-lock/commit/d41590e679213e5bad6fe1989df3aeb14e290b20))
- Bump version to 0.1.27 for release [skip ci] ([85fdcbe33878](https://github.com/BTCDecoded/blvm-spec-lock/commit/85fdcbe33878e0e48d11bc0ab57bc4c016fe8089))
- fix(ci): commit fuzz/Cargo.lock for weekly --locked build ([041607d07246](https://github.com/BTCDecoded/blvm-spec-lock/commit/041607d0724699b6a367655c8f45ae2939cf29fa))
- Bump version to 0.1.28 for release [skip ci] ([a37980a40b36](https://github.com/BTCDecoded/blvm-spec-lock/commit/a37980a40b3696a1c5b884a3da2d7f1f0f7ff82c))
- ci: disable scheduled fuzz harness builds ([2bbaa088ed19](https://github.com/BTCDecoded/blvm-spec-lock/commit/2bbaa088ed195e12e52e7809b37e9d2d882a0da9))
- Bump version to 0.1.29 for release [skip ci] ([9c23542b72da](https://github.com/BTCDecoded/blvm-spec-lock/commit/9c23542b72da674d1f22bc20a2b725edaf2bc898))
- fix(enrich): auto-inject trivially-true contract for spec sections without parseable properties ([1b40a32bfd6a](https://github.com/BTCDecoded/blvm-spec-lock/commit/1b40a32bfd6ac3cde59e80efe874a79f38593af4))
- Bump version to 0.1.30 for release [skip ci] ([232bf5cf0cc8](https://github.com/BTCDecoded/blvm-spec-lock/commit/232bf5cf0cc86b38c299ff336787fef7adfc706d))
- chore: MSRV 1.85, edition 2024, and clippy fixes ([9bac92645c93](https://github.com/BTCDecoded/blvm-spec-lock/commit/9bac92645c939c168464850179dc5779a45abe9c))
- Bump version to 0.1.31 for release [skip ci] ([d68ac873192d](https://github.com/BTCDecoded/blvm-spec-lock/commit/d68ac873192d408a46c00fd5df8d2bbfbe0ae3f2))
- ci: allow manual workflow_dispatch to run Release & publish [skip ci] ([116d65230e7a](https://github.com/BTCDecoded/blvm-spec-lock/commit/116d65230e7aea7da337b3c614cc7e2043a748a2))
- docs: remove links to workspace-local planning docs ([193a5a8c7274](https://github.com/BTCDecoded/blvm-spec-lock/commit/193a5a8c72742777df29f3ef045963fd791a4421))
- Bump version to 0.1.32 for release [skip ci] ([e2f0290eeae5](https://github.com/BTCDecoded/blvm-spec-lock/commit/e2f0290eeae53171804088f1c2f60576418bd0e6))
- peel: ignore and drop fuzz/target artifacts (S2) ([85ae6e1d7992](https://github.com/BTCDecoded/blvm-spec-lock/commit/85ae6e1d799245aa879b5bd5fc981aad900616f9))
- Bump version to 0.1.33 for release [skip ci] ([a37e36c1201d](https://github.com/BTCDecoded/blvm-spec-lock/commit/a37e36c1201d70335d455719fec4db235aec75cc))
- fix(lock): treat shr as concrete; unroll constant-bound for ([5522c61c41a3](https://github.com/BTCDecoded/blvm-spec-lock/commit/5522c61c41a3585a86a5b0c4c323719d822aba57))
- fix(lock): pass-through #[spec_locked] at compile time (#1) ([be8238cf754a](https://github.com/BTCDecoded/blvm-spec-lock/commit/be8238cf754ab7971290f53326cc0b1f7823d6ea))
- Bump version to 0.1.34 for release [skip ci] ([4d8657d1c404](https://github.com/BTCDecoded/blvm-spec-lock/commit/4d8657d1c40404be283eb32a25c2d8b336f9f5a4))
- test(lock): score consensus mutants against the obligations CI proves ([2995f206d99b](https://github.com/BTCDecoded/blvm-spec-lock/commit/2995f206d99b28ac27a3aa3e4b24b7795a2a14ed))
- fix(lock): encode checked arithmetic as signed 64-bit bitvectors ([9215eb15c128](https://github.com/BTCDecoded/blvm-spec-lock/commit/9215eb15c128e0274c7cb8ecbdf7d7d6a40032b7))
- test(lock): require every consensus mutant to be UNSAT ([f278f86426d4](https://github.com/BTCDecoded/blvm-spec-lock/commit/f278f86426d467270f22c43053054db52b605464))
- test(lock): fail if the shipping checks the mutants describe are deleted ([5d2f2f684425](https://github.com/BTCDecoded/blvm-spec-lock/commit/5d2f2f68442554c42a0f5a13b011740920890de7))
- test(lock): read census clauses from PROTOCOL.md ([021c83f34c59](https://github.com/BTCDecoded/blvm-spec-lock/commit/021c83f34c59637357f8f847c5943a4a88ca88eb))
- Bump version to 0.1.35 for release [skip ci] ([91f17f9f9663](https://github.com/BTCDecoded/blvm-spec-lock/commit/91f17f9f9663a73505d9065d2e45f77054a0de7a))
- fix(lock): keep documented sections from failing check-drift ([7cb5d6db7879](https://github.com/BTCDecoded/blvm-spec-lock/commit/7cb5d6db7879c470e21f55514805516084886980))
- Bump version to 0.1.36 for release [skip ci] ([71661d951b27](https://github.com/BTCDecoded/blvm-spec-lock/commit/71661d951b2785e09f94217183aa0e6b30037278))
- fix(lock): surface a missing formula id instead of dropping enrichment ([fa2ea9a4e427](https://github.com/BTCDecoded/blvm-spec-lock/commit/fa2ea9a4e4272349cc3adfeeb04ba491026daabd))
- Bump version to 0.1.37 for release [skip ci] ([affbe226d0fe](https://github.com/BTCDecoded/blvm-spec-lock/commit/affbe226d0fed505cc90790aa5402ccc749d3854))
- fix(lock): let the consensus verifier pass a contract the body did not discharge ([8c6a5461fee7](https://github.com/BTCDecoded/blvm-spec-lock/commit/8c6a5461fee7d67c37b377e56e909823a1e90adf))
- Bump version to 0.1.38 for release [skip ci] ([37d041200243](https://github.com/BTCDecoded/blvm-spec-lock/commit/37d0412002439f8dafe688c250263799ca435543))
- fix(lock): accept a Z3 unsat that did not include the function body ([0009372bcdab](https://github.com/BTCDecoded/blvm-spec-lock/commit/0009372bcdab7a0676bc8450278735654bc46ea1))
- Bump version to 0.1.39 for release [skip ci] ([426d66ef60db](https://github.com/BTCDecoded/blvm-spec-lock/commit/426d66ef60db5b4a35336f27a2287061102202e6))
- fix(lock): treat an incomplete Z3 model as partial ([774ce71e4461](https://github.com/BTCDecoded/blvm-spec-lock/commit/774ce71e44617242b480f5d2a66499995eea1b81))
- Bump version to 0.1.40 for release [skip ci] ([8fd77ab64cd4](https://github.com/BTCDecoded/blvm-spec-lock/commit/8fd77ab64cd486da59214146515d98c835fa1225))
- fix(lock): pin the new consensus rows for subsidy, reorg, and script checks ([243b518398ce](https://github.com/BTCDecoded/blvm-spec-lock/commit/243b518398ce92643afc8512179095336b55249f))
- Bump version to 0.1.41 for release [skip ci] ([340b63b0abac](https://github.com/BTCDecoded/blvm-spec-lock/commit/340b63b0abacea519e1948e273af26c027941c96))
- fix(lock): expect a BIP54 coinbase locktime of height minus one ([522c5c2379b0](https://github.com/BTCDecoded/blvm-spec-lock/commit/522c5c2379b0cab1e85bc4ab2d70092818717651))
- Bump version to 0.1.42 for release [skip ci] ([aacb0eecdf17](https://github.com/BTCDecoded/blvm-spec-lock/commit/aacb0eecdf176fd23279e2cca0097b7331c46abd))
- fix(lock): keep a function call inside a formula ([8005213e401c](https://github.com/BTCDecoded/blvm-spec-lock/commit/8005213e401ca4e89405643849fe9b51f223ce10))
- Bump version to 0.1.43 for release [skip ci] ([902444bd061d](https://github.com/BTCDecoded/blvm-spec-lock/commit/902444bd061df74c601654d749c63d0dfad6a6f2))
- ci: tag each crates.io release as v<version> (port consensus Create git tag) (#2) ([6f2794cc0028](https://github.com/BTCDecoded/blvm-spec-lock/commit/6f2794cc00283b0d7f51841cf15bf02238b9e2fe))
- Bump version to 0.1.44 for release [skip ci] ([046da48dbc33](https://github.com/BTCDecoded/blvm-spec-lock/commit/046da48dbc333e6ee8ca8bed2009541c2cdb00e8))

## [v0.1.45] - 2026-10-22

### Reconstructed

- fix(lock): match median time and proof of work to the source operators ([3a55aeb85f8d](https://github.com/BTCDecoded/blvm-spec-lock/commit/3a55aeb85f8d07071b1ed2e3523a9d9bacbc22f9))
- Bump version to 0.1.45 for release [skip ci] ([389f6a278049](https://github.com/BTCDecoded/blvm-spec-lock/commit/389f6a278049820de5e66a73531aeec2bdcf4d0b))

## [v0.1.46] - 2026-11-04

### Reconstructed

- fix(lock): run parsed production bodies on the mutation gate ([6382e2c1fda6](https://github.com/BTCDecoded/blvm-spec-lock/commit/6382e2c1fda6b9c4892aa750f0f2a7dff2090ae5))
- fix(lock): stop proving a contract when the body is a different operation ([5cb9813a4af5](https://github.com/BTCDecoded/blvm-spec-lock/commit/5cb9813a4af56b51d3efe6eb8d0cb3b470b4aea2))
- fix(lock): follow the shared consensus bodies ([23dc83f5e268](https://github.com/BTCDecoded/blvm-spec-lock/commit/23dc83f5e268287721c7348ef02b1724f7e4bece))
- fix(lock): prove witness bounds from the spec and match the coverage report ([adfc94d9b635](https://github.com/BTCDecoded/blvm-spec-lock/commit/adfc94d9b6359fbcaf50e2caaddbda2e6bb006d8))
- fix(lock): skip sibling locks when this repo is checked out alone ([14c3d61c0c5d](https://github.com/BTCDecoded/blvm-spec-lock/commit/14c3d61c0c5d29de321659950ee90591679979f5))
- Bump version to 0.1.46 for release [skip ci] ([318b88e7e072](https://github.com/BTCDecoded/blvm-spec-lock/commit/318b88e7e07219a4d4cb5c0fc444f6eb4f89b029))

## [v0.1.47] - 2026-11-04

### Reconstructed

- docs: pin the btc-lean commit and the axiom allowlist ([8a427beba4fa](https://github.com/BTCDecoded/blvm-spec-lock/commit/8a427beba4fa3b3a823061b7415c3ff03c344f7a))
- feat(lock): emit Lean propositions from the formula AST ([12b233fd19a3](https://github.com/BTCDecoded/blvm-spec-lock/commit/12b233fd19a3bd9737f268faf146a98a3699d280))
- feat(lock): report an evidence set on each anchor ([14b0efb708c1](https://github.com/BTCDecoded/blvm-spec-lock/commit/14b0efb708c163c5fe8ec5c232ad7f6b0d5551e3))
- feat(lock): gate Lean coverage on the pinned checkout ([862442df865c](https://github.com/BTCDecoded/blvm-spec-lock/commit/862442df865c7e38d73d1f0962c3b3aadcfa612f))
- feat(lock): compare Rust and btc-lean only as differential evidence ([b199730b8a2b](https://github.com/BTCDecoded/blvm-spec-lock/commit/b199730b8a2b11b7a2e7b6c3fa4a5a8418a9b3e4))
- test(lock): fail the Lean gate on the seven bad links ([8b1e35906944](https://github.com/BTCDecoded/blvm-spec-lock/commit/8b1e35906944e7772174e076bc5ed21313f7043f))
- ci: run the pinned Lean gates without a skip switch ([12ce76e8808a](https://github.com/BTCDecoded/blvm-spec-lock/commit/12ce76e8808a438d007696c920eb48c2e6be5d71))
- fix(lock): check a cited Lean link with the elaborator ([bf5b4727aa28](https://github.com/BTCDecoded/blvm-spec-lock/commit/bf5b4727aa28075758c7a06058222d9c3e79e6d9))
- Report which Orange Paper sentences the Lean model closes. ([d0edd937b0da](https://github.com/BTCDecoded/blvm-spec-lock/commit/d0edd937b0da1de7583a39ef40de92695a830b5b))
- fix(lock): compile the merged sentence tests on CI ([ce1953ac91d6](https://github.com/BTCDecoded/blvm-spec-lock/commit/ce1953ac91d6ba866f7340ce371f8bcc94996d17))
- fix(lock): skip theorem 6.1.2 checks when the spec checkout is absent ([7007ad667213](https://github.com/BTCDecoded/blvm-spec-lock/commit/7007ad667213547d77fdb3ca3d14c289467ca669))
- fix(lock): skip inventory rows that read H when the spec is absent ([7ec798fcae81](https://github.com/BTCDecoded/blvm-spec-lock/commit/7ec798fcae814b6d15dee9baa3f3f543d496b8a0))
- Bump version to 0.1.47 for release [skip ci] ([040adcf3318d](https://github.com/BTCDecoded/blvm-spec-lock/commit/040adcf3318d806307ac5cc8d026736ab9a8fd8b))

## [v0.1.48] - 2026-11-04

### Reconstructed

- fix(lock): truncate unparseable contracts on a char boundary ([cef4f16d0b2f](https://github.com/BTCDecoded/blvm-spec-lock/commit/cef4f16d0b2f87a8cdd026fc1372a09cb653f6cb))
- Bump version to 0.1.48 for release [skip ci] ([fd0c23e1066f](https://github.com/BTCDecoded/blvm-spec-lock/commit/fd0c23e1066f68e038249ec78c2761249e965008))

## [v0.1.49] - 2026-11-05

### Reconstructed

- fix(lock): prove each open body by an edit that Z3 rejects ([c88f0eb2b14d](https://github.com/BTCDecoded/blvm-spec-lock/commit/c88f0eb2b14d1caff06b4b156d57600b79bbb022))
- docs: count the 13 functions proved from the body ([bbadeaa1da09](https://github.com/BTCDecoded/blvm-spec-lock/commit/bbadeaa1da091c890891918dacf2f9863349dc12))
- Bump version to 0.1.49 for release [skip ci] ([f48fe30590f3](https://github.com/BTCDecoded/blvm-spec-lock/commit/f48fe30590f371c57059093ab57bf405a480a67d))

## [v0.1.50] - 2026-11-05

### Reconstructed

- docs: name Lean beside Z3 and stop freezing the old lock count ([ac38c8a1d215](https://github.com/BTCDecoded/blvm-spec-lock/commit/ac38c8a1d21515930887183271d131e884f8a309))
- Bump version to 0.1.50 for release [skip ci] ([3164afb3a435](https://github.com/BTCDecoded/blvm-spec-lock/commit/3164afb3a435705893e83a5e92ecd3c99a98822f))

## [v0.1.51] - 2026-11-05

### Reconstructed

- fix(drift): report a parse gap as unparseable, not missing from the paper (#4) ([245862d0fe12](https://github.com/BTCDecoded/blvm-spec-lock/commit/245862d0fe12db529d84d507e2711924af94eb66))
- Bump version to 0.1.51 for release [skip ci] ([eca713cd2485](https://github.com/BTCDecoded/blvm-spec-lock/commit/eca713cd2485e4836e6352106c031bd1bc32fc3d))

## [v0.1.52] - 2026-11-07

### Reconstructed

- fix(lock): stop a directory symlink from cycling the spec walk ([faa21c46b11d](https://github.com/BTCDecoded/blvm-spec-lock/commit/faa21c46b11dcf14e550c58244c20255516dc547))
- fix(lock): reject a signed BIP68 version compare ([73f6b455067b](https://github.com/BTCDecoded/blvm-spec-lock/commit/73f6b455067bd624e39585e6a8ea33f80d6f7ff8))
- style(lock): format the BIP68 predicate and the lean walk assertion ([631cf4fae047](https://github.com/BTCDecoded/blvm-spec-lock/commit/631cf4fae047751e6167c6e5c0257541f8bc982a))
- Bump version to 0.1.52 for release [skip ci] ([ab797e56f79b](https://github.com/BTCDecoded/blvm-spec-lock/commit/ab797e56f79b7adf56da5791039e41f900aa8c79))

## [v0.1.53] - 2026-11-09

### Reconstructed

- docs: stop saying --strict fails a Partial result ([d9a3cbe52c78](https://github.com/BTCDecoded/blvm-spec-lock/commit/d9a3cbe52c7837cc6e3aa834ee50e6556fcac761))
- Bump version to 0.1.53 for release [skip ci] ([f363a57a50dd](https://github.com/BTCDecoded/blvm-spec-lock/commit/f363a57a50dd3dd9c0b58fb1c694dc151c6b25f1))

## [v0.1.54] - 2026-11-10

### Reconstructed

- fix(lock): do not verify an unmatched name as another function ([1276d6576da4](https://github.com/BTCDecoded/blvm-spec-lock/commit/1276d6576da4a3d378a4b2f5219acb93ec284f3c))
- Fix main red: inventory baseline row + rustfmt for 1276d65 (#5) ([1c6b8f44268f](https://github.com/BTCDecoded/blvm-spec-lock/commit/1c6b8f44268faab81e988617fd62e03b262f6c94))
- Bump version to 0.1.54 for release [skip ci] ([bddfae4ac806](https://github.com/BTCDecoded/blvm-spec-lock/commit/bddfae4ac8063f78bf654d7a2245c810d89f98d1))
