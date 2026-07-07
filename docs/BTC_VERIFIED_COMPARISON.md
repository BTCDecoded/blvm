# BLVM vs btc-verified: Approach Comparison

**Status:** Internal reference (July 2026)  
**btc-verified source:** [ProofOfKeags/btc-verified](https://github.com/ProofOfKeags/btc-verified) — local checkout at `../../btc-verified` (sibling of `blvm/` in the `btc-commons` workspace)

This document compares Bitcoin Commons / BLVM with **btc-verified**, an independent Lean 4 formal-verification effort by Keagan McClelland ([@ProofOfKeags](https://github.com/ProofOfKeags)). The projects share a goal — making Bitcoin protocol correctness checkable — but pursue it with different scopes, tools, and deliverables.

---

## Executive summary

| Dimension | BLVM (Bitcoin Commons) | btc-verified |
|-----------|------------------------|--------------|
| **Primary artifact** | Runnable full node + layered Rust crates | Machine-checked Lean 4 proof leaves |
| **Normative spec** | Orange Paper (human-readable math, RFC-style) | Lean types + theorems (executable spec) |
| **Verification engine** | Z3 (spec-lock) + tests + differential replay | Lean 4 kernel + Mathlib |
| **Scope today** | End-to-end node (consensus → P2P → RPC → modules) | Serialization, commitments, merkle, chain structure |
| **Relationship to Core** | Empirical parity via differential testing | Algorithmic transcription (e.g. `ComputeMerkleRoot`) |
| **Maturity** | Multi-crate ecosystem, releases, operator docs | Early public artifact; small, growing proof leaves |

**Bottom line:** BLVM optimizes for a **spec-first, production-capable, multi-implementation ecosystem**. btc-verified optimizes for **machine-checked foundations** where testing alone is the wrong tool. They are complementary, not substitutes: btc-verified's codec and merkle proofs could inform Orange Paper precision; BLVM's differential testing could validate Lean models against mainnet history at scale.

---

## 1. Project goals

### BLVM

Bitcoin Commons exists to break implementation monoculture through:

1. An **implementation-agnostic formal spec** (Orange Paper) any language can target
2. A **layered Rust reference implementation** (`blvm-consensus` → `blvm-protocol` → `blvm-node` → `blvm`)
3. **Partial forkability** — replace one layer (e.g. SDK) while consuming stable lower layers from crates.io
4. **Operator-ready artifacts** — binaries, Docker, RPC, IBD, module system

Correctness is a property of the **specification**, not of any single repository layout. The Rust code is the first implementation, not a privileged reference.

### btc-verified

btc-verified exists to build **checked, reviewable cores** around correctness-critical protocol surfaces where:

> testing alone is the wrong tool

The thesis (see [Formal Vibefication](https://proofofkeags.com/research/2026-05-12-formal-vibefication.html)) is that AI-assisted development makes formal verification a defensible default for protocol engineering, not a luxury.

Current work is intentionally **small proof leaves**: each module builds cleanly, states its checked claims, and makes the next proof packet easier to state. It is explicitly **not yet** a full node, full Script semantics, or a complete BitVM fraud-proof model.

---

## 2. Architectural shape

### BLVM: layered production stack

```
Orange Paper (blvm-spec)
        ↓
blvm-primitives → blvm-consensus → blvm-protocol → blvm-node → blvm (binary)
        ↑                              ↑
   blvm-spec-lock (Z3)          modules (ZMQ, governance, …)
```

- **Volatility gradient:** consensus most stable; SDK/node most volatile; dependencies point inward only
- **Multi-repo:** ~29 repos; `[patch.crates-io]` for local dev; CI strips patches to verify published dependency graph
- **Modules:** process-isolated extensions; cannot alter consensus rules or UTXO acceptance

See [Repository Architecture ADR](./REPOSITORY_ARCHITECTURE_ADR.md) for the monorepo vs multi-repo decision.

### btc-verified: bottom-up proof stack

```
BtcVerified.Serialize (Codec discipline)
        ↓
CompactSize, CountedList, Script (wire types)
        ↓
Transaction model + TxCodec (legacy/SegWit)
        ↓
Block model + BlockCodec
        ↓
Sha256 (computable) → txid/wtxid → BlockHeader.hash
        ↓
Merkle (tree spec) ↔ Impl.BitcoinCore (Core algorithm)
        ↓
Chain (linear header linkage) — fork choice / PoW later
```

- **Single repo**, Lean 4 + Mathlib, Nix dev shell
- **Codec discipline:** round-trip + canonicality as composable laws; most codecs derived via `Codec.ofEquiv`
- **Spec/impl split:** platonic merkle tree spec under `Crypto/`; Core's bottom-up vector fold under `Impl/BitcoinCore/`
- **One type per module** convention; axiom audit fails CI on `sorry`

---

## 3. Verification methodology

### BLVM: three reinforcing layers

| Layer | Mechanism | What it proves |
|-------|-----------|----------------|
| **Empirical** | Unit, property (proptest), integration, fuzz (libFuzzer) | Behavior on concrete and generated inputs |
| **Symbolic** | `blvm-spec-lock` — Z3 on `#[spec_locked]` functions | Spec-derived contracts on annotated consensus functions (~168 functions, ~433 obligations) |
| **Empirical (external)** | Differential testing vs Bitcoin Core / libbitcoinconsensus / libbitcoinkernel | Global agreement on mainnet history |

**Orange Paper** is the human-auditable normative document. Spec-lock links Rust functions to numbered sections; it does **not** prove the whole node binary atomically. Gaps are documented in [PROOF_LIMITATIONS.md](https://github.com/BTCDecoded/blvm-consensus/blob/main/docs/PROOF_LIMITATIONS.md).

**Collision resistance:** treated as a cryptographic assumption in binding theorems; not asserted over concrete SHA-256 in either project.

**What BLVM does not claim:**

- Proof-to-code extraction (Rust is hand-written, checked against spec)
- Constant-time guarantees in consensus paths (public validation is intentionally variable-time; secrets live in `blvm-secp256k1`)
- CI-gated full-chain differential to chain tip (operator-driven, resource-intensive)

### btc-verified: machine-checked theorems

| Mechanism | What it proves |
|-----------|----------------|
| **Lean kernel** | Theorems checked by reduction; no `sorry` on master |
| **Golden vectors** | Real mainnet bytes decode/re-encode byte-for-byte (genesis, block 170, first payment, SegWit activation block 481824) |
| **Axiom audit** | Headline theorems depend only on `propext`, `Classical.choice`, `Quot.sound` |
| **Computational defs** | `sha256`/`sha256d` reduce; merkle roots and txids evaluable on fixtures |

**Collision disjunct pattern:** binding theorems take the form "equal hashes imply equal structures **or** a concrete collision witness." Intractability of finding witnesses is the consumer's hypothesis — the only sound way to use collision resistance over a concrete hash.

**What btc-verified does not claim (yet):**

- Full Script execution semantics
- Bit-for-bit proof that SHA-256 equals FIPS 180-4 (tested against vectors, not verified against the standard)
- Proof of work, cumulative work, block tree / fork choice
- Runnable node or network stack

---

## 4. Coverage comparison (today)

| Surface | BLVM | btc-verified |
|---------|------|--------------|
| **CompactSize / varint** | Implemented + tested in `blvm-primitives` / `blvm-protocol` | **Proved** (`decode_encode`, `decode_canonical`, `encode_length_le`) |
| **Transaction serialization** | Implemented + property tests + differential replay | **Proved** round-trip + canonicality; legacy/SegWit dispatch |
| **Block serialization** | Implemented + mainnet block tests | **Proved** + golden vectors incl. 989 KB SegWit activation block |
| **SHA-256 / double-SHA** | Implemented + KAT tests + fuzz | **Computed** `def`s + KATs; not FIPS-verified |
| **txid / wtxid binding** | Implemented + tested | **Proved** with collision disjunct |
| **Merkle root binding** | Implemented + CVE-2012-2459 handling in consensus | **Proved** tree spec + Core `ComputeMerkleRoot` transcription |
| **Chain linkage** | Full chainstate + reorg in `blvm-node` | **Proved** linear `Chain` type; block tree later |
| **Script execution** | Full interpreter in `blvm-consensus` + spec-lock on key functions | Wire `Script` type only; tokenization deferred |
| **Block validity (full)** | `connect_block`, BIP rules, soft-fork flags | Merkle commitment leaf only (`Block.merkleCommits`) |
| **Proof of work** | Full difficulty / nBits validation | Not yet |
| **Mempool / policy** | `blvm-protocol::Mempool` + node policies | Not in scope |
| **P2P / RPC / storage** | Full `blvm-node` | Not in scope |
| **BitVM** | Not in BLVM core | Abstract bit-commitment model started |

btc-verified is **deeper and more formal** on the byte-layer foundation BLVM currently treats as tested infrastructure. BLVM is **broader and operational** on everything above that foundation.

---

## 5. Specification philosophy

### BLVM: spec as coordination mechanism

The Orange Paper is:

- **Implementation-agnostic** — readable without Rust, Lean, or C++
- **RFC/IETF MUST/MUST NOT style** — numbered consensus rules
- **Authoritative for inter-implementation agreement** — future C, Go, or other implementations are first-class

Repository layout is **not** load-bearing for correctness; the spec is. This is the architectural claim that justifies separate repos per layer (see ADR §4.6).

### btc-verified: spec as executable mathematics

The Lean development **is** the specification for the surfaces it covers:

- Types encode wire facts (e.g. `Tx.legacy` carries non-empty-inputs proof because `0x00` is the SegWit marker)
- Theorems are the claims; doc-strings render them in English
- Reviewers read checked claims in module headers, not a separate prose document

There is no separate Orange Paper equivalent in btc-verified today. The README's "Current proof leaves" sections serve as the public contract per module.

---

## 6. Relationship to Bitcoin Core

### BLVM

**Differential testing** treats Core as an independent reference implementation:

- Regtest integration: BLVM vs Core RPC (`testmempoolaccept`, `submitblock`)
- Historical replay: mainnet block ranges
- Full-chain program: every non-coinbase script (Phase 1) + `connect_block` vs `libbitcoinkernel` (Phase 2)

Consensus mismatches are bugs. Mempool-policy mismatches may be intentional.

This is **empirical equivalence**, not a proof that BLVM's Rust equals Core's C++.

### btc-verified

**Algorithmic transcription** for merkle:

- `BtcVerified.Impl.BitcoinCore` transcribes `ComputeMerkleRoot` from `src/consensus/merkle.cpp`
- Proves `computeRoot_eq_root` (vector fold = tree spec root)
- Proves Core's `mutated` scan implies canonicality (one-way; Core is strictly stronger)
- Fixture checks on block 481824 confirm `mutated = false` on real SegWit activation data

This is **proved refinement** between a formal model and a specific Core algorithm, not global historical replay.

---

## 7. Engineering and ecosystem

| Topic | BLVM | btc-verified |
|-------|------|--------------|
| **Language** | Rust (edition 2024) | Lean 4 |
| **Build** | `cargo build`; feature flags for storage/network | `lake build`; Nix shell; Mathlib cache |
| **CI** | Multi-repo workflows, spec-lock tiers, security gates | Axiom audit + golden vectors + `lake lint` |
| **Releases** | Stable + nightly channels; `.deb`, Docker, etc. | No releases yet |
| **Operator surface** | `blvm` CLI, RPC, config TOML, IBD tuning | Library + test harness only |
| **Extensibility** | Process-isolated modules, WASM option | New proof leaves; BitVM track started |
| **Governance** | Cryptographic merge tiers, multisig release policy | Independent single-maintainer project |
| **License** | MIT (crates) | Apache-2.0 (Lean/Mathlib ecosystem) |

---

## 8. Strengths and trade-offs

### BLVM strengths

- **Shippable full node** with documented operator path
- **Ecosystem design** — partial forks, independent crypto crates, module marketplace
- **Multi-layer correctness story** — spec + Z3 + differential + fuzz
- **Orange Paper** enables non-Rust implementations without reading BLVM code

### BLVM trade-offs

- Spec-lock proves **per-function contracts**, not end-to-end byte-layer canonicality the way Lean does
- Differential testing is **expensive** and not fully CI-gated to chain tip
- Multi-repo onboarding friction (mitigated by docs and patch workflow)
- Serialization correctness relies on tests + integration, not compositional codec proofs

### btc-verified strengths

- **Composable proof discipline** — codec laws propagate to blocks without re-proving each field
- **Explicit collision vocabulary** — binding theorems state the disjunct honestly
- **Core algorithm refinement** — merkle.cpp linked to formal tree spec
- **Reviewable proof leaves** — small modules, checked claims in headers, no `sorry` on master
- **Type-level wire encoding** — SegWit/legacy distinction structural, not conditional

### btc-verified trade-offs

- **Narrow scope today** — no Script execution, PoW, fork choice, or node
- **Lean expertise barrier** — steeper than "clone and cargo build"
- **No operator artifact** — verification library, not a network participant
- **SHA-256** tested, not formally verified against FIPS
- **Single-repo** — no partial-fork / volatility-gradient ecosystem model (not a goal for this project)

---

## 9. Complementarity and possible convergence

The projects attack different parts of the same problem:

```
                    Correctness confidence
                           ▲
                           │
     btc-verified          │    ●  (byte layer: codecs, merkle, commitments)
     (formal depth)        │
                           │
                           │              ●  BLVM differential (mainnet history)
                           │
                           │                        ●  BLVM full node (operational)
                           │
                           └──────────────────────────────────────────► Scope / deliverables
```

**Where they reinforce each other:**

1. **Serialization & commitments** — btc-verified's codec and merkle proofs could be cross-checked against `blvm-primitives` / `blvm-protocol` serialization (differential or property tests on shared golden vectors).
2. **Orange Paper precision** — Lean's structural choices (e.g. `CountedList`, SegWit bundling) may expose ambiguities the Orange Paper should state explicitly.
3. **Merkle / CVE-2012-2459** — btc-verified's separated canonicality model and Core transcription document the defense formally; BLVM implements it in production consensus.
4. **Script boundary** — both projects agree: wire layer keeps scripts raw; tokenization belongs to execution. btc-verified has not reached execution; BLVM has with spec-lock on key interpreter functions.

**Where they diverge by design:**

- BLVM will not replace Rust consensus with Lean-extracted code
- btc-verified will not build a full node as its primary artifact
- BLVM's governance and module ecosystem are out of scope for btc-verified

---

## 10. When to use which framing

| Question | Prefer BLVM framing | Prefer btc-verified framing |
|----------|---------------------|----------------------------|
| "Is this mainnet block valid under consensus?" | Run `blvm` + differential replay | Not yet — only merkle/header-byte fixtures |
| "Does this encoder admit non-canonical parses?" | Tests + code review | Lean `decode_canonical` theorem |
| "Does our merkle match Core's algorithm?" | Differential + code inspection | `computeMerkleRoot_fst` proof |
| "Can I run a signet node this week?" | BLVM releases | N/A |
| "Is equal txid binding sound modulo CR?" | Informal + tests | `Tx.txid_binding` with explicit disjunct |
| "What spec should a Go implementation follow?" | Orange Paper | Lean modules (for covered surfaces only) |

---

## 11. Local reference checkout

btc-verified is cloned as a **sibling repository** in the `btc-commons` workspace (alongside `blvm-consensus`, `blvm-node`, etc.):

```
btc-commons/
├── blvm/                 ← this repo (comparison doc lives here)
├── blvm-consensus/
├── blvm-node/
├── btc-verified/         ← Lean 4 verification project
└── …
```

**Build (requires Nix + Lean toolchain):**

```bash
cd ../btc-verified
nix develop
lake exe cache get
lake build
lake test    # fetches block 481824 on first run
```

**Key entry points:**

| Path | Content |
|------|---------|
| `btc-verified/README.md` | Proof leaf catalog |
| `btc-verified/CLAUDE.md` | Architecture and codec discipline |
| `btc-verified/BtcVerified/Serialize/Codec.lean` | Core `Codec` typeclass |
| `btc-verified/BtcVerified/Impl/BitcoinCore/Merkle.lean` | Core merkle transcription |
| `btc-verified/Tests/GoldenVectors.lean` | Mainnet byte fixtures |

---

## 12. Further reading

**BLVM**

- [Design philosophy](https://docs.thebitcoincommons.org/architecture/design-philosophy.html)
- [Formal verification](https://docs.thebitcoincommons.org/consensus/formal-verification.html)
- [Repository Architecture ADR](./REPOSITORY_ARCHITECTURE_ADR.md)
- [Differential testing](https://docs.thebitcoincommons.org/development/differential-testing.html)
- [Orange Paper](https://docs.thebitcoincommons.org/reference/orange-paper.html)

**btc-verified**

- [Repository](https://github.com/ProofOfKeags/btc-verified)
- [Formal Vibefication](https://proofofkeags.com/research/2026-05-12-formal-vibefication.html) — thesis behind the project

---

*This comparison reflects project state as of July 2026. btc-verified is actively growing; BLVM coverage numbers (spec-lock obligations, differential status) should be reconfirmed against live CI and `SPEC_LOCK_COVERAGE.md` before release decisions.*

**Follow-up:** actionable workstreams to adopt btc-verified methodology → [btc-verified lessons plan](./BTC_VERIFIED_LESSONS_PLAN.md).
