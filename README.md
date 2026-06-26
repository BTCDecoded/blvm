# BLVM Node

**Main binary for the Bitcoin Commons BLVM full node** — the `blvm` executable wrapping the [`blvm-node`](https://github.com/BTCDecoded/blvm-node) library.

Operator guides live in **[docs.thebitcoincommons.org](https://docs.thebitcoincommons.org)**. This README is a repo landing page only.

## Install

**Downloads, current release tag, filenames, and checksum commands:** [btcdecoded.org/install](https://btcdecoded.org/install)

Also: [GitHub Releases (latest)](https://github.com/BTCDecoded/blvm/releases/latest) · [Installation (book)](https://docs.thebitcoincommons.org/getting-started/installation.html)

Always verify the checksum file shipped with the artifact you downloaded (`checksums.sha256`, `SHA256SUMS-*`, or per-file `.sha256` — names vary by release).

### Stable release artifacts

| Format | Linux x86_64 | Linux aarch64 | Windows x86_64 |
|--------|--------------|---------------|----------------|
| `.deb` (Debian/Ubuntu) | yes | — | — |
| `.rpm` (Fedora/RHEL) | yes | — | — |
| `.pkg.tar.gz` (Arch) | yes | — | — |
| `.tar.gz` archive | yes | yes | — |
| Standalone binary | yes | yes | — |
| Portable `.exe` / `.zip` | — | — | yes |

**Docker (stable):** [`ghcr.io/btcdecoded/blvm`](https://github.com/BTCDecoded/blvm/pkgs/container/blvm) — tag matches the GitHub Release (see install page).

**Nightly (rolling):** `develop` branch → GitHub `nightly` assets and `ghcr.io/btcdecoded/blvm:nightly`. See [Release channels](https://docs.thebitcoincommons.org/development/release-process.html#release-channels).

**Source:** clone this repo; toolchain in [`rust-toolchain.toml`](rust-toolchain.toml). Feature sets differ by platform — [build variants](https://docs.thebitcoincommons.org/development/release-process.html#build-variants).

Release tarballs also ship helper scripts and example configs (e.g. [`blvm-mainnet-ibd.toml.example`](blvm-mainnet-ibd.toml.example), [`scripts/start-ibd-mainnet.sh`](scripts/start-ibd-mainnet.sh)).

## Documentation map

| Topic | Link |
|-------|------|
| Regtest tutorial | [Quick Start](https://docs.thebitcoincommons.org/getting-started/quick-start.html) |
| Config & RPC ports | [First Node Setup](https://docs.thebitcoincommons.org/getting-started/first-node.html) |
| **Mainnet IBD** | [Mainnet initial sync](https://docs.thebitcoincommons.org/getting-started/first-node.html#mainnet-initial-sync) |
| Configuration | [Node configuration](https://docs.thebitcoincommons.org/node/configuration.html) · [`CONFIGURATION.md`](CONFIGURATION.md) · [`blvm.toml.example`](blvm.toml.example) |
| Storage backends | [Storage Backends](https://docs.thebitcoincommons.org/node/storage-backends.html) |
| RPC | [RPC API Reference](https://docs.thebitcoincommons.org/node/rpc-api.html) |
| IBD tuning | [IBD configuration](https://docs.thebitcoincommons.org/node/configuration.html#ibd-configuration) · [IBD engine](https://docs.thebitcoincommons.org/node/ibd-engine.html) |
| Troubleshooting | [Troubleshooting](https://docs.thebitcoincommons.org/appendices/troubleshooting.html) |
| Contributing | [Contributing](https://docs.thebitcoincommons.org/development/contributing.html) |

## Quick start (regtest)

After install:

```bash
blvm version
blvm --network regtest --verbose
```

Guided walkthrough: [Quick Start](https://docs.thebitcoincommons.org/getting-started/quick-start.html).

**Mainnet first sync:** use the IBD example config — not bare `--network mainnet`. [Mainnet initial sync](https://docs.thebitcoincommons.org/getting-started/first-node.html#mainnet-initial-sync).

## Common commands

```bash
blvm status
blvm health
blvm sync          # same --network / --config / --data-dir as the running node
blvm rpc getblockchaininfo
blvm config show
```

RPC defaults: mainnet **8332**, testnet **18332**, regtest **18443**. Details: [RPC API](https://docs.thebitcoincommons.org/node/rpc-api.html).

## Build from source

```bash
git clone https://github.com/BTCDecoded/blvm.git
cd blvm
cargo build --release --locked
```

Optional backends and experimental flags: explicit `--features` — [Installation — experimental variant](https://docs.thebitcoincommons.org/getting-started/installation.html#experimental-variant).

**RocksDB** (when using `blvm-mainnet-ibd.toml.example`):

```bash
cargo build --release --locked --features rocksdb
```

## Architecture

```
blvm (binary)
  └── blvm-node
       └── blvm-protocol
            └── blvm-consensus
```

[Stack overview](https://docs.thebitcoincommons.org/architecture/system-overview.html)

## License

MIT
