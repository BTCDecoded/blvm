# BLVM release notes

Each section is generated from the previous git tag, `Cargo.lock` at that tag, and the advisory JSON. Unreleased is rewritten from commits after the latest tag. A published section is left as it was.

## [Unreleased]

Previous tag: v0.3.0-beta.2
DIFFERENTIAL_RECORD_ID: pending

### Linked crates

Versions read from `Cargo.lock` at this revision.

- `blvm-node` 0.1.101
- `blvm-consensus` 0.1.84
- `blvm-protocol` 0.1.55
- `blvm-sdk` 0.1.26
- `blvm-primitives` 0.1.38
- `blvm-secp256k1` 0.1.19

### Checksums

- No checksum file at this revision.

### Consensus

- None in this range.

### Breaking changes

- None in this range.

### Security

Ids copied from the advisory JSON at this revision.

#### Closed

- BLVM-2026-0001 (consensus, closed, blvm-consensus, fixed version 0.1.80, crate release 0.1.80): An overflowing output sum was an internal error instead of an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- BLVM-2026-0002 (consensus, closed, blvm-node, fixed version 0.1.92, crate release 0.1.92): A failed reorg left the coin set rewound ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- BLVM-2026-0003 (resource exhaustion, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Inbound TCP connections were not capped per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- BLVM-2026-0004 (local-only, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Module processes were not confined ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))

#### Open

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
- BLVM-2026-0118 (remote crash, open, blvm-node, fixed version unset, crate release unset): A compact-filter length that overflows the cursor aborts the parser ([9096b8414777](https://github.com/BTCDecoded/blvm-node/commit/9096b8414777f8718de1264ba9ac81dcd00d1dfc))
- BLVM-2026-0119 (local-only, open, blvm-node, fixed version unset, crate release unset): The module spawn log printed MODULE_CONFIG values ([140bbeb9f984](https://github.com/BTCDecoded/blvm-node/commit/140bbeb9f98479b5bed1feb83824b98a56c79d57))
- BLVM-2026-0120 (local-only, open, blvm-node, fixed version unset, crate release unset): A module manifest key was accepted as the publisher ([277cf3b8c663](https://github.com/BTCDecoded/blvm-node/commit/277cf3b8c6638df974e9566e1adf49588199b1ba))
- BLVM-2026-0121 (local-only, open, blvm-node, fixed version unset, crate release unset): A module handshake accepted an id the node did not mint ([d0649ea0bba2](https://github.com/BTCDecoded/blvm-node/commit/d0649ea0bba23e59b42c0c51568a6e00960f69b5))
- BLVM-2026-0122 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): The working-tree lock no longer matches BLVM-2026-0101 through BLVM-2026-0117

### Features

- None in this range.

### Fixes

- None in this range.

### Internal

- None in this range.

## [0.3.0-beta.2] - 2026-11-19

Previous tag: v0.3.0-beta.1
DIFFERENTIAL_RECORD_ID: pending

### Linked crates

Versions read from `Cargo.lock` at this revision.

- `blvm-node` 0.1.101
- `blvm-consensus` 0.1.84
- `blvm-protocol` 0.1.55
- `blvm-sdk` 0.1.26
- `blvm-primitives` 0.1.38
- `blvm-secp256k1` 0.1.19

### Checksums

```
50701d3ecbb5d68a59805f45cd2074587dff4bb2f8f9091d638e8f1b56ceffc2  blvm-0.3.0-beta.2-linux-x86_64
b481beec669556b0e388afd345fc6ee9fc4e3b22bf5cd5fb2fe0b89b294d0d2e  blvm-0.3.0-beta.2-linux-aarch64
5d7233067a746fe0c73340a7106e2823cf078af5720edfae1cac1f4ca11d17d4  blvm-0.3.0-beta.2-windows-x86_64.exe
53ef31b178efe40939bd1d3aaacbf129c4d1612da8a28869a77fa6d39adf85be  blvm-minimal-0.3.0-beta.2-linux-x86_64
```

### Consensus

- None in this range.

### Breaking changes

- None in this range.

### Security

Ids copied from the advisory JSON at this revision.

#### Closed

- BLVM-2026-0001 (consensus, closed, blvm-consensus, fixed version 0.1.80, crate release 0.1.80): An overflowing output sum was an internal error instead of an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- BLVM-2026-0002 (consensus, closed, blvm-node, fixed version 0.1.92, crate release 0.1.92): A failed reorg left the coin set rewound ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- BLVM-2026-0003 (resource exhaustion, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Inbound TCP connections were not capped per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- BLVM-2026-0004 (local-only, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Module processes were not confined ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))

#### Open

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
- BLVM-2026-0118 (remote crash, open, blvm-node, fixed version unset, crate release unset): A compact-filter length that overflows the cursor aborts the parser ([9096b8414777](https://github.com/BTCDecoded/blvm-node/commit/9096b8414777f8718de1264ba9ac81dcd00d1dfc))
- BLVM-2026-0119 (local-only, open, blvm-node, fixed version unset, crate release unset): The module spawn log printed MODULE_CONFIG values ([140bbeb9f984](https://github.com/BTCDecoded/blvm-node/commit/140bbeb9f98479b5bed1feb83824b98a56c79d57))
- BLVM-2026-0120 (local-only, open, blvm-node, fixed version unset, crate release unset): A module manifest key was accepted as the publisher ([277cf3b8c663](https://github.com/BTCDecoded/blvm-node/commit/277cf3b8c6638df974e9566e1adf49588199b1ba))
- BLVM-2026-0121 (local-only, open, blvm-node, fixed version unset, crate release unset): A module handshake accepted an id the node did not mint ([d0649ea0bba2](https://github.com/BTCDecoded/blvm-node/commit/d0649ea0bba23e59b42c0c51568a6e00960f69b5))
- BLVM-2026-0122 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): The working-tree lock no longer matches BLVM-2026-0101 through BLVM-2026-0117

### Features

- None in this range.

### Fixes

- None in this range.

### Internal

- docs: record the 0.3.0-beta.1 release notes ([4e3fe5746c8d](https://github.com/BTCDecoded/blvm/commit/4e3fe5746c8d2e20eb305e95f42566f54428e963))
- chore: lock blvm-node 0.1.101 ([003e217f326c](https://github.com/BTCDecoded/blvm/commit/003e217f326cea6e81e36717a784d341cb10ac05))
- docs: manifest and checksums for 0.3.0-beta.2 ([aafe5b594670](https://github.com/BTCDecoded/blvm/commit/aafe5b594670bb3f26f84447f5fd39ec2cd28f77))

## [0.3.0-beta.1] - 2026-11-18

Previous tag: v0.2.0-beta.2
DIFFERENTIAL_RECORD_ID: pending

### Linked crates

Versions read from `Cargo.lock` at this revision.

- `blvm-node` 0.1.100
- `blvm-consensus` 0.1.84
- `blvm-protocol` 0.1.55
- `blvm-sdk` 0.1.26
- `blvm-primitives` 0.1.38
- `blvm-secp256k1` 0.1.19

### Checksums

```
b0036e89fb3438cd58d9ff85a26a264426ead46b780c6f5e6b931d48e6754f3d  blvm-minimal
```

### Consensus

- None in this range.

### Breaking changes

- None in this range.

### Security

Ids copied from the advisory JSON at this revision.

#### Closed

- BLVM-2026-0001 (consensus, closed, blvm-consensus, fixed version 0.1.80, crate release 0.1.80): An overflowing output sum was an internal error instead of an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- BLVM-2026-0002 (consensus, closed, blvm-node, fixed version 0.1.92, crate release 0.1.92): A failed reorg left the coin set rewound ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- BLVM-2026-0003 (resource exhaustion, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Inbound TCP connections were not capped per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- BLVM-2026-0004 (local-only, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Module processes were not confined ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))

#### Open

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
- BLVM-2026-0118 (remote crash, open, blvm-node, fixed version unset, crate release unset): A compact-filter length that overflows the cursor aborts the parser ([9096b8414777](https://github.com/BTCDecoded/blvm-node/commit/9096b8414777f8718de1264ba9ac81dcd00d1dfc))
- BLVM-2026-0119 (local-only, open, blvm-node, fixed version unset, crate release unset): The module spawn log printed MODULE_CONFIG values ([140bbeb9f984](https://github.com/BTCDecoded/blvm-node/commit/140bbeb9f98479b5bed1feb83824b98a56c79d57))
- BLVM-2026-0120 (local-only, open, blvm-node, fixed version unset, crate release unset): A module manifest key was accepted as the publisher ([277cf3b8c663](https://github.com/BTCDecoded/blvm-node/commit/277cf3b8c6638df974e9566e1adf49588199b1ba))
- BLVM-2026-0121 (local-only, open, blvm-node, fixed version unset, crate release unset): A module handshake accepted an id the node did not mint ([d0649ea0bba2](https://github.com/BTCDecoded/blvm-node/commit/d0649ea0bba23e59b42c0c51568a6e00960f69b5))
- BLVM-2026-0122 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): The working-tree lock no longer matches BLVM-2026-0101 through BLVM-2026-0117

### Features

- None in this range.

### Fixes

- fix(blvm): ship a disabled systemd unit with the packages ([9b3aa4fe322f](https://github.com/BTCDecoded/blvm/commit/9b3aa4fe322fff70a21e7c2f71ada13d1744fd3b))
- fix(blvm): document the single prune window and accept transport aliases ([9be7c4086cbd](https://github.com/BTCDecoded/blvm/commit/9be7c4086cbdee5d94db401fe72a4239941875ee))
- fix(blvm): notify from the release lock and pack the unit everywhere ([d817cf12c527](https://github.com/BTCDecoded/blvm/commit/d817cf12c52744b9eea8e493fb22bcfdd1618cda))

### Internal

- docs: record the 0.2.0-beta.2 release notes ([af7898b40fd6](https://github.com/BTCDecoded/blvm/commit/af7898b40fd6d3f4ce20751c88d82f8da497df2b))
- docs(registry): describe blvm-governance as an optional webhook ([6f8a8abd1187](https://github.com/BTCDecoded/blvm/commit/6f8a8abd11876951034836599079a543d76d87ba))
- docs(blvm): describe the disabled unit and the image data directory ([2e60767877b8](https://github.com/BTCDecoded/blvm/commit/2e60767877b8c07ec47b6d579bb5603415799a2f))
- style(blvm): drop the blank lines rustfmt rejects ([564219603485](https://github.com/BTCDecoded/blvm/commit/564219603485e971633fed89f86a59e2fa3ccdfc))
- docs(blvm): say the arm64 deb is the binary only ([2879b667a551](https://github.com/BTCDecoded/blvm/commit/2879b667a551a1de9b096306f3b0208e126b56da))
- chore(blvm): lock blvm-node 0.1.100 ([bf06ac407f88](https://github.com/BTCDecoded/blvm/commit/bf06ac407f88d90c2359e6aaafb298c238ca0d8f))
- docs: record the 0.3.0-beta.1 manifest and minimal checksum ([65f5d39bdd56](https://github.com/BTCDecoded/blvm/commit/65f5d39bdd5692aaa2ffa7d250347dea3cd3eeec))

## [0.2.0-beta.2] - 2026-11-17

Previous tag: v0.2.0-beta.1
DIFFERENTIAL_RECORD_ID: pending

### Linked crates

Versions read from `Cargo.lock` at this revision.

- `blvm-node` 0.1.98
- `blvm-consensus` 0.1.84
- `blvm-protocol` 0.1.55
- `blvm-sdk` 0.1.26
- `blvm-primitives` 0.1.38
- `blvm-secp256k1` 0.1.19

### Checksums

```
b7e406e5518763923d1619c581bd8f3ee769a828636786666126f352f81cb6cf  blvm-minimal
```

### Consensus

- None in this range.

### Breaking changes

- None in this range.

### Security

Ids copied from the advisory JSON at this revision.

#### Closed

- BLVM-2026-0001 (consensus, closed, blvm-consensus, fixed version 0.1.80, crate release 0.1.80): An overflowing output sum was an internal error instead of an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- BLVM-2026-0002 (consensus, closed, blvm-node, fixed version 0.1.92, crate release 0.1.92): A failed reorg left the coin set rewound ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- BLVM-2026-0003 (resource exhaustion, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Inbound TCP connections were not capped per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- BLVM-2026-0004 (local-only, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Module processes were not confined ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))

#### Open

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
- BLVM-2026-0118 (remote crash, open, blvm-node, fixed version unset, crate release unset): A compact-filter length that overflows the cursor aborts the parser ([9096b8414777](https://github.com/BTCDecoded/blvm-node/commit/9096b8414777f8718de1264ba9ac81dcd00d1dfc))
- BLVM-2026-0119 (local-only, open, blvm-node, fixed version unset, crate release unset): The module spawn log printed MODULE_CONFIG values ([140bbeb9f984](https://github.com/BTCDecoded/blvm-node/commit/140bbeb9f98479b5bed1feb83824b98a56c79d57))
- BLVM-2026-0120 (local-only, open, blvm-node, fixed version unset, crate release unset): A module manifest key was accepted as the publisher ([277cf3b8c663](https://github.com/BTCDecoded/blvm-node/commit/277cf3b8c6638df974e9566e1adf49588199b1ba))
- BLVM-2026-0121 (local-only, open, blvm-node, fixed version unset, crate release unset): A module handshake accepted an id the node did not mint ([d0649ea0bba2](https://github.com/BTCDecoded/blvm-node/commit/d0649ea0bba23e59b42c0c51568a6e00960f69b5))
- BLVM-2026-0122 (informational, open, blvm, blvm-node, fixed version unset, crate release unset): The working-tree lock no longer matches BLVM-2026-0101 through BLVM-2026-0117

### Features

- None in this range.

### Fixes

- fix(blvm): pin quinn-proto 0.11.19 on main ([9b93aad6b612](https://github.com/BTCDecoded/blvm/commit/9b93aad6b61268df771ef9390bcf6a2efbd81b39))
- fix(blvm): clear the main clippy, config, and libz-sys failures ([2e4b35e4a92d](https://github.com/BTCDecoded/blvm/commit/2e4b35e4a92dc53e17244b2424c84514adac8e8e))

### Internal

- docs: name the supported beta line ([296d0a8b003f](https://github.com/BTCDecoded/blvm/commit/296d0a8b003f266406f6d2c7a8d39dc82c1a782f))
- docs: accumulate release notes from the previous tag ([0961e6133227](https://github.com/BTCDecoded/blvm/commit/0961e6133227232805417be44e2bc19fa010b326))
- ci: check published release notes and refuse a crate tag ([c9bb0d9cc210](https://github.com/BTCDecoded/blvm/commit/c9bb0d9cc210ff2e15bbd4408536e1b95c21cb09))
- chore(blvm): lock the published crate stack [skip_release] [skip_docker] ([01058e519f34](https://github.com/BTCDecoded/blvm/commit/01058e519f342ef53d0e605a68a8e291dd8d95e9))
- docs: sign the 0.2.0-beta.2 minimal binary ([929bef3a72bb](https://github.com/BTCDecoded/blvm/commit/929bef3a72bba3c83329ec0ec562dab595f6664c))

## [0.2.0-beta.1] - 2026-11-15

Previous tag: v0.1.81
DIFFERENTIAL_RECORD_ID: pending

### Linked crates

Versions read from `Cargo.lock` at this revision.

- `blvm-node` 0.1.96
- `blvm-consensus` 0.1.83
- `blvm-protocol` 0.1.54
- `blvm-sdk` 0.1.25
- `blvm-primitives` 0.1.37
- `blvm-secp256k1` 0.1.19

### Checksums

```
ad08cc94670ea42013612f1133d4a0e42c894930281a082a7243a70fa5e06fa1  blvm-minimal
```

### Consensus

- None in this range.

### Breaking changes

- None in this range.

### Security

Ids copied from the advisory JSON at this revision.

#### Closed

- BLVM-2026-0001 (consensus, closed, blvm-consensus, fixed version 0.1.80, crate release 0.1.80): An overflowing output sum was an internal error instead of an invalid block ([e58e0ad2003a](https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1))
- BLVM-2026-0002 (consensus, closed, blvm-node, fixed version 0.1.92, crate release 0.1.92): A failed reorg left the coin set rewound ([76f2b437ceed](https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8))
- BLVM-2026-0003 (resource exhaustion, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Inbound TCP connections were not capped per address ([ca0b77e3e9f0](https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd))
- BLVM-2026-0004 (local-only, closed, blvm-node, fixed version 0.1.88, crate release 0.1.88): Module processes were not confined ([6230a225e259](https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808))

#### Open

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
- BLVM-2026-0118 (remote crash, open, blvm-node, fixed version unset, crate release unset): A compact-filter length that overflows the cursor aborts the parser ([9096b8414777](https://github.com/BTCDecoded/blvm-node/commit/9096b8414777f8718de1264ba9ac81dcd00d1dfc))
- BLVM-2026-0119 (local-only, open, blvm-node, fixed version unset, crate release unset): The module spawn log printed MODULE_CONFIG values ([140bbeb9f984](https://github.com/BTCDecoded/blvm-node/commit/140bbeb9f98479b5bed1feb83824b98a56c79d57))
- BLVM-2026-0120 (local-only, open, blvm-node, fixed version unset, crate release unset): A module manifest key was accepted as the publisher ([277cf3b8c663](https://github.com/BTCDecoded/blvm-node/commit/277cf3b8c6638df974e9566e1adf49588199b1ba))
- BLVM-2026-0121 (local-only, open, blvm-node, fixed version unset, crate release unset): A module handshake accepted an id the node did not mint ([d0649ea0bba2](https://github.com/BTCDecoded/blvm-node/commit/d0649ea0bba23e59b42c0c51568a6e00960f69b5))

### Features

- feat(blvm): keep assume-valid off the minimal profile ([a690958711eb](https://github.com/BTCDecoded/blvm/commit/a690958711eb07c9b48a627dabb13684bb57ea2a))
- feat(blvm): ship blvm-minimal in the release ([4755275919d3](https://github.com/BTCDecoded/blvm/commit/4755275919d30256836b09d9e5c96437237d1327))

### Fixes

- fix(blvm): do not report artifact parity before the RPC comparison ([d97e18f6295b](https://github.com/BTCDecoded/blvm/commit/d97e18f6295b0f27721904cc4295c0bb6a12f3f0))
- fix(blvm): compare getblockcount across the three release artifacts ([98d2ed5d8f3c](https://github.com/BTCDecoded/blvm/commit/98d2ed5d8f3c9aa320b36361bd763b5e7a5b853c))
- fix(blvm): copy advisory ids into the beta release notes ([790dd7dc6d2d](https://github.com/BTCDecoded/blvm/commit/790dd7dc6d2d2301b27d03315795c6e3153ae2a8))
- fix(blvm): keep the release checks with the published release ([f4c35587bf2f](https://github.com/BTCDecoded/blvm/commit/f4c35587bf2f2f0a7d5f023345cf1cba078a0a7d))
- fix(blvm): start from the local profile and list the catalog ([d5f19145b2df](https://github.com/BTCDecoded/blvm/commit/d5f19145b2df4379e06eaad5436c46b6c8c766b3))
- fix(blvm): lock the node that publishes minimal ([5a4498bae220](https://github.com/BTCDecoded/blvm/commit/5a4498bae2209d2de32c99d274c5c07e1340d3ad))

### Internal

- build(blvm): add the minimal feature set ([cc95e06fa89a](https://github.com/BTCDecoded/blvm/commit/cc95e06fa89a8cb5095c96b2272278202beb2b8e))
- ci(blvm): check commits, advisories, and the release dry run ([bee45213d6a7](https://github.com/BTCDecoded/blvm/commit/bee45213d6a77ce46e8c870358657f73a02cd19b))
- chore(blvm): bring the release scripts up to the beta tools ([37d5ea39c661](https://github.com/BTCDecoded/blvm/commit/37d5ea39c661c8ff3f4385c602cf86fa6311d34b))
- docs(blvm): add the reporting policy and the 0.2.0-beta.1 dry run ([9b323797a3e1](https://github.com/BTCDecoded/blvm/commit/9b323797a3e14a5c482b34db8618d80aed30d923))
- docs(blvm): record the minimal-build audit surface ([2818a21d71b0](https://github.com/BTCDecoded/blvm/commit/2818a21d71b051d7bfc377cba1b8b0a02297d3bd))
- docs(blvm): list the compact-filter crash in the dry-run notes ([5119d920715e](https://github.com/BTCDecoded/blvm/commit/5119d920715e63cfd90ef3d9a89eee7f96fb4a89))
- docs(blvm): list the module-boundary advisories in the dry-run notes ([d273e06d3aff](https://github.com/BTCDecoded/blvm/commit/d273e06d3aff8dd5dfa830179a0789348eaa389b))
- ci(blvm): pack one minimal archive per platform ([5f5b400d308f](https://github.com/BTCDecoded/blvm/commit/5f5b400d308f1768fa7d832b06030aa4f3739e31))
- ci(blvm): build the minimal archives only for the final release ([3664c3877599](https://github.com/BTCDecoded/blvm/commit/3664c38775990548282d3b36cc4fa225db02994f))
- chore: drop the retired script-history module from the registry ([dd014d62ee8b](https://github.com/BTCDecoded/blvm/commit/dd014d62ee8bc71f8331f5d5f973136fec8e5921))
- ci(blvm): accept cargo-deny 0.20 advisory fields ([c3ece33a179d](https://github.com/BTCDecoded/blvm/commit/c3ece33a179d6f6fa102e2e272647d0a91c62338))
- docs: publish the signed advisory record ([e065d801988b](https://github.com/BTCDecoded/blvm/commit/e065d801988b17420603c7970bf2bdb594622631))
- docs: sign the 0.2.0-beta.1 checksums ([274beb3919ad](https://github.com/BTCDecoded/blvm/commit/274beb3919addab5d0b79215ccc1ec578bc98036))
- docs: keep the beta checksum file with its signature ([14bf908e0892](https://github.com/BTCDecoded/blvm/commit/14bf908e08921aeafd256510e9f63235062bc814))
