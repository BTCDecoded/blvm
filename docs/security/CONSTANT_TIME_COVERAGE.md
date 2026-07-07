# Constant-time coverage audit

Audit of constant-time (side-channel) discipline across Bitcoin Commons, with emphasis on `blvm-secp256k1`. Paths are relative to the multi-repo workspace checkout unless noted.

**Related upstream contract:** `blvm-secp256k1/TIMING.md`, `blvm-secp256k1/README.md` (Side-channel section).

---

## Summary

| Layer | CT status | Notes |
|-------|-----------|-------|
| **`blvm-secp256k1` secret paths** | Implemented by design | Documented API matrix in `TIMING.md` |
| **Statistical timing tests** | Manual / operator-driven | Dudect-style harness exists; **not CI-gated** |
| **CI (algebraic)** | Yes | Branchless correctness tests run on every `cargo test` |
| **`blvm-consensus` validation** | Verify-only (var-time OK) | No private-key operations in production code |
| **Governance / HD / ban-list signing** | Delegates to secp256k1 CT stack | BIP32 HMAC/scalar add not dudect-tested |
| **ctgrind / valgrind timing** | Not present | — |

---

## 1. `blvm-secp256k1` — secret-path constant-time implementation

**Authoritative contract:** `blvm-secp256k1/TIMING.md` and `blvm-secp256k1/README.md`.

**Pattern library:** `subtle` (`Choice`, `ConditionallySelectable`, `ConstantTimeEq`) in `scalar.rs`, `field/layout_5x52.rs`, `ecmult_const.rs`, `ecmult_gen_comb.rs`.

### Scalar multiplication (secret scalar × G)

| Function | File | Mechanism |
|----------|------|-----------|
| `ecmult_gen_const` | `blvm-secp256k1/src/ecmult_gen_comb.rs` | libsecp-style multi-comb; cmov table scan, `add_ge`, `double_ct`; no secret-dependent branches |
| `ecmult_const` | `blvm-secp256k1/src/ecmult_const.rs` | GLV + cmov table reads (`ecmult_const_table_get_ge`); `subtle::Choice` for point negation |

Module comments at `ecmult_gen_comb.rs:1–14` and `ecmult_const.rs:1–2` document CT intent.

### Nonce generation (RFC 6979)

| Function | File | Notes |
|----------|------|-------|
| `nonce32_rfc6979_libsecp` | `blvm-secp256k1/src/rfc6979.rs:93` | HMAC-SHA256 per RFC 6979; matches libsecp layout (`seckey32 \|\| msg_reduced32`) |
| `Rfc6979HmacSha256` | `blvm-secp256k1/src/rfc6979.rs:36` | Stateful HMAC generator |

RFC 6979 HMAC itself is not labeled constant-time in source. The **full signing path** including RFC 6979 and the retry loop is covered by dudect-style tests (see §2).

### Signing paths

| API | File | CT primitives used |
|-----|------|-------------------|
| `ecdsa_sig_sign` | `blvm-secp256k1/src/ecdsa.rs:853` | `ecmult_gen_const` (nonce k·G), `Scalar::inv` (s⁻¹), `cond_negate` (low-S) |
| `ecdsa_sig_sign_recoverable` | `blvm-secp256k1/src/ecdsa.rs:808` | Same as above |
| `ecdsa_sign_der_rfc6979` | `blvm-secp256k1/src/ecdsa.rs:931` | RFC 6979 nonce loop → `ecdsa_sig_sign` |
| `ecdsa_sign_compact_rfc6979` | `blvm-secp256k1/src/ecdsa.rs:899` | Same |
| `schnorr_sign` | `blvm-secp256k1/src/schnorr.rs:484` | `ecmult_gen_const` for d·G and k·G; branchless R.y parity via `cond_negate` + `FieldElement::cmov` |
| `Keypair::from_seckey` / `schnorr_sign_with_keypair` | `blvm-secp256k1/src/schnorr.rs:527`, `:557` | One CT d·G cached; per-sign one CT k·G |
| `nonce_gen` / `partial_sign` | `blvm-secp256k1/src/musig.rs:404`, `:493` | `ecmult_gen_const` for secret nonces |
| `ecdh` / `ecdh_compressed` | `blvm-secp256k1/src/ecdh.rs:27` | `ecmult_const` for seckey × pubkey |
| `ellswift_xdh` | `blvm-secp256k1/src/ellswift.rs` | `ecmult_const` (x86_64/aarch64 timing tests) |
| `xonly_pubkey_tweak_add` | `blvm-secp256k1/src/taproot.rs` | `ecmult_gen_const` for t·G (CT w.r.t. tweak scalar) |

### Public key from secret

| Function | File | Mechanism |
|----------|------|-----------|
| `pubkey_from_secret` | `blvm-secp256k1/src/ecdsa.rs:749` | `ecmult_gen_const` |
| `xonly_pubkey_from_secret` | `blvm-secp256k1/src/schnorr.rs` | `ecmult_gen_const` |

### Scalar arithmetic touching secrets

| Function | File | Mechanism |
|----------|------|-----------|
| `Scalar::div2` / `half_modn` | `blvm-secp256k1/src/scalar.rs:196` | Branchless parity handling |
| `Scalar::cond_negate` | `blvm-secp256k1/src/scalar.rs:448` | Mask-based; no branch on secret flag |
| `Scalar::inv` | `blvm-secp256k1/src/scalar.rs:406` | **safegcd (`modinv64`)** on x86_64/aarch64; **Fermat fallback on other arches (NOT timing-safe)** |
| `FieldElement::cmov` | `blvm-secp256k1/src/field/layout_5x52.rs` | `subtle::ConditionallySelectable` |
| `impl ConstantTimeEq for Scalar` | `blvm-secp256k1/src/scalar.rs:476` | Used in tests and comparisons |

### Explicitly variable-time (public data only)

Documented in `blvm-secp256k1/TIMING.md`:

- `ecdsa_sig_verify`, `verify_ecdsa_direct` — `ecdsa.rs`
- `schnorr_verify`, `schnorr_verify_batch` — `schnorr.rs`
- `ecmult`, `ecmult_gen` (fast path) — `ecmult.rs`
- `ecdsa_sig_recover` — `ecdsa.rs:759` (uses `inv_var`, `ecmult`, `add_var`)

---

## 2. Automated constant-time verification

### What exists

| Artifact | Path | CI? | What it covers |
|----------|------|-----|----------------|
| **Dudect-style timing tests** | `blvm-secp256k1/tests/ct_timing.rs` | **No** (all `#[ignore]`) | Welch t-test on CPU cycle counts; 100k samples per class |
| **Correctness tests for branchless paths** | Same file, non-ignored | **Yes** (`blvm-secp256k1/.github/workflows/ci.yml` → `cargo test --all-features`) | `ct_div2_correctness_*`, `ct_cond_negate_correctness`, `ct_negate_correctness_*`, `ct_schnorr_r_parity_correctness` |
| **Smoke tests** | `blvm-secp256k1/tests/ct_smoke.rs` | **Yes** | Functional consistency of secret paths; explicitly **not** a timing substitute |
| **Documentation** | `blvm-secp256k1/TIMING.md` | — | API matrix, verification methodology, limitations |

### Dudect-style tests (manual)

From `blvm-secp256k1/tests/ct_timing.rs` and `TIMING.md`:

```bash
cd blvm-secp256k1
taskset -c 0 cargo test --release --test ct_timing -- \
  --test-threads=1 --include-ignored --nocapture
```

**Ignored timing test functions** (`#[ignore = "needs isolated CPU; …"]`):

- `ct_timing_div2_even_vs_odd`
- `ct_timing_cond_negate_flag0_vs_flag1`
- `ct_timing_ecmult_gen_const_two_random_pools`
- `ct_timing_schnorr_sign_r_parity`
- `ct_timing_ecdh_two_random_pools`
- `ct_timing_scalar_inv_two_random_pools`
- `ct_timing_pubkey_from_secret_two_random_pools`
- `ct_timing_xonly_pubkey_from_secret_two_pools`
- `ct_timing_ecdsa_sig_sign_two_pools`
- `ct_timing_ecdsa_sig_sign_recoverable_two_pools`
- `ct_timing_musig_nonce_gen_two_pools`
- `ct_timing_musig_partial_sign_two_pools`
- `ct_timing_xonly_pubkey_tweak_add_two_pools`
- `ct_timing_ecdsa_sign_der_rfc6979_two_pools`
- `ct_timing_ecdh_compressed_two_pools`
- `ct_timing_musig_keyagg_xonly_tweak_two_pools`
- `ct_timing_musig_keyagg_ec_tweak_two_pools`
- `ct_timing_taproot_output_key_two_pools`
- (x86_64/aarch64 only) `ct_timing_ellswift_create_two_pools`, `ct_timing_ellswift_xdh_two_pools`

### What does not exist

- No **ctgrind** / FlowTracker integration
- No **valgrind**-based timing tests
- No **google/dudect** binary — custom Welch harness at `ct_timing.rs:241` (`fn dudect`)
- No CI job running `--include-ignored` timing tests

**Conclusion:** CT is **implemented by design** and **algebraically tested in CI**; **statistical timing verification is documented and manual**, not automated in CI.

---

## 3. Secret material elsewhere in the codebase

### `blvm-sdk` — governance keys (not consensus, not wallet funds)

| Area | File | Secret handling | CT discipline |
|------|------|-----------------|---------------|
| Key generation | `blvm-sdk/src/governance/keys.rs:27` `GovernanceKeypair::generate` | `OsRng` → `pubkey_from_secret` | CT via `ecmult_gen_const` |
| From secret | `keys.rs:45` `from_secret_key` | Same | Same |
| Signing | `blvm-sdk/src/governance/signatures.rs:54` `sign_message` | `ecdsa_sign_compact_rfc6979` | Full CT signing stack |
| Verification | `signatures.rs:62` `verify_signature` | Public only | Variable-time verify (appropriate) |

`blvm-sdk/README.md`: **NOT handling wallet keys or user funds**.

### BIP32 HD derivation

| Function | File | Secret touchpoints | CT notes |
|----------|------|-------------------|----------|
| `derive_master_key` | `blvm-sdk/src/governance/bip32.rs:101` | HMAC-SHA512("Bitcoin seed", seed) → `pubkey_from_secret` | Scalar mul CT; HMAC not documented as CT |
| `derive_child_private` | `bip32.rs:138` | HMAC + `scalar_add` + `pubkey_from_secret` / `ecmult_gen_const` in `point_add_scalar_g` | Uses `ecmult_gen_const` for IL·G; scalar add is plain mod-n add (not documented CT) |
| `derive_child_public` | `bip32.rs:193` | Public path only | No secret scalars |

No dudect tests for BIP32 derivation paths.

### BIP39 mnemonics

| Function | File | Notes |
|----------|------|-------|
| `mnemonic_to_seed` | `blvm-sdk/src/governance/bip39.rs:430` | PBKDF2-HMAC-SHA512, 2048 iterations — intentionally slow; not a CT concern |
| `mnemonic_to_entropy` / `validate_mnemonic` | `bip39.rs:358`, `:442` | Public word parsing + checksum |

### `blvm-node` — signing orchestration (non-consensus)

| Function | File | Path |
|----------|------|------|
| `sign_ban_list` | `blvm-node/src/network/ban_list_signing.rs:26` | `ecdsa_sign_compact_rfc6979` → CT signing |
| `SignedBanListMessage::new` | `ban_list_signing.rs:71` | `pubkey_from_secret` + sign |
| Module manifest verify | `blvm-node/src/module/security/signing.rs` | **Verify only** (`ecdsa_sig_verify`) |

### `blvm-datum` — protocol keys

| Function | File | Notes |
|----------|------|-------|
| `derive_key_from_shared_secret_static` | `blvm-datum/src/datum_protocol.rs:723` | HKDF-style derivation; no CT documentation |

### Not found

- No BIP44 wallet implementation on the consensus/node validation path
- No user-fund signing in `blvm-consensus` or `blvm-node` block/script validation

---

## 4. Consensus / validation path — public data only

### `blvm-consensus` — verify-only crypto

Backend dispatch: `blvm-consensus/src/secp256k1_backend/mod.rs` (default feature: `blvm-secp256k1`).

**blvm-secp256k1 backend** (`blvm-consensus/src/secp256k1_backend/blvm_impl.rs`):

- `verify_ecdsa` → `ecdsa_sig_verify`
- `verify_schnorr` → `schnorr_verify`
- `verify_schnorr_batch` → `schnorr_verify_batch`
- `taproot_output_key` / `taproot_output_key_with_parity` → public internal key + merkle root tweak

**Script verification entry:** `blvm-consensus/src/script/signature.rs:65` `verify_signature` — parses DER + sighash, calls verify backend. **No signing.**

**Taproot/Schnorr in script:** `blvm-consensus/src/script/mod.rs` → `verify_tapscript_schnorr_signature` (verify only).

Grep of `blvm-consensus/src/**` found **no** `ecdsa_sig_sign`, `schnorr_sign`, `ecdh`, `secret_key`, or `private_key` in production consensus code.

### UTXO / block validation

- UTXO set operations: hash maps over public outpoints/outputs — no secret scalars
- `connect_block`, script execution, sighash computation: all operate on **public block/tx data**

### Misleading “constant-time” elsewhere

- `blvm-consensus/tests/consensus_property_tests.rs:523` `prop_block_subsidy_constant_time` — checks **O(1) wall-clock** for subsidy by height, **not** cryptographic side-channel resistance
- Orange Paper `blvm-spec/PROTOCOL.md:2446` “each operation takes constant time” — **algorithmic O(1)** bound on script steps, not crypto CT

### Consensus-adjacent paths that touch secrets (outside validation)

| Path | Secret? | On hot validation path? |
|------|---------|-------------------------|
| Governance signing (`blvm-sdk`) | Yes | No |
| Ban list signing (`blvm-node`) | Yes | No (network admin) |
| BIP324 P2P transport (`blvm-protocol/v2_transport.rs`) | Session keys | No (not consensus) |
| Test fixtures using `secp256k1::SecretKey` | Yes | Tests only |

Nothing unexpected on the mainnet consensus validation path.

---

## Citable summary (external response)

> **Secret-path crypto is concentrated in `blvm-secp256k1`.** Signing (`ecdsa_sig_sign*`, `ecdsa_sign_*_rfc6979`, `schnorr_sign`), pubkey-from-secret, ECDH, MuSig secret paths, and Taproot tweak-by-secret-scalar use constant-time primitives (`ecmult_gen_const`, `ecmult_const`, branchless `Scalar` ops, safegcd `Scalar::inv` on x86_64/aarch64). Verification and batch verify intentionally use variable-time math on public inputs (`TIMING.md`).
>
> **Automated CT verification:** CI runs algebraic correctness tests for branchless scalar paths (`blvm-secp256k1/tests/ct_timing.rs`, `tests/ct_smoke.rs`). Dudect-style statistical timing tests exist in the same file but are `#[ignore]` and require manual isolated-CPU runs — they are **not** in CI. No ctgrind/valgrind timing harness found.
>
> **Higher layers:** Governance signing (`blvm-sdk/src/governance/signatures.rs` → `ecdsa_sign_compact_rfc6979`), HD derivation (`bip32.rs` → `ecmult_gen_const` for point steps), and ban-list signing (`blvm-node/.../ban_list_signing.rs`) delegate to the CT signing stack. BIP39 PBKDF2 is intentionally slow, not CT-modeled. No wallet/user-fund signing on the consensus path.
>
> **Consensus:** `blvm-consensus` verifies signatures only (`script/signature.rs`, `secp256k1_backend/blvm_impl.rs`); no private-key operations in production consensus code. Constant-time is **not required** there and is **not implemented** for verify paths (by design).

---

## Known gaps (acknowledge honestly)

1. **No CI timing gate** — only manual dudect-style runs
2. **`Scalar::inv` Fermat fallback** on non-x86_64/aarch64 — not secret-safe (`scalar.rs:405`, `TIMING.md:81`)
3. **Compiler-mediated CT** — `subtle` + LLVM; docs recommend asm inspection and dudect on target triple
4. **BIP32 HMAC / `scalar_add`** — not covered by dudect tests or CT documentation
5. **RFC 6979 retry loop** — branches on invalid nonce; full path is timing-tested but retry count could theoretically leak (mitigated by dudect test on `ecdsa_sign_der_rfc6979`)
