# BLVM 0.2.0-beta.1

AI-drafted summary: not produced. No Cloudflare Workers AI credentials were
available, and the summary is not allowed to invent claims. A person reviews
the aggregate below before publishing.

DIFFERENTIAL_RECORD_ID: pending

This is a dry run. It was not tagged and it was not published.

# Freeze-base pins for the 0.2.0-beta.1 dry run.
# Not a published release. differential_record_id stays pending.
project_version = "0.2.0-beta.1"
differential_record_id = "pending"
variants = ["blvm", "blvm-minimal"]

[crates.blvm]
version = "0.1.0"
git = "d7741e325bd8e82a389da5249e5f05da52b363f8"

[crates.blvm-node]
version = "0.1.92"
git = "36bb40c7e9a3f805274fa7e1bda30d0a6c082560"

[crates.blvm-consensus]
version = "0.1.82"
git = "f63c32856a2da874296524f40b8cbd35518d8096"

[crates.blvm-protocol]
version = "0.1.48"
git = "0bc9307a2235831fff52548621301b6084a9e809"

[crates.blvm-spec-lock]
version = "0.1.54"
git = "bddfae4ac8063f78bf654d7a2245c810d89f98d1"

[crates.blvm-primitives]
version = "0.1.34"
git = "0802458403a155206560749ab279470832988fe4"

[crates.blvm-secp256k1]
version = "0.1.16"
git = "1eee63cc0ee48182cb26f4bca5fa9ca79a3e7ab0"

[crates.blvm-sdk]
version = "0.1.22"
git = "72c097b88febb66c5708268cec108163565dbd43"

## Consensus

- blvm-consensus: test(consensus): lock the BIP34 coinbase height encoding through 65535 ([f4e06a68a947](https://github.com/BTCDecoded/blvm-consensus/commit/f4e06a68a947153585a449711dafa608dc43dcc4))
- blvm-consensus: test(consensus): lock merkle roots for every small tree of three ids ([a687e4a527b0](https://github.com/BTCDecoded/blvm-consensus/commit/a687e4a527b01e7e00248501f898b03de2a42a81))
- blvm-consensus: test(consensus): lock sigop counts when a push hides the next opcode ([e1ef9d3a33f8](https://github.com/BTCDecoded/blvm-consensus/commit/e1ef9d3a33f839f3f2b34d1ff9c90bf068010e86))
- blvm-consensus: test(consensus): lock witness programs across version and length ([6b8b3303a020](https://github.com/BTCDecoded/blvm-consensus/commit/6b8b3303a020d33fe7b790e6068a4ef8942636ae))
- blvm-consensus: test(consensus): lock CLTV across the height and timestamp cut ([86d9e7116001](https://github.com/BTCDecoded/blvm-consensus/commit/86d9e71160010031dab586a123d67a9297ee16a3))
- blvm-consensus: test(consensus): lock difficulty retarget across the compact grid ([30a9589fb57e](https://github.com/BTCDecoded/blvm-consensus/commit/30a9589fb57eb17c9a2c62afab4ae72509db98c2))
- blvm-consensus: fix(consensus): keep the borrow when chainwork subtraction crosses a zero limb ([7f6296b62c0f](https://github.com/BTCDecoded/blvm-consensus/commit/7f6296b62c0f2ad3b495e0ddaad8933f984ae802))
- blvm-consensus: fix(consensus): score every committed script and transaction vector ([db81faac6d65](https://github.com/BTCDecoded/blvm-consensus/commit/db81faac6d6550057840ac38de0855ede78259f7))
- blvm-consensus: Bump version to 0.1.82 for release [skip ci] ([f63c32856a2d](https://github.com/BTCDecoded/blvm-consensus/commit/f63c32856a2da874296524f40b8cbd35518d8096))
- blvm-consensus: refactor(consensus): move large test modules out of the implementation files ([8142c648586d](https://github.com/BTCDecoded/blvm-consensus/commit/8142c648586d01decaf863ddd84ea69e830b23f3))
- blvm-consensus: Bump version to 0.1.81 for release [skip ci] ([ba0dd3f729a7](https://github.com/BTCDecoded/blvm-consensus/commit/ba0dd3f729a7aca419de0c4ee22dc302ff6d86a3))
- blvm-consensus: fix(consensus): expect STRICTENC to reject an undefined hashtype ([e9b1ad40d8e4](https://github.com/BTCDecoded/blvm-consensus/commit/e9b1ad40d8e4337edaa7742fa4b02f522be6efdd))
- blvm-consensus: fix(consensus): give the BIP66 test the hash of its pubkey ([ff1567740d0a](https://github.com/BTCDecoded/blvm-consensus/commit/ff1567740d0a53796dc58be2de27f007b3e0db02))
- blvm-consensus: fix(consensus): skip STRICTENC on a 0-of-n multisig ([07d079ecf532](https://github.com/BTCDecoded/blvm-consensus/commit/07d079ecf5327ce0ff358955f7f42373760358c5))
- blvm-consensus: fix(consensus): accept a bad BIP34 prefix before regtest activation ([5108c43b71dd](https://github.com/BTCDecoded/blvm-consensus/commit/5108c43b71dd84728767e9f5181377dcbfa3ef9a))
- blvm-consensus: fix(consensus): give the empty reserved-value case one coinbase stack ([ddbc5a890fb4](https://github.com/BTCDecoded/blvm-consensus/commit/ddbc5a890fb45c57b002f2b4f9d2523e822e9fa1))
- blvm-consensus: fix(consensus): treat a missing witness matrix as empty stacks ([f1691a8d1deb](https://github.com/BTCDecoded/blvm-consensus/commit/f1691a8d1deb80f28db5ca641fcb2c43750903af))
- blvm-consensus: fix(consensus): reject STRICTENC failures and unverified Schnorr slots ([de285af2570e](https://github.com/BTCDecoded/blvm-consensus/commit/de285af2570e28559964bfa748b08cda3a661c8b))
- blvm-consensus: Bump version to 0.1.80 for release [skip ci] ([c14831a60898](https://github.com/BTCDecoded/blvm-consensus/commit/c14831a60898cf7444ab944c9d152d7ea9620ee5))
- blvm-consensus: test(consensus): an overflowing output sum is an invalid transaction ([2cd6980f8f4b](https://github.com/BTCDecoded/blvm-consensus/commit/2cd6980f8f4bd096ebab4c143b02fb29e7df1104))
- blvm-consensus: fix(consensus): treat an overflowing output sum as an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- blvm-consensus: fix(consensus): reject structural failures instead of returning errors ([640ff3271904](https://github.com/BTCDecoded/blvm-consensus/commit/640ff3271904a4c90478a353c19dcbaf8db6e2e1))
- blvm-consensus: fix(consensus): accept header version 0 before BIP34 ([0f40b74095ea](https://github.com/BTCDecoded/blvm-consensus/commit/0f40b74095eab76167df3a3b4153c549a6a088be))
- blvm-consensus: fix(consensus): enforce BIP68 on the unsigned version word ([edcdb883e7c0](https://github.com/BTCDecoded/blvm-consensus/commit/edcdb883e7c06ab3d8dd487780c9125d1905d108))
- blvm-consensus: Make spec-lock optional so the node build does not compile it. ([fe108a5dd232](https://github.com/BTCDecoded/blvm-consensus/commit/fe108a5dd232c6a42fc42f7b0d34f08fd0805c97))
- blvm-consensus: Bump version to 0.1.79 for release [skip ci] ([920a5f6787fc](https://github.com/BTCDecoded/blvm-consensus/commit/920a5f6787fca44584a5161db5955ad094f8c682))
- blvm-consensus: fix(consensus): count a BIP9 signal only when the version prefix is 001 ([ed239f28e663](https://github.com/BTCDecoded/blvm-consensus/commit/ed239f28e6632394f208a9ee5784e6a9a2d20f23))
- blvm-consensus: Bump version to 0.1.78 for release [skip ci] ([a967bb09c49d](https://github.com/BTCDecoded/blvm-consensus/commit/a967bb09c49d0d95929f1dc9f3c9a9d8da7fca15))
- blvm-consensus: Keep assume-valid checks on the checked seed and round-trip the undo log. ([5cf1f7e57344](https://github.com/BTCDecoded/blvm-consensus/commit/5cf1f7e57344a1a4c55b0d3d842dd6138f32918d))
- blvm-consensus: Bump version to 0.1.77 for release [skip ci] ([21bb41455491](https://github.com/BTCDecoded/blvm-consensus/commit/21bb41455491b4c4ea7fde34862337723c2fed23))
- blvm-consensus: fix(consensus): drop the unread sig cache and close policy gaps ([a79c0c5800bb](https://github.com/BTCDecoded/blvm-consensus/commit/a79c0c5800bbcc364c19c80b124b1367d9e9ecbb))
- blvm-consensus: Bump version to 0.1.76 for release [skip ci] ([a6200fd36765](https://github.com/BTCDecoded/blvm-consensus/commit/a6200fd36765ebd6cd76425a3172dfa8aa3cc1c7))
- blvm-consensus: test(consensus): a rejected script is an invalid block ([46b7e1bdf4f1](https://github.com/BTCDecoded/blvm-consensus/commit/46b7e1bdf4f1fd10c00760393c54a020f7fb2dda))
- blvm-consensus: fix(consensus): honor DERSIG without a second activation check ([168b06dc94d9](https://github.com/BTCDecoded/blvm-consensus/commit/168b06dc94d9369e5705876f81cb6da95377d6e4))
- blvm-consensus: fix(consensus): let the supply check ship on the pinned verifier ([4619088085b7](https://github.com/BTCDecoded/blvm-consensus/commit/4619088085b7f9c0e551b51c4dc1793a9cb0cef2))
- blvm-consensus: fix(consensus): reject the wrong block, version, and signature ([8e09804f9d28](https://github.com/BTCDecoded/blvm-consensus/commit/8e09804f9d28ce18903b3bc58ffd2fbfd41fd48e))
- blvm-consensus: fix(consensus): check the supply cap in the function body ([32d20e3fe9e8](https://github.com/BTCDecoded/blvm-consensus/commit/32d20e3fe9e8c8e7aadc7eef5ef6543663947a49))
- blvm-consensus: Bump version to 0.1.75 for release [skip ci] ([86ae2db60930](https://github.com/BTCDecoded/blvm-consensus/commit/86ae2db60930c90f3d2a500b668451ff5338e255))
- blvm-consensus: fix(consensus): drop the signal bit from the replacement fee property ([abd1670ed408](https://github.com/BTCDecoded/blvm-consensus/commit/abd1670ed40864362d6a4d458281c09a9ec4c8f1))
- blvm-consensus: fix(consensus): let the node decide whether a replacement must signal ([4d7345b9a207](https://github.com/BTCDecoded/blvm-consensus/commit/4d7345b9a207ecb3771dadbb3cfba5854c3b4bfe))
- blvm-consensus: Bump version to 0.1.74 for release [skip ci] ([960d31b64da8](https://github.com/BTCDecoded/blvm-consensus/commit/960d31b64da8ed76ac28ad0e0849f6d950a5331f))
- blvm-consensus: fix(consensus): reject a replacement whose original does not signal ([5454a1c9c465](https://github.com/BTCDecoded/blvm-consensus/commit/5454a1c9c465391da4f41f531fe235b4219cde1b))
- blvm-consensus: fix(consensus): match replacement tests to the relay bump ([a8de49e193cb](https://github.com/BTCDecoded/blvm-consensus/commit/a8de49e193cb37dfe083a8630b5381543df6a8bf))
- blvm-consensus: fix(consensus): keep assume-valid checks and recognize pay-to-anchor ([7889adfce1c8](https://github.com/BTCDecoded/blvm-consensus/commit/7889adfce1c8f33cfcb309ab994e5f10d0643ad7))
- blvm-consensus: fix(consensus): share the duplicated script and sighash bodies ([0198f65bb655](https://github.com/BTCDecoded/blvm-consensus/commit/0198f65bb655cae285f67104b0d39bb5db1abbae))
- blvm-spec: Add the Lean model for the Orange Paper sentences spec-lock checks. ([80b3fef61b5d](https://github.com/BTCDecoded/blvm-spec/commit/80b3fef61b5da9c8d0bf005c33367274ace066d8))

## Breaking changes

- None in this range.

## Security

Ids below are copied from the advisory record.

### Closed

- BLVM-2026-0001 (consensus, closed, blvm-consensus, fixed version 0.1.80, crate release 0.1.80): An overflowing output sum was an internal error instead of an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- BLVM-2026-0002 (consensus, closed, blvm-node, fixed version 0.1.92, crate release 0.1.92): A failed reorg left the coin set rewound ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- BLVM-2026-0003 (resource exhaustion, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Inbound TCP connections were not capped per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- BLVM-2026-0004 (local-only, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Module processes were not confined ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))

### Open

- BLVM-2026-0101 (resource exhaustion, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0118 still applies to the dependency tree
- BLVM-2026-0102 (resource exhaustion, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0119 still applies to the dependency tree
- BLVM-2026-0103 (remote crash, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0338 still applies to the dependency tree
- BLVM-2026-0104 (resource exhaustion, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0339 still applies to the dependency tree
- BLVM-2026-0105 (remote crash, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0340 still applies to the dependency tree
- BLVM-2026-0106 (resource exhaustion, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0341 still applies to the dependency tree
- BLVM-2026-0107 (resource exhaustion, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0342 still applies to the dependency tree
- BLVM-2026-0108 (remote crash, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0424 still applies to the dependency tree
- BLVM-2026-0109 (resource exhaustion, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0491 still applies to the dependency tree
- BLVM-2026-0110 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0504 still applies to the dependency tree
- BLVM-2026-0111 (remote crash, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0487 still applies to the dependency tree
- BLVM-2026-0112 (remote crash, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0489 still applies to the dependency tree
- BLVM-2026-0113 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0512 still applies to the dependency tree
- BLVM-2026-0114 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0511 still applies to the dependency tree
- BLVM-2026-0115 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0505 still applies to the dependency tree
- BLVM-2026-0116 (remote crash, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0490 still applies to the dependency tree
- BLVM-2026-0117 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): RUSTSEC-2026-0514 still applies to the dependency tree

### Commits classified as security

- blvm-node: fix(node): redact RPC and governance secrets in Debug ([dcffe304ff5c](https://github.com/BTCDecoded/blvm-node/commit/dcffe304ff5c368218e8eff0bdb0434a53358d37))

## Features

- blvm: feat(blvm): pin blvm-index in the default module set ([4fe0f7e14047](https://github.com/BTCDecoded/blvm/commit/4fe0f7e14047dd1362b21ef5730c5bb37b25a3a1))
- blvm-node: feat(node): load the minimal-hardened profile without a public field ([e3d1da4f4849](https://github.com/BTCDecoded/blvm-node/commit/e3d1da4f4849d2796b882f1cd3aeaf4a48617228))
- blvm-node: feat(module): add the node-owned timer service ([e2920875520d](https://github.com/BTCDecoded/blvm-node/commit/e2920875520d1bb91bda58ecffd9ecee450d612e))
- blvm-spec-lock: feat(lock): compare Rust and btc-lean only as differential evidence ([b199730b8a2b](https://github.com/BTCDecoded/blvm-spec-lock/commit/b199730b8a2b11b7a2e7b6c3fa4a5a8418a9b3e4))
- blvm-spec-lock: feat(lock): gate Lean coverage on the pinned checkout ([862442df865c](https://github.com/BTCDecoded/blvm-spec-lock/commit/862442df865c7e38d73d1f0962c3b3aadcfa612f))
- blvm-spec-lock: feat(lock): report an evidence set on each anchor ([14b0efb708c1](https://github.com/BTCDecoded/blvm-spec-lock/commit/14b0efb708c163c5fe8ec5c232ad7f6b0d5551e3))
- blvm-spec-lock: feat(lock): emit Lean propositions from the formula AST ([12b233fd19a3](https://github.com/BTCDecoded/blvm-spec-lock/commit/12b233fd19a3bd9737f268faf146a98a3699d280))

## Fixes

- blvm: fix(blvm): compare getblockcount across the three release artifacts ([46c23a0d255f](https://github.com/BTCDecoded/blvm/commit/46c23a0d255fc6e6f8ef3b60d98a556efe23a102))
- blvm: fix(blvm): do not report artifact parity before the RPC comparison ([8ae3c4464cbe](https://github.com/BTCDecoded/blvm/commit/8ae3c4464cbe8abb5a66fba822a5eb9a0d936d31))
- blvm: fix(blvm): load miniscript on a fresh website install ([202c7f9e365a](https://github.com/BTCDecoded/blvm/commit/202c7f9e365abfc5b723ea6820a1bc22c45ea2e9))
- blvm: fix(blvm): resolve the release feature list to the heed3 default ([1dfb88712746](https://github.com/BTCDecoded/blvm/commit/1dfb8871274646138c3751ed43fcaea60c09fc0a))
- blvm: fix(blvm): inline the feature-gated format arguments ([789edcb8d18d](https://github.com/BTCDecoded/blvm/commit/789edcb8d18d18f896ae4bc7f2e09e3e419796fa))
- blvm: fix(blvm): test BIP158 clearing from the node's default ([823e023fb69a](https://github.com/BTCDecoded/blvm/commit/823e023fb69a7845f698a963c7c0d67252d75711))
- blvm: fix(blvm): inline the format arguments clippy rejects ([e6fe7200c5dc](https://github.com/BTCDecoded/blvm/commit/e6fe7200c5dc5c250e2b6313dd9bee8d8537410f))
- blvm: fix(blvm): refuse a missing named config and replace the file on write ([e01398712202](https://github.com/BTCDecoded/blvm/commit/e013987122023d81d8ad9a525dce0fcb1c0616fd))
- blvm: fix(blvm): refuse stratum flags when the binary has no stratum feature ([1c3cbd1e41ef](https://github.com/BTCDecoded/blvm/commit/1c3cbd1e41efd8b3954e02af20e10faa9d22cc29))
- blvm-node: fix(node): give the no-commitment retire loop its engine handle ([18286b35533b](https://github.com/BTCDecoded/blvm-node/commit/18286b35533bf14afb57a69c56a50f696e9131e6))
- blvm-node: fix(node): grind the side-block submit until it meets the regtest target ([70b8562522b5](https://github.com/BTCDecoded/blvm-node/commit/70b8562522b53dce01ba0435211252a44f156a91))
- blvm-node: fix(node): connect a submitted sibling at its parent's height ([148f75f66fec](https://github.com/BTCDecoded/blvm-node/commit/148f75f66fecfc754e6098126fdaa043ac4c68bf))
- blvm-node: fix(node): restore a failed reorg and bound peer intake ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- blvm-node: fix(node): apply the configured fee floor in conservative RBF ([d29ecfbf7476](https://github.com/BTCDecoded/blvm-node/commit/d29ecfbf7476d79061e6170f7364c73847be270e))
- blvm-node: fix(module): accept every in-flight timer acknowledgement ([4922e38951ca](https://github.com/BTCDecoded/blvm-node/commit/4922e38951cac5ff337c2bdd8d779d219a6724f6))
- blvm-node: fix(node): keep a reorg out of fee-history failures ([19c16de0472c](https://github.com/BTCDecoded/blvm-node/commit/19c16de0472c54376674eb9c50a3c86c613208c8))
- blvm-node: fix(node): replace by the incremental relay fee in standard mode ([05e3e1402723](https://github.com/BTCDecoded/blvm-node/commit/05e3e1402723c7b69498d656ef3bec7f1315a5be))
- blvm-node: fix(node): close mempool, IBD, and storage holes from the QA pass ([982ef1cde1d0](https://github.com/BTCDecoded/blvm-node/commit/982ef1cde1d07e14c72c86f91e0b320b76271a39))
- blvm-node: fix(node): install a module release whose module.toml lags the tag ([778423d6504e](https://github.com/BTCDecoded/blvm-node/commit/778423d6504e774b06740fd87837e7dab1b52187))
- blvm-node: fix(node): keep Landlock in the Linux build ([9918c7a7379d](https://github.com/BTCDecoded/blvm-node/commit/9918c7a7379d16437350df45f10c97b120be19bc))
- blvm-node: fix(node): publish the storage fence before the node crate ([92aaeb01ca88](https://github.com/BTCDecoded/blvm-node/commit/92aaeb01ca88fd7974db280c2f8d5ea782d3ddc8))
- blvm-node: fix(node): close module IPC connections when the server task stops ([2b55450fb1c0](https://github.com/BTCDecoded/blvm-node/commit/2b55450fb1c0c638c347afe26fd93d3ca43e7811))
- blvm-node: fix(node): keep Iroh peer identity behind the iroh feature ([1fb07de1201b](https://github.com/BTCDecoded/blvm-node/commit/1fb07de1201bd8a9fb4e873eaca9c6627ea4cf43))
- blvm-node: fix(node): make fuzz, landlock, and clippy match the CI contract ([e0692df0f365](https://github.com/BTCDecoded/blvm-node/commit/e0692df0f3652785986cb5f1322b111ea20e5f5a))
- blvm-node: fix(module): publish ban-list share and receive events ([18fce9ff2bbb](https://github.com/BTCDecoded/blvm-node/commit/18fce9ff2bbbad503130b63fde8f7f65082f3939))
- blvm-node: fix(node): import a 0.14 coin as its unspent outputs ([27ed11da630a](https://github.com/BTCDecoded/blvm-node/commit/27ed11da630a685946dfc141be096b7ddf8b1648))
- blvm-node: fix(node): top up the roster when a pin does not restrict download ([441e00a2325e](https://github.com/BTCDecoded/blvm-node/commit/441e00a2325eadcc670e45313b84c83de80e30ad))
- blvm-node: fix(node): do not let detected LAN peers exclude WAN peers ([630d38459829](https://github.com/BTCDecoded/blvm-node/commit/630d384598292de2cc3544f21bfc2d7ebf2dc053))
- blvm-node: fix(node): build the output cache on the connect worker ([3578416e3bca](https://github.com/BTCDecoded/blvm-node/commit/3578416e3bca61d19d59409cb1ed3e6301eb1a8f))
- blvm-node: fix(node): read smaps once per memory report ([29d0350f706d](https://github.com/BTCDecoded/blvm-node/commit/29d0350f706dc845a9ed4e53f55f247238d0991f))
- blvm-node: fix(node): index the undo log once per block ([d44da012eb7d](https://github.com/BTCDecoded/blvm-node/commit/d44da012eb7d9ef9d1045f4d71311f8a282d79d8))
- blvm-node: fix(node): forget a GetData hash when the request is cancelled ([0813a988f0dc](https://github.com/BTCDecoded/blvm-node/commit/0813a988f0dc166169284cad4113d86f7136485c))
- blvm-node: fix(node): drop skipped block hashes behind the cursor ([8eccf3fd45c1](https://github.com/BTCDecoded/blvm-node/commit/8eccf3fd45c132f94dcb01fd743641f4275dba46))
- blvm-node: fix(node): keep one ancestor list for a header batch ([84977b6c65ec](https://github.com/BTCDecoded/blvm-node/commit/84977b6c65ecfd75544e4bb24517d65f10f78203))
- blvm-node: fix(node): give a slow peer the last tile of a short window ([63134b5cd4e1](https://github.com/BTCDecoded/blvm-node/commit/63134b5cd4e1d9fe3394ecb999f078fd1d80f0fb))
- blvm-node: fix(node): estimate a block before the bridge lock ([68393b0fbdb8](https://github.com/BTCDecoded/blvm-node/commit/68393b0fbdb88c460a90916e4c1951bd7f5249b4))
- blvm-node: fix(node): drop local-gap misses behind the cursor ([64a22982c1f2](https://github.com/BTCDecoded/blvm-node/commit/64a22982c1f26fb7fe6bf857c49ce4d731b357b4))
- blvm-node: fix(node): move the owned block into fork choice ([d813c00a5f0a](https://github.com/BTCDecoded/blvm-node/commit/d813c00a5f0a4292a492f7ad0a993a708ec56560))
- blvm-node: fix(node): drop the custom tx index when asked ([2c87836887c1](https://github.com/BTCDecoded/blvm-node/commit/2c87836887c1553b069b29d24cf1a9216c99f447))
- blvm-node: fix(node): commit the tip update in one transaction ([7db0266a23d7](https://github.com/BTCDecoded/blvm-node/commit/7db0266a23d793a3d47b28ab3b08696cff8323ca))
- blvm-node: fix(node): drop body-dup heights behind the download window ([cf83a688a80e](https://github.com/BTCDecoded/blvm-node/commit/cf83a688a80e8be0437633eca42a824cb81ba878))
- blvm-node: fix(node): refuse startup when a commitment marker is present ([895b1fc5d9ba](https://github.com/BTCDecoded/blvm-node/commit/895b1fc5d9baac646f599da48b1a4dd0f8669013))
- blvm-node: fix(node): ask the next header peer from the last slot ([87478dac54fc](https://github.com/BTCDecoded/blvm-node/commit/87478dac54fcc3aa02cf6388b76a085a94564cc7))
- blvm-node: fix(node): reject a Core coin height that does not fit in u32 ([5ce137c9b256](https://github.com/BTCDecoded/blvm-node/commit/5ce137c9b256186a6696dc1016288f54112036df))
- blvm-node: fix(node): read a stored testnet3 name as testnet ([105178de6752](https://github.com/BTCDecoded/blvm-node/commit/105178de6752c54db92ba286fca215f9483778ae))
- blvm-node: fix(node): keep the next header peer after a short batch ([01f5e92b33f2](https://github.com/BTCDecoded/blvm-node/commit/01f5e92b33f2eae51d1c369012ec53ac97283e7b))
- blvm-node: fix(node): return the connected UTXO set without cloning it ([9fe6dcdb59f3](https://github.com/BTCDecoded/blvm-node/commit/9fe6dcdb59f3b05cf70c74a38efc2c610d47a0b4))
- blvm-node: fix(node): log the body probe startup already stored ([bc0aa1d50065](https://github.com/BTCDecoded/blvm-node/commit/bc0aa1d500651eafaca9f78dfd78796c31e7317a))
- blvm-node: fix(node): move a delivered block to its only receiver ([5e231196aa03](https://github.com/BTCDecoded/blvm-node/commit/5e231196aa03c586899265e0c8b15f661f805adf))
- blvm-node: fix(node): serialize only the duplicate-coinbase heights ([a9cae821d57b](https://github.com/BTCDecoded/blvm-node/commit/a9cae821d57b4c579c95198f9633bd26b73faf61))
- blvm-node: fix(node): probe confirmed bodies with a key check ([9aed64eb9938](https://github.com/BTCDecoded/blvm-node/commit/9aed64eb9938c1f9ed3c6baa75eacca7e568c862))
- blvm-node: fix(node): stop cloning a witness list the connect path ignores ([e82c45c5bc26](https://github.com/BTCDecoded/blvm-node/commit/e82c45c5bc26421210e484c72b9d80dc3de7a6ff))
- blvm-node: fix(node): hash the wire header without parsing the block ([462a88f1c6d3](https://github.com/BTCDecoded/blvm-node/commit/462a88f1c6d3a5345921be6f6bc5bb00de80a4ce))
- blvm-node: fix(node): keep header sync on the next peer ([ca478f20d9cf](https://github.com/BTCDecoded/blvm-node/commit/ca478f20d9cff64b82ea8a28bdab87b2976025ee))
- blvm-node: fix(node): apply BIP90 version floors when storing headers ([98c81df6f7f9](https://github.com/BTCDecoded/blvm-node/commit/98c81df6f7f9eb15bfb604969422b93017097e71))
- blvm-node: fix(dandelion): jitter per-tx stem timeout to prevent timing-based origin inference ([7c1a3b5434fb](https://github.com/BTCDecoded/blvm-node/commit/7c1a3b5434fbbe7bea544e0ceb697b8e99520777))
- blvm-node: fix(node): honor Core listen=0 and drop unread config fields ([0427d9025ac3](https://github.com/BTCDecoded/blvm-node/commit/0427d9025ac3f652d5502464765146bebabfffdf))
- blvm-node: fix(node): use the consensus BIP68 version gate in the mempool ([c2fadbbaa72e](https://github.com/BTCDecoded/blvm-node/commit/c2fadbbaa72e911eda7c9ab427096b295a79d501))
- blvm-node: fix(node): commit one storage update in one LMDB transaction ([427210deb75f](https://github.com/BTCDecoded/blvm-node/commit/427210deb75ffd470c654603ad2b1ac25e9b45c9))
- blvm-node: fix(node): confine module processes and close the reviewed trust gaps ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))
- blvm-node: fix(node): use standard raw-tx codes and the operator mempool file ([206c5a402cc4](https://github.com/BTCDecoded/blvm-node/commit/206c5a402cc49e5515256b4890f739bfed925124))
- blvm-node: fix(node): cap inbound TCP connections at three per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- blvm-node: fix(node): drop connection-rate violations after the window ([7cee709398f4](https://github.com/BTCDecoded/blvm-node/commit/7cee709398f487908fdcc0ac642903b7f18e58fc))
- blvm-node: fix(node): abort the peer read when the peer disconnects ([e7226019fff4](https://github.com/BTCDecoded/blvm-node/commit/e7226019fff46ad3c30b5d8ed9f50a54cdfeb0b9))
- blvm-node: fix(node): keep the compact-block deadline on a repeated hash ([ffd401bf49d8](https://github.com/BTCDecoded/blvm-node/commit/ffd401bf49d87344f78dd706b44fc7a64b129790))
- blvm-node: fix(node): hash each compact-block short id once ([c997e03a8b67](https://github.com/BTCDecoded/blvm-node/commit/c997e03a8b67e6fb0579e5a30e71f59b64bda98e))
- blvm-node: fix(node): ignore a stale addr update for a known peer ([0b8fe68ad884](https://github.com/BTCDecoded/blvm-node/commit/0b8fe68ad88406c182f40f9b4d5865fa57a136f1))
- blvm-node: fix(node): close the confirmed general-QA gaps in storage, peers, and timeouts ([f65919d616a3](https://github.com/BTCDecoded/blvm-node/commit/f65919d616a3b394815ac0a642ef448b9cb5ff78))
- blvm-node: fix(node): give version-2 compact-block matching the stored witnesses ([fd590f901965](https://github.com/BTCDecoded/blvm-node/commit/fd590f901965c2fb28aa34aa0eb2a71bb1d7a177))
- blvm-node: fix(node): publish disconnects after a disk reorg ([3b75c6d19050](https://github.com/BTCDecoded/blvm-node/commit/3b75c6d19050bf9fac939898555332217891ea90))
- blvm-node: fix(node): refuse a package when the UTXO lock is busy ([7b923c3b9c87](https://github.com/BTCDecoded/blvm-node/commit/7b923c3b9c871f1edd61b47401f2dc72ff3e18b0))
- blvm-node: fix(node): persist mempool witnesses and close shutdown and RBF gaps ([4df7d363a713](https://github.com/BTCDecoded/blvm-node/commit/4df7d363a713c0ee9d6affefc5519cbeed38ff65))
- blvm-node: fix(node): stop treating damaged chain data as mainnet ([ae74fd784890](https://github.com/BTCDecoded/blvm-node/commit/ae74fd784890f06742cefc4b85f0d2aa16650c98))
- blvm-node: fix(node): import the RocksDB cache helpers into the feature module ([dfb3517e4ed8](https://github.com/BTCDecoded/blvm-node/commit/dfb3517e4ed8af92f89713dfd951664e3932cce4))
- blvm-node: fix(node): price the bare funded spend in testmempoolaccept ([9d9392678ff2](https://github.com/BTCDecoded/blvm-node/commit/9d9392678ff2899ce1ba5ecea27a0480a2132f8d))
- blvm-node: fix(node): admit the second mempool fixture ([3aada044f765](https://github.com/BTCDecoded/blvm-node/commit/3aada044f765a9f98e6b0cfdf26a58cdbb480902))
- blvm-node: fix(node): admit the policy the tests are actually checking ([23ff2493bd75](https://github.com/BTCDecoded/blvm-node/commit/23ff2493bd75da42eb28bea3bd6d688471f6dbc4))
- blvm-node: fix(node): close mempool and template splits with Core ([f7804dcdc253](https://github.com/BTCDecoded/blvm-node/commit/f7804dcdc2535b58e447b98d3c4bb6a77b5b2606))
- blvm-node: fix(node): keep bulk IBD peers busy and duplicate a covered front ([a74bde453f26](https://github.com/BTCDecoded/blvm-node/commit/a74bde453f262b08103f72f17dd0b20b30f29fad))
- blvm-protocol: fix(protocol): match compact-block short ids from one mempool pass ([aeb88a8639a2](https://github.com/BTCDecoded/blvm-protocol/commit/aeb88a8639a2aaff256d32f8a3e5a478f6ff42bd))
- blvm-protocol: fix(protocol): keep CSV and CLTV inactive at genesis ([1f649024eb7f](https://github.com/BTCDecoded/blvm-protocol/commit/1f649024eb7f3a59ab19938da8473453a5b7dbd8))
- blvm-protocol: fix(protocol): match activation heights and reject malformed wire ([ccc361b1a343](https://github.com/BTCDecoded/blvm-protocol/commit/ccc361b1a343d1cb5e809754ac17e7756a98c341))
- blvm-protocol: fix(protocol): inline format arguments clippy rejects ([1a01b770112a](https://github.com/BTCDecoded/blvm-protocol/commit/1a01b770112a23bf6fe9aef4e289317b052ea3cc))
- blvm-protocol: fix(protocol): pin anyhow and lru to the patched releases ([45cade400d22](https://github.com/BTCDecoded/blvm-protocol/commit/45cade400d222e432adb163657eb002801bf2237))
- blvm-protocol: fix(protocol): match BIP152 version 2 short ids on the wtxid and keep the witness ([7dc13f692574](https://github.com/BTCDecoded/blvm-protocol/commit/7dc13f6925741c8fce1bfcfb9d0ef8a9f8fc30fc))
- blvm-protocol: fix(protocol): reject malformed wire and keep a tx witness ([0e361b6d0e14](https://github.com/BTCDecoded/blvm-protocol/commit/0e361b6d0e14614d9ea7e2fc95885dc507070bba))
- blvm-spec-lock: Fix main red: inventory baseline row + rustfmt for 1276d65 (#5) ([1c6b8f44268f](https://github.com/BTCDecoded/blvm-spec-lock/commit/1c6b8f44268faab81e988617fd62e03b262f6c94))
- blvm-spec-lock: fix(lock): do not verify an unmatched name as another function ([1276d6576da4](https://github.com/BTCDecoded/blvm-spec-lock/commit/1276d6576da4a3d378a4b2f5219acb93ec284f3c))
- blvm-spec-lock: fix(lock): reject a signed BIP68 version compare ([73f6b455067b](https://github.com/BTCDecoded/blvm-spec-lock/commit/73f6b455067bd624e39585e6a8ea33f80d6f7ff8))
- blvm-spec-lock: fix(lock): stop a directory symlink from cycling the spec walk ([faa21c46b11d](https://github.com/BTCDecoded/blvm-spec-lock/commit/faa21c46b11dcf14e550c58244c20255516dc547))
- blvm-spec-lock: fix(drift): report a parse gap as unparseable, not missing from the paper (#4) ([245862d0fe12](https://github.com/BTCDecoded/blvm-spec-lock/commit/245862d0fe12db529d84d507e2711924af94eb66))
- blvm-spec-lock: fix(lock): prove each open body by an edit that Z3 rejects ([c88f0eb2b14d](https://github.com/BTCDecoded/blvm-spec-lock/commit/c88f0eb2b14d1caff06b4b156d57600b79bbb022))
- blvm-spec-lock: fix(lock): truncate unparseable contracts on a char boundary ([cef4f16d0b2f](https://github.com/BTCDecoded/blvm-spec-lock/commit/cef4f16d0b2f87a8cdd026fc1372a09cb653f6cb))
- blvm-spec-lock: fix(lock): skip inventory rows that read H when the spec is absent ([7ec798fcae81](https://github.com/BTCDecoded/blvm-spec-lock/commit/7ec798fcae814b6d15dee9baa3f3f543d496b8a0))
- blvm-spec-lock: fix(lock): skip theorem 6.1.2 checks when the spec checkout is absent ([7007ad667213](https://github.com/BTCDecoded/blvm-spec-lock/commit/7007ad667213547d77fdb3ca3d14c289467ca669))
- blvm-spec-lock: fix(lock): compile the merged sentence tests on CI ([ce1953ac91d6](https://github.com/BTCDecoded/blvm-spec-lock/commit/ce1953ac91d6ba866f7340ce371f8bcc94996d17))
- blvm-spec-lock: fix(lock): skip sibling locks when this repo is checked out alone ([14c3d61c0c5d](https://github.com/BTCDecoded/blvm-spec-lock/commit/14c3d61c0c5d29de321659950ee90591679979f5))
- blvm-spec-lock: fix(lock): prove witness bounds from the spec and match the coverage report ([adfc94d9b635](https://github.com/BTCDecoded/blvm-spec-lock/commit/adfc94d9b6359fbcaf50e2caaddbda2e6bb006d8))
- blvm-spec-lock: fix(lock): check a cited Lean link with the elaborator ([bf5b4727aa28](https://github.com/BTCDecoded/blvm-spec-lock/commit/bf5b4727aa28075758c7a06058222d9c3e79e6d9))
- blvm-spec-lock: fix(lock): follow the shared consensus bodies ([23dc83f5e268](https://github.com/BTCDecoded/blvm-spec-lock/commit/23dc83f5e268287721c7348ef02b1724f7e4bece))
- blvm-primitives: fix(primitives): keep copy and batch SHA256 inside their stated bounds ([b211ceb9ec3f](https://github.com/BTCDecoded/blvm-primitives/commit/b211ceb9ec3f0b5ed4f5511af0b0e7a0c98f0808))
- blvm-primitives: fix(primitives): stop loading block-validation env the node never reads ([9710c791aec9](https://github.com/BTCDecoded/blvm-primitives/commit/9710c791aec9a62f744e35275e5c31e15da80a81))
- blvm-primitives: fix(primitives): start regtest BIP34, BIP66, BIP65, and CSV at height 1 ([185a87d8c2f5](https://github.com/BTCDecoded/blvm-primitives/commit/185a87d8c2f54e2da6ef744851698683a6c0d896))
- blvm-primitives: fix(primitives): name the FindAndDelete script error ([7b7080fd90ed](https://github.com/BTCDecoded/blvm-primitives/commit/7b7080fd90edf8082936c6cb5022c30b3adb20fd))

## Internal

- blvm: ci: keep self-hosted runners for Rust compile and test ([3a3ea871eb5e](https://github.com/BTCDecoded/blvm/commit/3a3ea871eb5eb2fdaf25ab8b0f9de21ecb3b4bd4))
- blvm: chore(blvm): record the reviewed minimal direct dependencies ([df0322894b66](https://github.com/BTCDecoded/blvm/commit/df0322894b666bb8f0449e386e3ff90477544b29))
- blvm: test(blvm): reject unknown networks and a missing versions file ([f860fee912d4](https://github.com/BTCDecoded/blvm/commit/f860fee912d4fff6c47db93b00484cfecbac140e))
- blvm: docs(blvm): keep repository boundary notes under the reporting policy ([00d4864631b1](https://github.com/BTCDecoded/blvm/commit/00d4864631b13a5f2bc367356daf088753f19719))
- blvm: docs(blvm): add the reporting policy and the 0.2.0-beta.1 dry run ([cc88b56078e4](https://github.com/BTCDecoded/blvm/commit/cc88b56078e4b82ada2e8a4d2f3ded0b7b0412aa))
- blvm: ci(blvm): check commits, advisories, and the release dry run ([5a382e133b52](https://github.com/BTCDecoded/blvm/commit/5a382e133b52c86ad6cbceebf2339ca4277bcf4e))
- blvm: build(blvm): add the minimal feature set ([af182f5f9a7a](https://github.com/BTCDecoded/blvm/commit/af182f5f9a7abe22b26f46ec11ebabe72d60237a))
- blvm: docs: mark release attestation as Designed ([d7741e325bd8](https://github.com/BTCDecoded/blvm/commit/d7741e325bd8e82a389da5249e5f05da52b363f8))
- blvm: chore(blvm): lock the crates published for this release ([c33f405042c8](https://github.com/BTCDecoded/blvm/commit/c33f405042c824e6d151b286a156c3283ff0a915))
- blvm: chore(blvm): lock the published consensus, node, protocol, and secp crates ([c911353d4287](https://github.com/BTCDecoded/blvm/commit/c911353d428731dbc7fc2319096425ea0612360a))
- blvm: docs: fail the release hash check and name the workflows that exist ([f287b3be35cf](https://github.com/BTCDecoded/blvm/commit/f287b3be35cf63dae5309c982a52c3e1c5435ca2))
- blvm: Compile CUDA kernels into the release binary without linking libcudart. ([55d54da410c6](https://github.com/BTCDecoded/blvm/commit/55d54da410c6a1cbd50bbec4253d2ff1109a2810))
- blvm: test(blvm): refuse a release whose default modules will not install ([627a92937493](https://github.com/BTCDecoded/blvm/commit/627a929374937b4ee64ab83eea1163306df74021))
- blvm: style(blvm): format the config writer the way CI rustfmt wants ([74a0eb720a7c](https://github.com/BTCDecoded/blvm/commit/74a0eb720a7cb2ec54d5ee7d6c6f34ed5dd8fb5a))
- blvm: ci(release): pin Cargo.lock to node 0.1.89, sdk 0.1.21, and protocol 0.1.44 ([cb96064eb849](https://github.com/BTCDecoded/blvm/commit/cb96064eb849dfa61739a6b042dbbb2a0e138922))
- blvm: Default the release build to heed3 only. ([3771ecceb9b0](https://github.com/BTCDecoded/blvm/commit/3771ecceb9b0de1c60263464bfac93e0612999b3))
- blvm: Drop blvm-fibre from the module registry until downloads exist. ([0449603ad993](https://github.com/BTCDecoded/blvm/commit/0449603ad993ccf7fcd18868e5aef2482a57d256))
- blvm: Drop blvm-fibre from the module registry until downloads exist. ([903b7aab9351](https://github.com/BTCDecoded/blvm/commit/903b7aab9351cfd717cc58e328d386cde7b14793))
- blvm: Lock the data directory and check stored blocks before the node serves. ([89c23a6f198e](https://github.com/BTCDecoded/blvm/commit/89c23a6f198e96e02854c04f95f22e811c2ab4ac))
- blvm: ci(release): pin Cargo.lock to consensus 0.1.76, node 0.1.87, and primitives 0.1.32 ([3d39da0adb77](https://github.com/BTCDecoded/blvm/commit/3d39da0adb77ff755ff32dd9a0f00dfc539e09b2))
- blvm: docs: point operator links at the documentation host ([bbd0c1ccf7ba](https://github.com/BTCDecoded/blvm/commit/bbd0c1ccf7ba85847fe0fa2d6fbcbbb7c4c156d9))
- blvm: ci(release): pin Cargo.lock to consensus 0.1.75, node 0.1.84, and primitives 0.1.31 ([e37dee1d09e6](https://github.com/BTCDecoded/blvm/commit/e37dee1d09e63a92703a87db5ae809cdf7f705de))
- blvm: Bring the module pins and CLI feature writes from dens-keep-wip onto main. ([a88f86c2f39d](https://github.com/BTCDecoded/blvm/commit/a88f86c2f39deb2d285d66b4f10f3bec59f979c6))
- blvm: Seed the checked mainnet assume-valid hash from the binary overlay. ([85559abd06fd](https://github.com/BTCDecoded/blvm/commit/85559abd06fd46a46185abc1de7c5d0b7ca5c1f2))
- blvm: Seed the checked mainnet assume-valid hash from the binary overlay. ([cbe91500baab](https://github.com/BTCDecoded/blvm/commit/cbe91500baabcf11caaa60bee04789892b859940))
- blvm: ci(release): pin Cargo.lock to consensus 0.1.73 ([8b9e2b82511d](https://github.com/BTCDecoded/blvm/commit/8b9e2b82511ddfc8427c524abfd9cbce672874b3))
- blvm-node: ci: keep self-hosted runners for Rust compile and test ([097caf82d512](https://github.com/BTCDecoded/blvm-node/commit/097caf82d51228bfdc559d029090a65184a3d2ef))
- blvm-node: test(node): reject a mismatched probe hash and more mempool previews ([dc75c4e7608a](https://github.com/BTCDecoded/blvm-node/commit/dc75c4e7608afe2104d3388a94fdcb9791fc7504))
- blvm-node: docs(node): add the reporting policy and a reconstructed changelog ([3e6b1eb7ccce](https://github.com/BTCDecoded/blvm-node/commit/3e6b1eb7ccce455ed4b2bd52202f0458a636cbfd))
- blvm-node: ci(node): require a freeze marker on validation paths ([54313b8a465a](https://github.com/BTCDecoded/blvm-node/commit/54313b8a465a1b22573d51ffcad23f7c5972de80))
- blvm-node: build(node): add the minimal feature set ([0cab271c5a5c](https://github.com/BTCDecoded/blvm-node/commit/0cab271c5a5cf462fc751ae1f5c244378dfb17b9))
- blvm-node: Ask the failure mode and the repository hazard on the pull request template. ([24400a7c6525](https://github.com/BTCDecoded/blvm-node/commit/24400a7c6525b93b1bf8a35d7f3e8e089d039642))
- blvm-node: Add a pull request template for the governance classification. ([61511f88935d](https://github.com/BTCDecoded/blvm-node/commit/61511f88935d4b01864234316fb6ca9c76c66baf))
- blvm-node: test(node): run the redb-off rejection test only when redb is off ([1fac4f106cbe](https://github.com/BTCDecoded/blvm-node/commit/1fac4f106cbee3fe555c30f8128a4a6665b10d47))
- blvm-node: test(node): rustfmt the moved test modules; bind the IPC test socket under /tmp ([7e1ff3700192](https://github.com/BTCDecoded/blvm-node/commit/7e1ff37001929b375830af9a849793f64b3f88f7))
- blvm-node: test(node): assert one existing reject from each public entry ([36bb40c7e9a3](https://github.com/BTCDecoded/blvm-node/commit/36bb40c7e9a3f805274fa7e1bda30d0a6c082560))
- blvm-node: refactor(node): move large test modules out of the implementation files ([a1c44b4083f4](https://github.com/BTCDecoded/blvm-node/commit/a1c44b4083f4b644b5ce91b252d01c41e19445c0))
- blvm-node: Bump version to 0.1.92 for release [skip ci] ([794cc2940a28](https://github.com/BTCDecoded/blvm-node/commit/794cc2940a28e300b0a745dbd774a5ab8fe5268e))
- blvm-node: Bump version to 0.1.91 for release [skip ci] ([9aa36d2126a8](https://github.com/BTCDecoded/blvm-node/commit/9aa36d2126a87966d7e02053a70aa2649216553d))
- blvm-node: docs: match the mempool default and the ZMQ sequence body ([e0a4f8171101](https://github.com/BTCDecoded/blvm-node/commit/e0a4f817110163ede5d089c1717aff057fcae2e0))
- blvm-node: Drop the user-facing secp-gpu feature. ([e906796b94a2](https://github.com/BTCDecoded/blvm-node/commit/e906796b94a201183284c4b98866360d54f9bdf4))
- blvm-node: Bump version to 0.1.90 for release [skip ci] ([4096a13abc85](https://github.com/BTCDecoded/blvm-node/commit/4096a13abc855063a906feb66acd7d5d21b6efcd))
- blvm-node: Bump version to 0.1.89 for release [skip ci] ([9c0a2d121657](https://github.com/BTCDecoded/blvm-node/commit/9c0a2d121657ccbcc7f1457570391647df02000c))
- blvm-node: Bump version to 0.1.88 for release [skip ci] ([b491aebbd1c9](https://github.com/BTCDecoded/blvm-node/commit/b491aebbd1c98b5fe475400748523608dc05a807))
- blvm-node: test(node): migrate the Core fixture into a directory inside it ([36fd3286bc48](https://github.com/BTCDecoded/blvm-node/commit/36fd3286bc4889aca760d4065f70b71547e774cc))
- blvm-node: test(node): a module publishes ModuleEvent, not a chain event ([43ca3be402c4](https://github.com/BTCDecoded/blvm-node/commit/43ca3be402c4104fa35889501b10589e65c771dd))
- blvm-node: test(node): wait out the dandelion jitter in the suite too ([0efeccd2e697](https://github.com/BTCDecoded/blvm-node/commit/0efeccd2e697b1d2393a210922d2debde93d7bc0))
- blvm-node: test(node): wait out the dandelion stem jitter window ([c1febb452eea](https://github.com/BTCDecoded/blvm-node/commit/c1febb452eea9872892f4b64577ee08fc7636069))
- blvm-node: test(node): store the snapshot header before loadtxoutset ([890e44a3b5ee](https://github.com/BTCDecoded/blvm-node/commit/890e44a3b5ee4304654b7ae7b6c7c4e70157c8fc))
- blvm-node: style(node): format the module, network, and fee estimator diffs CI rejects ([9865cfb05c5a](https://github.com/BTCDecoded/blvm-node/commit/9865cfb05c5ab1e94a241d8586d3482729ff3c34))
- blvm-node: style(node): fit the fork-choice entry signature ([cedc912f8788](https://github.com/BTCDecoded/blvm-node/commit/cedc912f8788d7dee5200520e419d6dca9b13c84))
- blvm-node: revert(node): leave the custom tx index ahead of F5 ([5ca8f266fd2f](https://github.com/BTCDecoded/blvm-node/commit/5ca8f266fd2f3835f1fb17b314ddae7c1efc8207))
- blvm-node: test(node): fail when the startup body log probes again ([0ebf82d7129e](https://github.com/BTCDecoded/blvm-node/commit/0ebf82d7129e421820d1373a1a4fd3bc4c17bbdb))
- blvm-node: revert(node): split the tip update ahead of F2 ([538c59ddbd18](https://github.com/BTCDecoded/blvm-node/commit/538c59ddbd18e9a25473e9db7b245fabda8f989f))
- blvm-node: test(node): fail when a matching witness list is cloned ([21469c0b7185](https://github.com/BTCDecoded/blvm-node/commit/21469c0b7185ecb77e5ec4c3e59fe99b6badb740))
- blvm-node: revert(node): restore the exact Failed commitment check ahead of F34 ([91268e74502f](https://github.com/BTCDecoded/blvm-node/commit/91268e74502faac8aa0d7ca5afc1f1834e09fd2f))
- blvm-node: revert(node): remove the bundled coin height check ahead of F33 ([7678f50d0852](https://github.com/BTCDecoded/blvm-node/commit/7678f50d085274d9b4e249451d67f1bd48d01bac))
- blvm-node: revert(node): remove the bundled testnet3 map ahead of F21 ([7108c0f94671](https://github.com/BTCDecoded/blvm-node/commit/7108c0f94671ed5866a5be5074c0e480676ed0a1))
- blvm-node: style: reflow network helpers and a header test ([cc06dad2d61f](https://github.com/BTCDecoded/blvm-node/commit/cc06dad2d61f3bae1890324db3d40cdda3c92e5b))
- blvm-node: Keep spec-lock and the extra databases off the default node. ([90f890ff74a5](https://github.com/BTCDecoded/blvm-node/commit/90f890ff74a56a862145e2cb18f1fbd76eccef53))
- blvm-node: Advertise NODE_FIBRE from the loaded module and let WASM guests read blocks. ([f7bd23731e2c](https://github.com/BTCDecoded/blvm-node/commit/f7bd23731e2cfbd16db092b6df9ae45ecf385614))
- blvm-node: Drop TidesDB and land the fenced storage boundary with the new wire paths. ([6dd5964a7761](https://github.com/BTCDecoded/blvm-node/commit/6dd5964a77618471fdc12375bda4d438c5ef833a))
- blvm-node: Bump version to 0.1.87 for release [skip ci] ([f1fb97c44366](https://github.com/BTCDecoded/blvm-node/commit/f1fb97c443662c35122e07376e83e80cfca977ce))
- blvm-node: Bump version to 0.1.86 for release [skip ci] ([b1c1b79cf38a](https://github.com/BTCDecoded/blvm-node/commit/b1c1b79cf38a456605a3df5f38f9b8a34f925d4a))
- blvm-node: docs: call this crate the BLVM node and point links at the documentation host ([e2f5d1d3eb92](https://github.com/BTCDecoded/blvm-node/commit/e2f5d1d3eb9249ed755880180e94b4dab590c5b3))
- blvm-node: docs: count the 13 functions proved from the body ([d948b3f46ffe](https://github.com/BTCDecoded/blvm-node/commit/d948b3f46ffe8dedb2c26427057a2aa5658f9bc1))
- blvm-node: Bump version to 0.1.84 for release [skip ci] ([58ea6d7a988a](https://github.com/BTCDecoded/blvm-node/commit/58ea6d7a988aa24e22579bc6c42846472faaa292))
- blvm-node: style(node): format the mempool and template fixes ([74eb0a4c199d](https://github.com/BTCDecoded/blvm-node/commit/74eb0a4c199d7ea92e40d972affe49e2f2b5fe9a))
- blvm-node: Store the checked mainnet assume-valid hash and bake production IBD defaults. ([0f9776e9b918](https://github.com/BTCDecoded/blvm-node/commit/0f9776e9b918efb25bdcd6278a1c5d51e0a6d036))
- blvm-node: style(node): wrap the covered-front assertion ([bf6d9eefb0bc](https://github.com/BTCDecoded/blvm-node/commit/bf6d9eefb0bc08a86fb0bf216b19089018295b6b))
- blvm-consensus: ci: keep self-hosted runners for Rust compile and test ([0a17b131d65d](https://github.com/BTCDecoded/blvm-consensus/commit/0a17b131d65dcb80620a87720a66f2f12b9de985))
- blvm-consensus: docs(consensus): keep the dependency pin notes under the reporting policy ([1e178978fe5a](https://github.com/BTCDecoded/blvm-consensus/commit/1e178978fe5a25ffd6017cfb00d4396c1918520c))
- blvm-consensus: docs(consensus): add the reporting policy and a reconstructed changelog ([56b0a7315593](https://github.com/BTCDecoded/blvm-consensus/commit/56b0a73155939088dfbc735d0de527496c9722ba))
- blvm-consensus: ci(consensus): require a freeze marker on consensus source ([471bbd2dedcc](https://github.com/BTCDecoded/blvm-consensus/commit/471bbd2dedcc7ebf61ee0253e0900725a7d894a3))
- blvm-consensus: docs: drop the 1,000-input cap and the strict-mode Partial failure ([35dd7186a491](https://github.com/BTCDecoded/blvm-consensus/commit/35dd7186a4916e6bdd6edd9f85f8ad97a489390f))
- blvm-consensus: style(consensus): format the p2sh sigop assertion ([c9ddb1121117](https://github.com/BTCDecoded/blvm-consensus/commit/c9ddb112111732f5a5115fcae3c5c8340d2486b8))
- blvm-consensus: ci(consensus): compile tests without the incremental cache ([9cd1aab283cb](https://github.com/BTCDecoded/blvm-consensus/commit/9cd1aab283cb0b4baeb9e471fbde3f92c7562b13))
- blvm-consensus: docs: say Z3 checks the Rust and Lean checks the spec model ([36c8bd878485](https://github.com/BTCDecoded/blvm-consensus/commit/36c8bd878485435089b86ee55ebbdaa659ffdd05))
- blvm-consensus: docs: count the 13 functions proved from the body ([265b0eadc62c](https://github.com/BTCDecoded/blvm-consensus/commit/265b0eadc62c460399a6381132f5effc8791a6f3))
- blvm-consensus: ci(consensus): verify with spec-lock 0.1.45 ([e9ea2fef942c](https://github.com/BTCDecoded/blvm-consensus/commit/e9ea2fef942c29fab8f417f1b9650b1b956b6ee6))
- blvm-consensus: style(consensus): format the pay-to-anchor and script-code paths ([706e6f50ae97](https://github.com/BTCDecoded/blvm-consensus/commit/706e6f50ae97760e08b73422831e16227e22b952))
- blvm-protocol: test(protocol): run the committed SipHash-2-4 and basic block-filter rows ([17f9af3a217f](https://github.com/BTCDecoded/blvm-protocol/commit/17f9af3a217f14674c1e59fbc7ebd7856a9e8f6b))
- blvm-protocol: ci: keep self-hosted runners for Rust compile and test ([2055d42f7451](https://github.com/BTCDecoded/blvm-protocol/commit/2055d42f745196a8d59430073ea24e2db41921f2))
- blvm-protocol: test(protocol): reject short, bad, and unknown p2p frames ([d3146f8bce40](https://github.com/BTCDecoded/blvm-protocol/commit/d3146f8bce4010ddae33747c5f02c50f423f1bc5))
- blvm-protocol: docs(protocol): keep protocol boundary notes under the reporting policy ([b9af795892c9](https://github.com/BTCDecoded/blvm-protocol/commit/b9af795892c98c5d4504c325db215a02be02ad51))
- blvm-protocol: docs(protocol): add the reporting policy and a reconstructed changelog ([166601db6616](https://github.com/BTCDecoded/blvm-protocol/commit/166601db6616791dc4e60b464f39fc43bad84d17))
- blvm-protocol: ci(protocol): require a freeze marker on consensus parameters ([33269e4257ab](https://github.com/BTCDecoded/blvm-protocol/commit/33269e4257ab24f7333553f3fb9a36be510b62f6))
- blvm-protocol: Bump version to 0.1.48 for release [skip ci] ([0bc9307a2235](https://github.com/BTCDecoded/blvm-protocol/commit/0bc9307a2235831fff52548621301b6084a9e809))
- blvm-protocol: refactor(protocol): move large test modules out of the implementation files ([f26aa3984435](https://github.com/BTCDecoded/blvm-protocol/commit/f26aa3984435c4a56ebe901904fae019ef2dadae))
- blvm-protocol: Bump version to 0.1.47 for release [skip ci] ([1bbc6fb60f6a](https://github.com/BTCDecoded/blvm-protocol/commit/1bbc6fb60f6a5f874035bbfe3ca580d8d51d7404))
- blvm-protocol: Bump version to 0.1.46 for release [skip ci] ([299ae197cfbe](https://github.com/BTCDecoded/blvm-protocol/commit/299ae197cfbea9331556c2653ba2971c29b74539))
- blvm-protocol: test: one witness stack per coinbase input ([73d4f271a32a](https://github.com/BTCDecoded/blvm-protocol/commit/73d4f271a32a418b5081dd431dde2ddb059500a3))
- blvm-protocol: Bump version to 0.1.45 for release [skip ci] ([42e182a2287b](https://github.com/BTCDecoded/blvm-protocol/commit/42e182a2287b04c808887727b7a9dceeb5e3d917))
- blvm-protocol: Bump version to 0.1.44 for release [skip ci] ([69dd3bff7474](https://github.com/BTCDecoded/blvm-protocol/commit/69dd3bff7474bab0c27f5eddbfa99a20fae8907b))
- blvm-protocol: Stop pulling spec-lock into the default protocol build. ([7feb6648cae7](https://github.com/BTCDecoded/blvm-protocol/commit/7feb6648cae7a42bee9d762db2c0e741fc407878))
- blvm-protocol: Bump version to 0.1.43 for release [skip ci] ([401d383a731c](https://github.com/BTCDecoded/blvm-protocol/commit/401d383a731c825a6718033c1b1cd34f55739d4e))
- blvm-protocol: Match compact-filter and v2 packet encodings to the published wire vectors. ([49036217175e](https://github.com/BTCDecoded/blvm-protocol/commit/49036217175eb5965808ab1726567dcb286ed6ce))
- blvm-protocol: Bump version to 0.1.42 for release [skip ci] ([756589cfbcc2](https://github.com/BTCDecoded/blvm-protocol/commit/756589cfbcc27b4673a7de6faf97f2b95759c8fc))
- blvm-protocol: Bump version to 0.1.41 for release [skip ci] ([68e9336e70f1](https://github.com/BTCDecoded/blvm-protocol/commit/68e9336e70f17ac9358068a827e97411bf6db7fe))
- blvm-protocol: ci(protocol): point spec-lock at the runner spec checkout ([b0e55504b420](https://github.com/BTCDecoded/blvm-protocol/commit/b0e55504b420cd3471a2aba3f05ad1748ded9be8))
- blvm-protocol: ci: install latest blvm-spec-lock again (drop 0.1.45 pin) ([454560e3264e](https://github.com/BTCDecoded/blvm-protocol/commit/454560e3264e02f5ba3dbd8de258e0b7b9653af3))
- blvm-protocol: Bump version to 0.1.40 for release [skip ci] ([58c1b41e5851](https://github.com/BTCDecoded/blvm-protocol/commit/58c1b41e5851a6cd2b0b3b1cc7867e22acf1b937))
- blvm-protocol: docs: call this crate a BLVM tier and point links at the documentation host ([82ef8efb14b5](https://github.com/BTCDecoded/blvm-protocol/commit/82ef8efb14b542f22718cce86f6fcaab3e1cc0e0))
- blvm-protocol: ci(protocol): verify with spec-lock 0.1.45 ([d71197e825a4](https://github.com/BTCDecoded/blvm-protocol/commit/d71197e825a4e09f1c16f25be5ea0c829f78cb0b))
- blvm-spec: ci: keep self-hosted runners for Rust compile and test ([295ef1ae6bf3](https://github.com/BTCDecoded/blvm-spec/commit/295ef1ae6bf3340418fed3ef7d4348282d69ea83))
- blvm-spec: docs(spec): state the severity scale inside the reporting policy ([b52ab2ea4c81](https://github.com/BTCDecoded/blvm-spec/commit/b52ab2ea4c81e5e04878dfc06654c48defe54b40))
- blvm-spec: ci(spec): require a freeze marker on the normative text ([fe9c1a5881b2](https://github.com/BTCDecoded/blvm-spec/commit/fe9c1a5881b271c9caf67f1ba662eedbbfe30910))
- blvm-spec: docs(spec): match block weight and witness-program extraction to the implementation ([072ff0abb046](https://github.com/BTCDecoded/blvm-spec/commit/072ff0abb0460bc624664f62bbe930eb9b3e2983))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([cb4d98a74e85](https://github.com/BTCDecoded/blvm-spec/commit/cb4d98a74e85bc19ca7b205c221f55ff3cec4792))
- blvm-spec: docs(spec): match header time, EvalScript, and CLTV to the implementation ([5ee506b89409](https://github.com/BTCDecoded/blvm-spec/commit/5ee506b8940988e02550a631d8fd85fb638f8b6f))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([a31c48cec534](https://github.com/BTCDecoded/blvm-spec/commit/a31c48cec534eabcc50f4771dbc73fbc97b8410a))
- blvm-spec: docs(spec): state the Core reject in the consensus register ([0072d1b7c3c4](https://github.com/BTCDecoded/blvm-spec/commit/0072d1b7c3c46e02d12f633098e7a434af840997))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([6b7ae49dc077](https://github.com/BTCDecoded/blvm-spec/commit/6b7ae49dc077cf174a2367b4d56eeeb31dcb8de5))
- blvm-spec: docs(spec): BIP68 and CSV use the unsigned version word ([138575dea661](https://github.com/BTCDecoded/blvm-spec/commit/138575dea66121b8beba3f3d4956f36a605a37bb))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([2b977d77fcfd](https://github.com/BTCDecoded/blvm-spec/commit/2b977d77fcfda525c718e3ab12313d2076294574))
- blvm-spec: docs(spec): match the payload cap and the standard OP_RETURN size ([631ecaae852b](https://github.com/BTCDecoded/blvm-spec/commit/631ecaae852b83851d4f93ac2a32ba226e31774b))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([affdb8e0717b](https://github.com/BTCDecoded/blvm-spec/commit/affdb8e0717bc943c8d1ff516a8c83900b6a0ae7))
- blvm-spec: docs(spec): match assume-valid, CHECKSIGADD, and Standard RBF ([d62de20d4dda](https://github.com/BTCDecoded/blvm-spec/commit/d62de20d4ddafda67d406f5c622c90a142a325c0))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([2c4e7740d378](https://github.com/BTCDecoded/blvm-spec/commit/2c4e7740d3780f72a4d5338d3901946e142f51a1))
- blvm-spec: docs(spec): match Core's regtest buried heights and the signed CSV version ([2658067ebb42](https://github.com/BTCDecoded/blvm-spec/commit/2658067ebb427017c959f8b9d2c43ba89f04d03d))
- blvm-spec: docs: count the 13 functions proved from the body ([8a7b487402d3](https://github.com/BTCDecoded/blvm-spec/commit/8a7b487402d36ce5fcf9b597489f9cbf30740cad))
- blvm-spec: chore: update SPEC_META.json [skip ci] ([356dc8777f47](https://github.com/BTCDecoded/blvm-spec/commit/356dc8777f47870319eb881669a0b2b0b39f1ccd))
- blvm-spec: docs(spec): bound the witness formulas by the section 4 constants ([0950da2c0aad](https://github.com/BTCDecoded/blvm-spec/commit/0950da2c0aadd26cb4be78ceb07eec5a13b8812c))
- blvm-spec-lock: ci: keep self-hosted runners for Rust compile and test ([2bc90f0e3147](https://github.com/BTCDecoded/blvm-spec-lock/commit/2bc90f0e3147f7f456938830bd164d3c957fc665))
- blvm-spec-lock: docs(spec-lock): state the severity scale inside the reporting policy ([a8793259d724](https://github.com/BTCDecoded/blvm-spec-lock/commit/a8793259d7240236ca040c504f66962a9193685d))
- blvm-spec-lock: docs(spec-lock): add the reporting policy and a reconstructed changelog ([8b388c44ac4c](https://github.com/BTCDecoded/blvm-spec-lock/commit/8b388c44ac4cb2aadb3ccab7d881b02e5beb52de))
- blvm-spec-lock: ci(spec-lock): require a freeze marker on the checker ([6c0f37d71745](https://github.com/BTCDecoded/blvm-spec-lock/commit/6c0f37d71745e15915309f3da4dcc785e6289447))
- blvm-spec-lock: Bump version to 0.1.54 for release [skip ci] ([bddfae4ac806](https://github.com/BTCDecoded/blvm-spec-lock/commit/bddfae4ac8063f78bf654d7a2245c810d89f98d1))
- blvm-spec-lock: Bump version to 0.1.53 for release [skip ci] ([f363a57a50dd](https://github.com/BTCDecoded/blvm-spec-lock/commit/f363a57a50dd3dd9c0b58fb1c694dc151c6b25f1))
- blvm-spec-lock: docs: stop saying --strict fails a Partial result ([d9a3cbe52c78](https://github.com/BTCDecoded/blvm-spec-lock/commit/d9a3cbe52c7837cc6e3aa834ee50e6556fcac761))
- blvm-spec-lock: Bump version to 0.1.52 for release [skip ci] ([ab797e56f79b](https://github.com/BTCDecoded/blvm-spec-lock/commit/ab797e56f79b7adf56da5791039e41f900aa8c79))
- blvm-spec-lock: style(lock): format the BIP68 predicate and the lean walk assertion ([631cf4fae047](https://github.com/BTCDecoded/blvm-spec-lock/commit/631cf4fae047751e6167c6e5c0257541f8bc982a))
- blvm-spec-lock: Bump version to 0.1.51 for release [skip ci] ([eca713cd2485](https://github.com/BTCDecoded/blvm-spec-lock/commit/eca713cd2485e4836e6352106c031bd1bc32fc3d))
- blvm-spec-lock: Bump version to 0.1.50 for release [skip ci] ([3164afb3a435](https://github.com/BTCDecoded/blvm-spec-lock/commit/3164afb3a435705893e83a5e92ecd3c99a98822f))
- blvm-spec-lock: docs: name Lean beside Z3 and stop freezing the old lock count ([ac38c8a1d215](https://github.com/BTCDecoded/blvm-spec-lock/commit/ac38c8a1d21515930887183271d131e884f8a309))
- blvm-spec-lock: Bump version to 0.1.49 for release [skip ci] ([f48fe30590f3](https://github.com/BTCDecoded/blvm-spec-lock/commit/f48fe30590f371c57059093ab57bf405a480a67d))
- blvm-spec-lock: docs: count the 13 functions proved from the body ([bbadeaa1da09](https://github.com/BTCDecoded/blvm-spec-lock/commit/bbadeaa1da091c890891918dacf2f9863349dc12))
- blvm-spec-lock: Bump version to 0.1.48 for release [skip ci] ([fd0c23e1066f](https://github.com/BTCDecoded/blvm-spec-lock/commit/fd0c23e1066f68e038249ec78c2761249e965008))
- blvm-spec-lock: Bump version to 0.1.47 for release [skip ci] ([040adcf3318d](https://github.com/BTCDecoded/blvm-spec-lock/commit/040adcf3318d806307ac5cc8d026736ab9a8fd8b))
- blvm-spec-lock: Report which Orange Paper sentences the Lean model closes. ([d0edd937b0da](https://github.com/BTCDecoded/blvm-spec-lock/commit/d0edd937b0da1de7583a39ef40de92695a830b5b))
- blvm-spec-lock: Bump version to 0.1.46 for release [skip ci] ([318b88e7e072](https://github.com/BTCDecoded/blvm-spec-lock/commit/318b88e7e07219a4d4cb5c0fc444f6eb4f89b029))
- blvm-spec-lock: ci: run the pinned Lean gates without a skip switch ([12ce76e8808a](https://github.com/BTCDecoded/blvm-spec-lock/commit/12ce76e8808a438d007696c920eb48c2e6be5d71))
- blvm-spec-lock: test(lock): fail the Lean gate on the seven bad links ([8b1e35906944](https://github.com/BTCDecoded/blvm-spec-lock/commit/8b1e35906944e7772174e076bc5ed21313f7043f))
- blvm-spec-lock: docs: pin the btc-lean commit and the axiom allowlist ([8a427beba4fa](https://github.com/BTCDecoded/blvm-spec-lock/commit/8a427beba4fa3b3a823061b7415c3ff03c344f7a))
- blvm-primitives: ci: keep self-hosted runners for Rust compile and test ([fa1cd6957cf2](https://github.com/BTCDecoded/blvm-primitives/commit/fa1cd6957cf21b534ef1a135bdc00a8fcec604e5))
- blvm-primitives: test(primitives): reject non-minimal varints and check the subsidy schedule ([f512a93266ec](https://github.com/BTCDecoded/blvm-primitives/commit/f512a93266ecb8132c0797e5d47097f331535219))
- blvm-primitives: docs(primitives): state the severity scale inside the reporting policy ([f7fe49d0bb29](https://github.com/BTCDecoded/blvm-primitives/commit/f7fe49d0bb294d115927bc7b7019f3a6b0c98683))
- blvm-primitives: docs(primitives): add the reporting policy and a reconstructed changelog ([86695d3208b6](https://github.com/BTCDecoded/blvm-primitives/commit/86695d3208b6c1ac6ad5c962eda982782acb1d11))
- blvm-primitives: test(primitives): reject truncated buffers and arithmetic overflow ([0802458403a1](https://github.com/BTCDecoded/blvm-primitives/commit/0802458403a155206560749ab279470832988fe4))
- blvm-primitives: Bump version to 0.1.34 for release [skip ci] ([ede6efb409bd](https://github.com/BTCDecoded/blvm-primitives/commit/ede6efb409bdfc93cef9eb9a47a2be5e9094bc59))
- blvm-primitives: Bump version to 0.1.33 for release [skip ci] ([426e811ee549](https://github.com/BTCDecoded/blvm-primitives/commit/426e811ee549a59ab703fd373c423eb26cb32c7f))
- blvm-primitives: Bump version to 0.1.32 for release [skip ci] ([67adace586e9](https://github.com/BTCDecoded/blvm-primitives/commit/67adace586e92e9a04b1c8adf66eb0c8091fe850))
- blvm-primitives: Bump version to 0.1.31 for release [skip ci] ([1ce7b0a0d782](https://github.com/BTCDecoded/blvm-primitives/commit/1ce7b0a0d78201da57b0c0058198dad41619043f))
