# Mainnet IBD UX plan (release users)

**Status:** draft  
**Depends on:** shipped onboarding (`MAINNET_IBD_ONBOARDING_PLAN.md`)  

## Principles

- **Product UX lives in `blvm` / `blvm-node`**, not script wrappers.
- **`start-ibd-mainnet.sh`** stays optional; at most minor edits (resume note).
- **No new scripts.**

---

## P0 — CI / runner (blocks all other work)

### P0.1 — `ld.lld` / libLLVM mismatch on self-hosted runner

**Problem:** Global `RUSTFLAGS=-C link-arg=-fuse-ld=lld` in `blvm-node` CI. Runner has `lld 19.x` linked against `libLLVM.so.19.1` while `llvm-libs` is 21.x → every build fails at link (including proc-macro build scripts).

**Root cause:** Arch partial upgrade — `lld` package out of sync with `llvm-libs`.

**Fix (in repo):**
| Change | File |
|--------|------|
| Remove hardcoded global `RUSTFLAGS` lld | `.github/workflows/ci.yml` |
| Setup job: detect mold → lld (if `ld.lld --version` works) → default bfd | same |
| Export `rustflags` output; set `RUSTFLAGS` on compile jobs only | same |

**Fix (runner ops, optional):** `sudo pacman -S --needed lld llvm-libs` so lld matches installed LLVM.

**Acceptance:** CI build-dev + test jobs link successfully without manual runner repair.

**Status:** implemented in working tree (pending push).

---

### P0.2 — `cargo fmt --check` failure

**Problem:** `src/node/sync.rs` — multi-line `info!(…)` for fresh-chain earliest mode fails rustfmt.

**Fix:** `cargo fmt --all` on `blvm-node`.

**Acceptance:** fmt job green.

**Status:** implemented in working tree (pending push).

---

## Priority 1 — High (confuses users without reading docs)

### P1.1 — `blvm sync` defaults to wrong RPC

**Problem:** CLI default network is regtest → RPC 18332; mainnet node on 8332.

**Fix:** RPC connect failure hints in subcommands; README uses `blvm --network mainnet sync`.

**Repos:** `blvm` · **Effort:** Small

---

### P1.2 — README two equal start paths

**Problem:** Direct `blvm` and script presented as peers.

**Fix:** Primary = one `blvm --config …` block; script = optional wrapper.

**Repos:** `blvm` README · **Effort:** Small

---

### P1.3 — ~30s silence after start

**Problem:** Peer discovery before IBD looks hung.

**Fix:** Log “peer discovery in progress — IBD starts once peers connect (typically 15–60s)”.

**Repos:** `blvm-node` · **Effort:** Small

---

## Priority 2 — Medium

| ID | Problem | Fix | Repo |
|----|---------|-----|------|
| P2.1 | WAN-only stalls | Auto-prefer LAN for IBD download **or** README expectation | node + README |
| P2.2 | Port 8333 in use | Clear bind error + example config comment | node + example |
| P2.3 | Module bootstrap during IBD | `[modules] enabled = false` in example | `blvm` |

---

## Priority 3 — Low

| ID | Problem | Fix | Repo |
|----|---------|-----|------|
| P3.1 | Quick Start regtest-first | Link to First mainnet sync | README |
| P3.2 | Resume vs wipe | Startup resume log + README callout + 1-line script note | node + README |
| P3.3 | Log vs `blvm sync` mismatch | Docs (A) or richer sync output (B) | `blvm` |

---

## PR order (updated)

| PR | Items | Blocker |
|----|-------|---------|
| **PR0** | P0.1, P0.2 | **Must land first** |
| **PR1** | P1.2, P3.1, P2.3 | Docs/config only |
| **PR2** | P1.1, P3.3A | `blvm` |
| **PR3** | P1.3, P3.2 | `blvm-node` patch |
| **PR4** | P2.2 | `blvm-node` |
| **PR5** | P2.1 | Optional after testing |
| **PR6** | P3.3B | Optional |

Publish **blvm-node** before **blvm** tag when node changes ship.

---

## Plan validation (2026-05-21)

| Check | Result |
|-------|--------|
| P0 root cause matches CI log (`libLLVM.so.19.1`) | ✅ Verified on runner host |
| P0 fix avoids hardcoded broken lld | ✅ mold → working lld → bfd fallback |
| fmt failure matches single file | ✅ `sync.rs` only |
| P1–P3 items map to real smoke-test friction | ✅ v0.1.27 release test |
| No script bloat in P1–P3 | ✅ |
| Release job needs `setup` for `rustflags` output | ✅ Added to needs |
| Fuzz job still clears RUSTFLAGS for sanitizers | ✅ Unchanged step override |

---

## Explicit non-goals

- New shell scripts (beyond minor `start-ibd-mainnet.sh` edits)
- `start-ibd-clean.sh` / workspace env matrices
- `.deb` doc install
