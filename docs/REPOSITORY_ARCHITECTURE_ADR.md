# Repository Architecture Decision Record

Monorepo vs. Separate Repositories with Local Patch Workflow for the Bitcoin Commons / BLVM Rust Implementation

Comprehensive analysis of arguments, trade-offs, and project-specific considerations. Prepared June 22, 2026.

**Published summary:** [Repository layout](https://docs.thebitcoincommons.org/development/repository-architecture.html) in the BLVM book.

---

## Executive Summary

This decision record synthesizes every argument raised during extensive analysis of repository structure for Bitcoin Commons, a specification-first cryptographic protocol project whose explicit purpose is to enable a market for independent, alternative implementations and thereby break implementation monoculture. The analysis weighs general principles applicable to complex protocol work against the concrete mechanics and long-term goals of this specific codebase.

The current architecture—separate, independently versioned and published repositories for the layered core crates, augmented by a `[patch.crates-io]` section for local development and CI that strips the patch to verify the real published dependency graph—emerges as the superior fit. It uniquely preserves partial per-layer forkability and the deliberate volatility gradient (SDK most volatile at the edge; Consensus most stable at the foundation, with dependencies pointing only inward). These properties directly enable lightweight forks of higher layers that continue to receive upstream releases of stable lower layers automatically, avoiding the all-or-nothing maintenance burden that characterizes Bitcoin Core forks.

While a consolidated Cargo workspace for the tightly coupled core would improve day-to-day developer experience, side-effect visibility, and onboarding discoverability, it would flatten the volatility gradient into a single release unit and convert any fork of one layer into a fork of the entire core. That tradeoff sacrifices the project's primary mechanism for fostering ecosystem diversity. The specification (Orange Paper + formal spec + spec-lock) provides the coherence guarantee; repository proximity is not load-bearing for correctness.

Therefore, the separate-repositories structure, despite its real but mitigable frictions, better serves the project's mission.

## 1. Project Context, Philosophy, and Constraints

### 1.1 Specification-First Coherence

Bitcoin Commons is deliberately specification-first. The canonical artifacts are the Orange Paper together with the formal specification. Implementations conform to the spec; the spec is authoritative. The Rust codebase under the BTCDecoded organization is merely the first implementation, not the reference implementation and not a privileged one. Future independent implementations in other languages are expected and welcomed; none will defer to the Rust code. Correctness across components and across entirely separate implementations is enforced at the level of the specification, not by physical proximity or shared compilation of any single codebase. This single fact substantially weakens the usual argument that a monorepo is required to keep layers in agreement through type checking and atomic compilation.

### 1.2 Layered Architecture with Deliberate Volatility Gradient

The core is intentionally layered by volatility and stability, with dependencies pointing only inward toward more stable layers:

- **blvm-sdk** — most volatile, sits at the edge; the primary target for extension and alternative user-facing interfaces.
- **blvm-node** — next most volatile; the runnable node binary and associated runtime concerns.
- **blvm-protocol** — more stable; protocol messages, serialization, and wire behavior.
- **blvm-consensus / blvm-primitives** — least volatile foundation; consensus rules and fundamental types.

This ordering is not accidental. It makes per-layer forking practically safe: a fork of a higher, more volatile layer depends only on published versions of the stable layers beneath it. Upstream releases of the foundation continue to flow into the fork via normal Cargo dependency resolution without breakage. The volatility gradient is therefore a core architectural feature that enables sustainable partial forks.

### 1.3 Governance and Long-Horizon Design Goals

The project is built to outlast its current contributors and to resist the slow concentration of authority that captures informally governed systems over decades. Governance jurisdiction is assigned by the public merge record per crate, with a contributor's domain extending one hop along the dependency graph, determined automatically rather than by human adjudication. Hard, explicit, versioned, published boundaries keep this model clean. In a workspace, a contributor can introduce a path dependency that quietly couples two crates; nothing structural prevents it. With separately published, versioned dependencies, crossing a boundary means taking a dependency on a published version, making coupling explicit. This structural guarantee compounds over time rather than decaying with reviewer vigilance.

### 1.4 Independent Consumption and Ecosystem Value

Several crates have genuine value entirely independent of Bitcoin Commons. blvm-secp256k1, blvm-muhash, and blvm-miniscript can be consumed by any Rust project needing a fast secp256k1 implementation or a MuHash accumulator without adopting anything else from the project. Publishing these as independent crates with their own semver history is ordinary and valuable practice in the Rust ecosystem for infrastructure and cryptographic primitives. The same logic extends to the more volatile edge layers of the core: an alternative implementation may wish to adopt only the SDK or only the protocol layer while continuing to receive upstream improvements to the stable foundation.

### 1.5 Scale and Organizational Topology

The organization contains approximately 29 repositories when counting supporting, documentation, benchmark, website, and CI configuration repositories. The number of crates a typical contributor must reason about for any given change is a much smaller interdependent subset (the layered core plus relevant modules). Nevertheless, the discoverability problem remains real: newcomers must determine which subset is required, and the mental model of the system is distributed across repository boundaries.

## 2. Mechanics of the Current Separate-Repositories Structure

### 2.1 Local Development Workflow

A `[patch.crates-io]` section in the Cargo configuration redirects inter-crate dependencies to local filesystem paths. When a contributor has the relevant repositories checked out, the implementation compiles and tests as a single unit—exactly as it would inside a Cargo workspace. Changes that span multiple crates can be developed, tested, and debugged together without waiting for publication. The ergonomics that make a monorepo pleasant during active development are therefore available locally. One known rough edge is that the patch does not automatically fall back to published crates if a local checkout is missing; the contributor must have the full interdependent set present.

### 2.2 Continuous Integration Workflow

CI explicitly removes the `[patch.crates-io]` section. The build then resolves dependencies against the actually published crates on crates.io rather than local paths. This is a deliberate and valuable property: a typical workspace monorepo always builds against in-tree code and therefore never exercises the exact dependency graph that external downstream consumers will see. Incompatibilities between published versions can remain undetected until a third party encounters them. By stripping the patch on CI, Bitcoin Commons verifies the real published dependency graph on every run—the path that actually ships is the one that gets tested. Local development exercises the convenient development path; CI exercises the real consumption path.

### 2.3 Publishing and Versioning

Each crate is published independently with its own semver. Coordinated releases across layers require explicit version bumps and publishing order, but this is accepted as the cost of preserving the boundary and forking properties. The spec-lock crate provides an additional verification layer that ties the implementation back to the formal specification.

## 3. Arguments in Favor of a Monorepo or Consolidated Workspace

These arguments apply generally to complex, tightly coupled protocol work and were developed independently of the Bitcoin Commons specifics. They represent the strongest steelman case for consolidation.

### 3.1 Comprehensive Side-Effect Visibility and Holistic Reasoning

In protocol development, changes rarely remain isolated. Modifications to cryptographic primitives, consensus rules, serialization formats, mempool policy, networking, or RPC layers routinely produce ripple effects across validation, signing, and higher-level components. A monorepo (or single workspace) makes these interactions visible and testable by default: a single atomic commit or pull request can touch every relevant call site; a single `cargo check` or test run exercises the full integration surface; reviewers can reason about aggregate impact without reconstructing context across repository boundaries. Polyrepo structures require coordinated changes across multiple repositories, increasing the probability that side effects are discovered late (or not at all) during integration. In cryptographic work securing real value, this class of subtle, high-impact bugs is especially costly.

### 3.2 Atomic Changes Across Layers

Protocol evolution—soft forks, new opcodes, post-quantum migration paths, changes to consensus constants or trait bounds—frequently requires coordinated edits across multiple layers. A monorepo makes such changes natural and low-friction. The alternative requires either multi-repository coordination dances or temporary path-dependency hacks that must later be cleaned up. Atomicity reduces a source of coordination error and lost context. To make this concrete: suppose a consensus constant changes its type bound—for example, a block weight limit moving from a `u32` to a `u64` to accommodate a future capacity change. That type propagates through protocol serialization in blvm-protocol, into validation logic in blvm-consensus, and up through the RPC and SDK surfaces in blvm-node and blvm-sdk. In a monorepo, a single pull request touches every call site, the compiler enforces completeness, and no intermediate state is ever published or testable in isolation. In the separate-repositories structure, that same change requires coordinated version bumps and publishing across four or five repositories in dependency order, with CI on each needing to pass before the next can be updated. Each step is a potential gap where the system is in a partially migrated state that external consumers could encounter.

### 3.3 Discoverability, Onboarding, and Reduced Cognitive Load at Scale

With ~29 repositories in the organization, polyrepo structures impose a significant discoverability tax. Newcomers (and even experienced contributors on a bad day) must determine which subset of repositories is required to compile, test, or modify a given feature. The mental model of the system becomes fragmented. Issue tracking and routing to subject-matter experts degrades: it becomes unclear where a class of problem should be filed, and cross-cutting concerns are difficult to surface systematically. A monorepo collapses this problem: one primary clone target, a standard build interface, a single searchable corpus, and unified issue tracking that can use labels, component directories, CODEOWNERS, and project boards for routing. This directly reduces the friction of "which repositories do I need?" and "where does this ticket belong?"

### 3.4 Egalitarian and Meritocratic Participation — The Anti-Gatekeeping Argument

This is the most consequential normative argument. Expecting contributors to rely on AI harnesses, custom automation scripts, meta-repositories, or deep familiarity with an organization's repository topology simply to begin participating is incompatible with egalitarian and meritocratic values—especially in projects whose purpose is the development of cryptographic systems that secure real economic or societal value. Such requirements create a de facto barrier that favors individuals who already possess advanced tooling fluency, time to maintain personal infrastructure, or insider knowledge of hidden structure. In high-stakes cryptographic work, broad and diverse participation is not merely desirable but functionally important for review quality, bug discovery, and legitimacy. A monorepo removes an entire layer of accidental complexity, making the baseline act of contribution closer to "clone one repository and follow standard commands." This aligns the technical architecture with a commitment to fairness and merit-based contribution rather than concentrating influence among those already comfortable with the fragmented setup. (This argument is directly addressed in Section 5.3.)

### 3.5 Developer Experience: IDE, Refactoring, and Global Tooling

rust-analyzer, global search-and-replace, cross-crate refactoring, and unified test execution work more fluidly inside a single repository or workspace. While the patch workflow recovers much of the build-and-test experience, it does not fully replicate the seamless integration that a true workspace provides for interactive development, jump-to-definition across crates, and large-scale refactoring. In a codebase where subtle interactions matter, this friction can increase the chance that interactions are missed during active work.

### 3.6 CI Cost Is Manageable and Separable from Publishing Risk

Monorepos increase the surface area of continuous integration, but the cost is mitigable without heroic effort: Cargo workspaces with `workspace.dependencies`, persistent compilation caching (sccache), path-based or metadata-driven triggering of affected crates, and selective test execution keep incremental builds acceptable. A critical security constraint must be observed regardless of structure: CI pipelines used for development and testing must remain separate from artifact publishing. Using routine CI to publish crates or binaries introduces supply-chain risk; recent incidents have shown that compromised CI runners are high-value targets precisely because they often hold publish tokens. Better patterns include trusted publishing via OIDC, gated/manual publish steps, reproducible builds, and SLSA provenance. When this separation is maintained, the CI overhead of a monorepo remains an engineering trade-off rather than a fundamental blocker.

## 4. Arguments in Favor of the Current Separate-Repositories Structure

These arguments are both general (applicable to any project with similar constraints) and specific to Bitcoin Commons' stated goals. They were decisive in the final assessment.

### 4.1 Partial Forkability — The Monoculture-Breaking Property

With the core crates as separate, independently versioned repositories, someone who wants to replace or extend only one layer (for example, the SDK) can fork only that single repository. Their fork continues to depend on the consensus, protocol, and node crates as published versions on crates.io. Upstream releases of those stable lower layers flow into the fork automatically via normal Cargo resolution. The forker maintains only the layer they changed. This is the exact opposite of the all-or-nothing maintenance burden that Bitcoin Core imposes on its forks, where forking any part effectively requires forking and maintaining the entire codebase going forward. Independent versioned crates are what make partial forks viable; partial forks are what make a genuine market for alternative implementations possible. This is not a minor convenience—it is the central mechanism by which the project pursues its mission of breaking implementation monoculture.

### 4.2 Volatility Gradient Enables Safe Per-Layer Forking in Practice

The deliberate ordering (SDK most volatile → Node → Protocol → Consensus least volatile) with dependencies pointing only inward means that a fork of a higher layer depends only on the stable layers beneath it. Changes in volatile layers rarely break stable ones below them, so forks remain compatible with upstream releases of the foundation. A workspace or monorepo flattens this gradient into a single release unit. Any fork of one layer becomes a fork of the entire core; the forker inherits ownership of unchanged layers and must manually merge all upstream changes to those layers indefinitely. The volatility gradient is therefore not merely aesthetic—it is what makes per-layer forking safe and sustainable rather than theoretical.

### 4.3 Hard Boundaries Align with Governance and Resist Drift

The governance model assigns jurisdiction by public merge record per crate, extending one hop along the dependency graph. This model stays clean only when crate boundaries are hard and unambiguous. In a workspace, path dependencies can quietly couple crates without structural penalty; coupling becomes accidental rather than explicit. With separately published, versioned dependencies, crossing a boundary requires taking a dependency on a published version, making the coupling visible and costly. Over a multi-decade horizon, explicit published boundaries do not depend on every future reviewer noticing and rejecting violations; the cost of crossing them is built into the structure. This property compounds rather than decays, directly supporting the project's anti-capture, long-horizon design intent.

### 4.4 CI Verifies the Real Published Dependency Graph

A workspace monorepo always builds against in-tree code and therefore never verifies that the published crates work together as published. Incompatibilities between published versions can go undetected until a downstream consumer is affected. The patch-strip-on-CI approach forces verification of the exact dependency graph that external users experience. This is a concrete correctness advantage that most workspace-based projects forgo. Local development exercises the convenient development path through the patch; CI exercises the real consumption path by removing it. The path that ships is the one that gets tested.

In a cryptographic consensus implementation securing real monetary value, shipping a dependency graph that was never tested as assembled is not merely a convenience gap—it is a category of supply chain vulnerability. A discrepancy between the in-tree build and the published dependency resolution is exactly the kind of subtle, high-impact failure mode that adversaries target and that routine testing is supposed to foreclose. The CI patch-strip approach closes that gap structurally rather than relying on discipline. It represents a verification pattern that is underutilized in the broader Rust ecosystem and may be worth documenting as a standalone technical reference.

### 4.5 Independent Consumption for External Ecosystem Value

Crates with standalone cryptographic or infrastructure value (blvm-secp256k1, blvm-muhash, blvm-miniscript) can be adopted by unrelated projects without pulling in the rest of the system or its release cadence. This is standard and valuable Rust ecosystem practice. The same principle extends to the volatile edge layers of the core: an alternative implementation effort may wish to consume only the protocol messages or only the SDK while continuing to benefit from upstream improvements to the stable foundation.

### 4.6 Specification Provides Coherence; Repository Structure Is Not Load-Bearing for Correctness

Because correctness and inter-component agreement are anchored in the formal specification and the spec-lock crate (not in shared compilation or type proximity within one repository), the physical layout of the Rust implementation is not required to perform the coherence function that a monorepo would otherwise provide. The same property that allows a future C or Go implementation to stand as a first-class citizen alongside the Rust one also allows the Rust implementation's own crates to live in separate repositories without losing coherence. Repository structure can therefore be optimized for other goals—independent consumption, boundary enforcement, capture resistance, and partial forkability—without sacrificing the guarantee that components remain aligned with the spec.

This is the architecturally distinctive claim of the entire document, and it deserves to be stated plainly: no other project in the Bitcoin ecosystem can make it. Every other alternative implementation effort—whether Knots, libbitcoin, or any node project in the last seventeen years—has had to treat Bitcoin Core's source code as the de facto specification, because no implementation-agnostic formal specification existed. That means every one of them inherited the coherence problem that proximity-based repository structure is supposed to solve. Bitcoin Commons does not. The Orange Paper is a formal mathematical specification in RFC/IETF MUST/MUST NOT format, implementation-agnostic by construction, with numbered consensus rules that any implementation in any language can be tested against. The BLVM spec-lock enforces alignment between the specification and the Rust implementation as a CI build requirement. Correctness is not a property of the repository layout. It is a property of the specification. This is what makes the separate-repositories structure not merely acceptable but architecturally coherent: the mechanism that would otherwise justify monorepo proximity has been replaced by something more rigorous.

## 5. The Hybrid Proposal and Its Evaluation

### 5.1 What the Hybrid Would Have Looked Like

An earlier suggestion was to consolidate the tightly coupled layered core (blvm-primitives, blvm-consensus, blvm-protocol, blvm-node, blvm-sdk, and closely related modules) into a single Cargo workspace or monorepo while keeping genuinely standalone cryptographic primitives (blvm-secp256k1, blvm-muhash, etc.) as separate published repositories that the workspace would depend on via normal version constraints. This would have delivered most of the developer-experience and side-effect-visibility benefits of a monorepo for the majority of day-to-day work on the primary implementation, while preserving independent consumption for the true infrastructure crates.

### 5.2 Why the Hybrid Was Initially Attractive

It would have reduced onboarding friction (one primary clone target for the core), improved global search and refactoring fluidity, made cross-layer side effects more immediately visible during active development, and lowered the coordination tax for atomic changes. The CI verification advantage could have been approximated with release-matrix testing against published versions of the standalone crates. For a project whose primary activity is evolving the core implementation, these gains appeared substantial.

### 5.3 Why the Hybrid Conflicts with Core Project Goals

Consolidating the layered core into a workspace would have flattened the deliberate volatility gradient into a single release unit. A fork of the SDK would have become a fork of the entire core workspace. The forker would have inherited maintenance responsibility for consensus, protocol, and node even if they had no intention of modifying them. Upstream releases of those stable layers would no longer flow automatically; the fork would have to manually merge all changes, recreating precisely the all-or-nothing maintenance burden that Bitcoin Core imposes and that this project exists to avoid. Partial forkability—the ability to replace or extend only one layer while continuing to receive upstream improvements to the stable foundation—is not a nice-to-have; it is the central mechanism that makes a market for alternative implementations viable and sustainable. The hybrid would have optimized short-term developer convenience and side-effect visibility inside this particular Rust implementation at the direct expense of the larger ecosystem property that defines the project's purpose.

### 5.4 Why These Factors Were Decisive

The specification-first philosophy already removes the need for repository proximity to enforce correctness. The volatility layering and inward-only dependencies were intentionally designed to make per-layer forking safe in practice. The governance model relies on hard published boundaries. All of these properties are preserved by the current separate-repositories structure and would have been compromised—some fatally—by consolidation of the core. The contributor-experience and discoverability gains, while real and desirable, are secondary to preserving the conditions under which alternative implementations can emerge and thrive without bearing an unsustainable maintenance tax. Broad participation in the development of this Rust implementation matters; enabling a diverse ecosystem of implementations matters more.

## 6. Remaining Drawbacks of the Current Structure and Mitigations

The current separate-repositories-with-patch approach is not cost-free. The following drawbacks are genuine and should be acknowledged and actively mitigated rather than dismissed.

### 6.1 Onboarding and Discoverability Friction

New contributors must still determine which subset of repositories constitutes the relevant core for their intended change. The patch workflow requires local checkouts; the lack of automatic fallback to published crates if a local directory is missing adds a rough edge. Even with good documentation, the cognitive load of maintaining an accurate mental model of the organizational topology is higher than "clone one thing." This friction can concentrate participation among those already comfortable with the setup, partially undercutting the egalitarian ideal even if it does not rise to the level of requiring AI harnesses.

### 6.2 Slightly Reduced Seamlessness for Side-Effect Detection and Tooling

While the patch makes cross-crate testing possible, it is not identical to a true workspace for interactive development. rust-analyzer multi-crate support, global search across the entire relevant corpus, and large-scale refactoring require more manual coordination. In a high-stakes cryptographic codebase where subtle interactions can have systemic consequences, this friction increases (even if only modestly) the chance that an interaction is missed during active work or review.

### 6.3 Release and Coordination Overhead

Coordinated changes that touch multiple crates require explicit version bumps, publishing order management, and downstream `Cargo.toml` updates. Atomic commits across layers are impossible; the coordination tax is paid in process steps rather than in git history. Over a multi-decade horizon this compounds, even if the boundary-enforcement benefit provides countervailing protection against drift.

### 6.4 Recommended Mitigations

These costs are real but addressable without collapsing the architectural advantages:

- **Central high-signal documentation:** A living "Map of the World" in the highest-traffic repository or a dedicated meta/docs repository that clearly identifies the interdependent core subset, provides one-command clone scripts or workspace manifests for common contribution paths, includes dependency graphs, and contains explicit guidance on where to file different classes of issues.
- **Improved patch ergonomics:** Add optional fallback logic to the patch configuration or provide helper scripts that clone the minimal required set for a given area of work.
- **GitHub-native discoverability tooling:** Consistent use of repository topics, custom properties (key-value metadata), and curated GitHub Lists or Projects that surface the core subset and route issues to the appropriate subject-matter experts via CODEOWNERS and component labels.
- **Strong contribution guides and issue templates:** Force or strongly suggest component/area labels; document common contribution paths with copy-paste commands; make SME ownership visible.
- **Spec as primary coordination mechanism:** Continue to rely on the formal specification and spec-lock as the authoritative source of truth for inter-component agreement, reducing pressure on the Rust code layout to perform a coherence role it was never required to play.
- **Pre-release versioning / shadow publish workflow for cross-layer coordination:** For situations where a contributor needs to test a change in a lower (more stable) crate against an upper (more volatile) crate in CI before the lower crate is formally released, adopt a pre-release versioning convention (e.g., alpha/beta tags or dev versions) or a shadow-publish workflow that temporarily makes the changed lower crate available for testing without affecting the public release cadence.

## 7. Trade-off Summary

| Criterion | Monorepo / Workspace advantage | Separate-repos + patch advantage | Relevance to this project |
|-----------|----------------------------------|----------------------------------|---------------------------|
| Side-effect visibility during development | High — atomic changes, unified search & test | Medium — patch recovers build/test; tooling more fragmented | Important but secondary; spec provides ultimate coherence |
| Partial / per-layer forkability & ecosystem diversity | Low — any layer fork becomes full-core fork | High — fork one volatile layer, keep upstream stable layers | **Decisive** — central mechanism for breaking monoculture |
| Onboarding discoverability at scale | High — one clone target | Medium-Low — subset identification, patch checkouts | Real friction; mitigable with documentation |
| Egalitarian participation | High — "clone one thing and cargo build" | Medium — topology fluency required | Important; acceptable if mitigations applied |
| Hard boundaries, governance, drift resistance | Low — accidental coupling easy | High — published boundaries compound over decades | Strongly aligned with governance model |
| CI verification of published dependency graph | Low — always builds in-tree | High — patch stripped on CI | Concrete correctness advantage |
| Independent consumption | Medium — possible but messier | High — natural published crates | Important for crypto primitives and edge layers |
| Release coordination overhead | High — atomic cross-layer commits | Medium — explicit version bumps per crate | Acceptable cost given forking benefits |

## 8. Conclusion and Recommendation

After weighing every argument—general principles of side-effect visibility and egalitarian participation, project-specific mechanics of the patch workflow and CI verification, the decisive importance of partial forkability, and the deliberate design of the volatility gradient—the current separate-repositories-with-`[patch.crates-io]` structure is the better and more values-aligned choice for Bitcoin Commons / BLVM.

The specification provides the coherence that a monorepo would otherwise be asked to supply. The volatility layering and inward-only dependencies make per-layer forking not merely possible but practically safe and low-maintenance. Hard published boundaries align with the governance model and provide structural resistance to drift and capture over the multi-decade horizon the project contemplates. The CI workflow that strips the patch verifies the real published dependency graph—an advantage most workspace projects never obtain. Partial forkability is preserved, enabling the very market for alternative implementations that the project exists to create.

A consolidated workspace for the core would have purchased improved developer experience, more seamless side-effect visibility, and lower onboarding friction at the direct cost of flattening the volatility gradient and converting every layer fork into a full-core fork. That tradeoff is unacceptable for a project whose primary purpose is breaking implementation monoculture through sustainable partial adoption. The contributor-experience costs of the current structure are real and should be actively mitigated through excellent central documentation, improved patch ergonomics, GitHub-native discoverability tooling, and clear contribution paths. They do not, however, justify sacrificing the architectural properties that make alternative implementations viable.

The recommendation is therefore to retain and refine the current separate-repositories structure, invest in the mitigations outlined in Section 6, and treat the specification itself—rather than any particular Rust repository layout—as the primary coordination and correctness mechanism. This choice is unconventional relative to typical Rust multi-crate practice, but it is principled, internally consistent, and directly supportive of the project's long-term mission.

---

This document synthesizes arguments developed across an extended technical discussion. It is intended as a living decision record for the project's own use and for anyone evaluating the architectural choices. Nothing in this record should be read as criticism of monorepo or workspace approaches in other contexts; those remain excellent defaults for the majority of multi-crate Rust efforts. Bitcoin Commons' constraints—specification-first correctness, volatility-layered partial-forking model, governance-by-merge-record, and multi-decade anti-capture horizon—are sufficiently distinctive that the usual default does not apply.
