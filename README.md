# BLVM Node

**Main binary for the Bitcoin Commons BLVM full node** — the `blvm` executable wrapping the [`blvm-node`](https://github.com/BTCDecoded/blvm-node) library.

## Documentation

**Operator and developer guides live in the book**, not in this README:

| Topic | Where |
|-------|--------|
| **Install** (releases, packages, verify checksums) | [btcdecoded.org/install](https://btcdecoded.org/install) · [GitHub Releases (latest)](https://github.com/BTCDecoded/blvm/releases/latest) |
| **Full documentation** | [docs.thebitcoincommons.org](https://docs.thebitcoincommons.org) |
| Regtest tutorial (~5 min) | [Quick Start](https://docs.thebitcoincommons.org/getting-started/quick-start.html) |
| Config, networks, RPC ports | [First Node Setup](https://docs.thebitcoincommons.org/getting-started/first-node.html) |
| **Mainnet initial sync (IBD)** | [First Node Setup — Mainnet IBD](https://docs.thebitcoincommons.org/getting-started/first-node.html#mainnet-initial-sync) |
| Configuration reference | [Node configuration](https://docs.thebitcoincommons.org/node/configuration.html) · [Configuration reference](https://docs.thebitcoincommons.org/reference/configuration-reference.html) |
| Storage backends | [Storage Backends](https://docs.thebitcoincommons.org/node/storage-backends.html) |
| RPC | [RPC API Reference](https://docs.thebitcoincommons.org/node/rpc-api.html) |
| IBD tuning & engine | [IBD configuration](https://docs.thebitcoincommons.org/node/configuration.html#ibd-configuration) · [IBD UTXO engine](https://docs.thebitcoincommons.org/node/ibd-engine.html) |
| Troubleshooting | [Troubleshooting](https://docs.thebitcoincommons.org/appendices/troubleshooting.html) |
| Build variants & features | [Installation — build from source](https://docs.thebitcoincommons.org/getting-started/installation.html#build-from-source) · [Release process](https://docs.thebitcoincommons.org/development/release-process.html) |
| Contributing | [Contributing](https://docs.thebitcoincommons.org/development/contributing.html) |

**In this repository:** [`blvm.toml.example`](blvm.toml.example) (general config), [`blvm-mainnet-ibd.toml.example`](blvm-mainnet-ibd.toml.example) (mainnet IBD), [`CONFIGURATION.md`](CONFIGURATION.md) (detailed config notes), [`scripts/start-ibd-mainnet.sh`](scripts/start-ibd-mainnet.sh) (release tarball helper).

## Quick start (regtest)

After [installing](https://btcdecoded.org/install) `blvm`:

```bash
blvm version
blvm --network regtest --verbose
```

For a guided regtest walkthrough (config, RPC, mine a block), see **[Quick Start](https://docs.thebitcoincommons.org/getting-started/quick-start.html)**.

**Mainnet:** do not use bare `--network mainnet` for first sync — follow **[Mainnet initial sync](https://docs.thebitcoincommons.org/getting-started/first-node.html#mainnet-initial-sync)** (example config + `start-ibd-mainnet.sh` in release tarballs).

## Common commands

```bash
blvm status
blvm health
blvm sync          # pass same --network / --config / --data-dir as the running node
blvm rpc getblockchaininfo
blvm config show
```

Subcommands share `--network`, `--config`, `--data-dir`, and `--rpc-addr` with the node process. RPC defaults are network-aware (mainnet **8332**, testnet **18332**, regtest **18443**). Details: [RPC API Reference](https://docs.thebitcoincommons.org/node/rpc-api.html).

## Build from source

Requires Rust **1.85+** (see [`rust-toolchain.toml`](rust-toolchain.toml) for the pinned toolchain used in CI).

```bash
git clone https://github.com/BTCDecoded/blvm.git
cd blvm
cargo build --release --locked
```

Default features match [release build variants](https://docs.thebitcoincommons.org/development/release-process.html#build-variants). Pass explicit `--features` for optional backends (e.g. `rocksdb`) or experimental flags — see [Installation](https://docs.thebitcoincommons.org/getting-started/installation.html#experimental-variant).

**Mainnet IBD with RocksDB** (when using `blvm-mainnet-ibd.toml.example`):

```bash
cargo build --release --locked --features rocksdb
```

## Architecture

```
blvm (binary)
  └── blvm-node
       ├── blvm-protocol
       │    └── blvm-consensus
       └── blvm-consensus
```

Stack overview: [docs.thebitcoincommons.org — Architecture](https://docs.thebitcoincommons.org/architecture/system-overview.html).

## License

MIT
