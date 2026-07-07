# Commons website — essential fixes only

**Status:** Active  
**Last revised:** 2026-07-04  
**Location:** `blvm/docs/COMMONS_WEBSITE_IMPROVEMENT_PLAN.md`  
**Implementation repo:** [`commons-website`](https://github.com/BTCDecoded/commons-website) (`thebitcoincommons.org`)  
**Baseline:** `commons-website` @ `9b86efa` (post–July 2026 whitepaper publish)

**Related:** [`btc-commons/docs/landing-page-plan.md`](../../docs/landing-page-plan.md) — run **this plan first**, then landing-page waves.

---

## Purpose

Fix homepage copy that **contradicts the whitepaper**, repeats taglines unnecessarily, or duplicates footer navigation. Not a full redesign or FAQ merge.

---

## Principle: one canonical home per fact

| Fact | Link here — do not restate on homepage |
|------|----------------------------------------|
| What is live today | [SYSTEM_STATUS.md](https://github.com/BTCDecoded/.github/blob/main/SYSTEM_STATUS.md) |
| Differential testing depth / CI | [differential-testing](https://docs.thebitcoincommons.org/development/differential-testing.html) |
| Full design argument | [whitepaper](https://thebitcoincommons.org/whitepaper.html) |
| Install, node, RPC | [mdBook FAQ](https://docs.thebitcoincommons.org/appendices/faq.html) |

Homepage FAQ = project positioning. mdBook FAQ = operators. Cross-link each way.

---

## In scope

### A. Whitepaper alignment (FAQ + cards)

| # | Location | Fix |
|---|----------|-----|
| A1 | White Paper card | Remove “roadmap” → “design and argument” |
| A2 | `faq-production-ready`, `faq-implementation-status` | Defer to SYSTEM_STATUS; drop “Phase 1 complete” / Phase 2 rhetoric |
| A3 | `faq-governance-how` | “Designed to” merge enforcement; repository layers × action tiers |
| A4 | `faq-fork-registry-*`, `faq-economics-*` | Modules operational; **registry not live yet** |
| A5 | `faq-proof-consensus` | Remove btcd/libbitcoin comparison paragraph |

### B. Tagline repetition

| Surface | Role |
|---------|------|
| Meta / OG / JSON-LD | Full SEO line: “Coordination without authority: formal specification…” |
| Hero H2 + tagline | **Only** on-page tagline: “Coordination without authority” + “Formal specification. Forkable governance. No new coin.” |
| Section H2 (`#built-title`) | Descriptive title, **not** a third tagline |
| Footer brand line | One short line, **different wording** from hero |

### C. Footer dedup

Three columns, no duplicate links:

- **Read** — FAQ, Documentation, White Paper  
- **Spec** — Consensus Spec, PROTOCOL, ARCHITECTURE, Orange Paper, Spec maps  
- **Project** — Governance designer, Project status, GitHub  

### D. Landing page wording pass

Light edit of visible homepage prose (hero through FAQ intro): tighten block-notes and cards; align governance designer card with whitepaper “designed to” scope; single **Specification** jump-nav link; FAQ intro cross-link to mdBook operator FAQ.

**Out of scope:** FAQ count merge, CSS/JS extract (index-home.css done), word-count targets.

---

## Cross-links (`blvm-docs` PR)

| Surface | Add |
|---------|-----|
| Homepage FAQ intro | Running a node? → [operator FAQ](https://docs.thebitcoincommons.org/appendices/faq.html) |
| mdBook `appendices/faq.md` | Project positioning → [site FAQ](https://thebitcoincommons.org/#faq) |

---

## Sequencing

1. `commons-website` PR (A–D)  
2. `blvm-docs` cross-link PR  
3. Landing-page waves C/A/B  

---

## Done

- [x] A1–A5, B, C, D on `commons-website` (local diff; push when ready)
- [x] Cross-links: homepage FAQ intro + mdBook `appendices/faq.md`
- [x] Grep clean: no roadmap, Phase 1/2, blocks merges, 5-tier, btcd/libbitcoin on homepage

---

## Changelog

| Date | Change |
|------|--------|
| 2026-07-04 | Initial full trim plan |
| 2026-07-04 | Reduced to essential fixes only |
| 2026-07-04 | Added tagline fix, footer dedup, landing wording pass (B–D) |
