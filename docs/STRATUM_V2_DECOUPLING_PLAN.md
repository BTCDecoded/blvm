# Stratum V2: migrate transport into the module

**Scope:** Miner-facing **dedicated TCP** lives in **`blvm-stratum-v2`**. **`blvm-node`** keeps P2P ingress (TLV demux → `StratumV2MessageReceived`), chain APIs, and **`NodeAPI::send_peer_transport_payload`** for opaque bytes to peers.

**Location:** **Mirror** (this repo): `docs/STRATUM_V2_DECOUPLING_PLAN.md`. **Canonical:** **blvm-docs** `src/development/stratum-v2-decoupling-plan.md`. **No new crate** — **`NodeAPI`** stays on **`blvm-node`**; Stratum protocol code stays in **`blvm-stratum-v2`**.

---

## Validated facts (re-run after substantive code changes)

| Fact | Where | Notes |
|------|--------|--------|
| Module **`start()`** binds **`listen_addr`** (TCP) when possible | `blvm-stratum-v2/src/server.rs` `start()` | Falls back to inbound via **`StratumV2MessageReceived`** if bind fails |
| Module **production** uses **`send_to_miner`** (local mpsc, else **`NodeAPI::send_peer_transport_payload`**) | `blvm-stratum-v2/src/server.rs` | P2P / multi-transport outbound |
| Module **subscribes** to `StratumV2MessageReceived` | `blvm-stratum-v2/src/module.rs`, `server.rs` `handle_event` | P2P-delivered Stratum TLV |
| Node **dedicated Stratum listener** | *Removed* (was `stratum_v2_listener.rs`) | **Module-only** dedicated port |
| Node **P2P Stratum heuristic** | `network_manager.rs` (`stratum-v2` feature) | TLV-shaped P2P bytes → `StratumV2MessageReceived` |
| **Dispatch → module event** | `network_message_dispatch.rs` | `NetworkMessage::StratumV2MessageReceived` |
| **`NodeAPI::send_peer_transport_payload`** | `traits.rs`, `node_api.rs`, IPC hub/server | Former Stratum-specific name: IPC still uses `SendStratumV2MessageToPeer` for wire compatibility |
| **IPC wire** | `ipc/protocol.rs` | `SendStratumV2MessageToPeer` = opaque peer payload (not Stratum-specific) |
| **Mocks** | `blvm-mesh`, `blvm-governance`, tests | Implement **`send_peer_transport_payload`** |

---

## What stays in `blvm-node` today (after A–D)

Mining / chain APIs, **`send_peer_transport_payload`**, **optional** P2P TLV demux + **`StratumV2MessageReceived`** (feature **`stratum-v2`**), **`get_block_template`**, **`submit_block`**, module hosting, IPC, events. **Removing demux entirely** is **Phase E2** below—not required for module-first miner TCP.

---

## Phases (narrow)

| Phase | Status |
|-------|--------|
| **A** | Done: module TCP, **`send_to_miner`**. |
| **B** | Done: TCP parity tests (`tests/module_tcp_parity_tests.rs`); node CI **`--features stratum-v2 --lib`**. |
| **C** | Done: removed **dedicated listener**, **`stratum_connections`**, **`send_stratum_v2_to_peer`**. **Kept:** P2P path + **`StratumV2MessageReceived`** + dispatch. |
| **D** | Done (API): **`send_peer_transport_payload`**; IPC variant name unchanged for compatibility. |

---

## Incremental migration: node → Stratum module ecosystem

**Constraint:** `blvm-stratum-v2` depends on **`blvm-node`** (`NodeAPI`, IPC). The node **cannot** depend on the full stratum crate without a dependency cycle. “Move out of the node” therefore means either **delete** node-only dead code or **share** logic via a **third tiny crate** both can depend on.

| Step | What moved / removed | Status |
|------|---------------------|--------|
| **F0** | Dedicated miner TCP listener in node | Done (earlier phases). |
| **F1** | URL-only **`StratumV2Client`** stub, **`network/stratum_v2/`**, **`MiningCoordinator`** hooks, unused **`EventPublisher::publish_stratum_client_*`** wrappers | **Done** in tree: pool/Stratum client construction belongs in **`blvm-stratum-v2`**. |
| **F2** | P2P TLV **tag heuristic** (~`network_manager.rs`): extract to a small **`blvm-stratum-tlv`** (or similar) crate with **no** `blvm-node` dependency; **`blvm-node`** and **`blvm-stratum-v2`** both depend on it so tag ranges stay single-sourced. | **Next** (optional; requires publishing or path dep policy). |
| **F3** | **`StratumV2Config`** only on module | Only after merge-mining / top-level TOML story is agreed (may stay on node for shared config). |
| **F4** | **`EventType` / IPC**: remain on **`blvm-node`** until a versioned ABI change—modules subscribe by central enum. | Design-time only. |

---

## Parity gate

1. **Module TCP vs `handle_message`:** `blvm-stratum-v2/tests/module_tcp_parity_tests.rs`.  
2. **P2P:** TLV demux retained; product may later narrow or gate it.  
3. **Config:** **`[stratum_v2].listen_addr`** on the node is informational; **miners use the module** `listen_addr`.

---

## Operator checklist (module-first)

1. Run **`blvm-stratum-v2`**; set **`stratum_v2.listen_addr`** to the port miners use.  
2. Do **not** expect the node to bind a duplicate dedicated Stratum port—only one **`listen_addr`** should serve miners (the module’s).  
3. **`[stratum_v2]`** block remains for merge-mining / pool-related settings where applicable; it does **not** start an in-node miner TCP listener.

---

## Generalization (later)

Reuse **`send_peer_transport_payload`** pattern for other opaque peer protocols if needed. See **`docs/modules/BLVM_FIBRE_MODULE_PLAN.md`**, **`blvm-node/docs/MODULE_INTEGRATION.md`**.

---

## Related

- **`docs/modules/MODULE_PARITY_PLAN.md`**

---

## Phase E onward (optional): validated “what’s next”

Phases **A–D** are **closed** for “module owns miner TCP; node has no dedicated Stratum listener.”  
Everything below is **optional product / cleanup**. It is **explicitly gated** on one architectural choice.

### 0) Forking decision (do this first)

| Choice | Effect |
|--------|--------|
| **E1 — Keep P2P TLV demux** (default / status quo) | Inbound P2P payloads that **match the length+tag heuristic** in `blvm-node/src/network/network_manager.rs` (~1830–1861) are **not** parsed as normal Bitcoin P2P; they become **`NetworkMessage::StratumV2MessageReceived`** → **`StratumV2MessageReceived`** event. **`blvm-stratum-v2`** still **`handle_event`s** that variant (`server.rs` ~382+) and **`start()`** treats failed module TCP bind as “inbound only via **`StratumV2MessageReceived`**.” **Risk:** heuristic false positives could mis-route arbitrary bytes (bounded by tag ranges and length sanity). |
| **E2 — Remove P2P demux** | Delete or never compile the **`stratum-v2`** path in **`network_manager.rs`**, **`network/mod.rs`** (**`StratumV2MessageReceived`** variant), **`network_message_dispatch.rs`**, and align **`blvm-stratum-v2`**:** **`start()`** must not assume P2P fallback; operators rely **only** on module **`listen_addr`**. **Also** update docs under **`blvm-docs/`**, **`blvm/CONFIGURATION.md`**, **`blvm-stratum-v2/README.md`**, **`API.md`**. **Breaking:** any deployment that relied on Stratum-shaped frames over **Bitcoin P2P** stops working. |

**Validation after E1 or E2:** `cargo test --features stratum-v2 --lib` in **`blvm-node`**; `cargo test --all-targets` in **`blvm-stratum-v2`**; grep workspace for **`StratumV2MessageReceived`** and **`StratumV2MessageReceived`** (`NetworkMessage`).

---

### 1) Gate the heuristic without removing it (middle path)

If you keep **E1** but want **less surprise traffic**:

- Add a **config flag** (e.g. on **`StratumV2Config`** in `blvm-node/src/config/rpc.rs` or top-level config merge) default **`p2p_stratum_demux = false`** or **`true`**—product decides.
- Thread the flag into **`NetworkManager`** (constructor / options) so the block at ~1833 runs only when enabled.
- Document in **operator checklist** above.

**Touches:** `config/mod.rs`, config parsing, `network_manager` construction sites, tests.

---

### 2) IPC / event naming (cosmetic + breaking)

Today:

- **Rust API:** `NodeAPI::send_peer_transport_payload`.
- **IPC wire:** still **`SendStratumV2MessageToPeer`** (`ipc/protocol.rs`) for compatibility.
- **Events:** `StratumV2MessageReceived`, `StratumClientConnected`, `StratumClientDisconnected` (`traits.rs`, `protocol.rs`).

**Possible work (only if you accept versioned IPC or breaking clients):**

1. Add **parallel** IPC message type **`SendPeerTransportPayload`** (or alias in deserializer), keep old name as deprecated for one release.
2. Optionally rename events to **`PeerTransportPayloadReceived`**-style names—**every subscriber** must update (`blvm-stratum-v2` **first**).

**Validation:** module IPC tests, any out-of-tree modules subscribing to Stratum events.

---

### 3) Node config surface **`[stratum_v2]`**

**Status quo:** Node holds **`StratumV2Config`** for merge-mining / pool-related fields; **`listen_addr`** there is **not** a second miner bind.

**Options:**

- **Keep** as-is (document-only).
- **Split:** `merge_mining` vs `stratum_module` keys in **toml** (large doc + migration).
- **Remove** node block entirely and require **module-only** config—only if merge-mining no longer needs node-level fields.

---

### 4) **`StratumV2Client` stub (former `network/stratum_v2/client.rs`)

**Removed from the node:** URL-only struct and **`MiningCoordinator`** accessors had **no call sites**; **`blvm-stratum-v2`** already owns pool URLs / transport. Unused **`EventPublisher`** helpers for the same events were removed (modules still use **`NodeAPI::publish_event`**).

---

### 5) Suggested order of operations

1. Decide **E1 vs E2** (or **E1 + config gate**).  
2. If **E2:** adjust **`blvm-stratum-v2` `start()` / docs** in the **same PR** so behavior and operator docs match.  
3. If doing **IPC renames**, ship a **compat window** before deleting old wire names.

### 6) Regression checklist (copy for PRs touching this)

- [ ] `blvm-node`: `cargo check --features stratum-v2`  
- [ ] `blvm-node`: `cargo test --features stratum-v2 --lib`  
- [ ] `blvm-stratum-v2`: `cargo test --all-targets`  
- [ ] Grep: **`StratumV2MessageReceived`**, **`SendStratumV2MessageToPeer`**, **`network_manager`** Stratum comment block  
- [ ] Docs: **`blvm-docs`** mining pages + **`blvm/CONFIGURATION.md`** if behavior or flags change
