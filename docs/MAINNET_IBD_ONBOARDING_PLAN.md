# Mainnet IBD onboarding plan (release users)

**Status:** implemented (monorepo; publish `blvm-node` 0.1.12 then tag `blvm` for release tarball)

## Resolved decisions

| Topic | Decision |
|-------|----------|
| Tarball layout | Flat at archive root beside `blvm` |
| Regtest RPC | Stay `127.0.0.1:18332`; mainnet → `8332` when `--rpc-addr` omitted |
| Example `[ibd].mode` | `parallel` in file; code uses `earliest` when validated tip == 0 |
| `.deb`/`.rpm` doc install | Deferred; tarball is P0 |

## Shipped changes

- `blvm-node` 0.1.12: LAN IBD hint log; fresh-chain `earliest` mode; `.toml.example` parsing
- `blvm`: `blvm-mainnet-ibd.toml.example`, `scripts/start-ibd-mainnet.sh`, network-aware RPC + `BLVM_RPC_ADDR`, README, release scripts

## Release order

1. Publish **blvm-node** 0.1.12 to crates.io
2. Bump **blvm** dependency / lockfile; tag release so CI tarball includes new files
