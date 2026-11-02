# BLVM configuration

The `blvm` binary merges one file with a thin overlay.

**Precedence, highest first:** CLI, then the environment variables this binary reads, then the config file, then the built-in default.

Search order for the file: `--config`, `./blvm.toml`, `~/.config/blvm/blvm.toml`, `/etc/blvm/blvm.toml`. TOML and JSON are both accepted. Unknown keys are ignored. An omitted table keeps the built-in default. A present table fills every key from that table's defaults.

`BitcoinV1` is an alias for `mainnet`. `Testnet3` is an alias for `testnet`. The binary writes `protocol_version` back as `mainnet`, `testnet`, `testnet4`, `signet`, or `regtest`.

## CLI

- `--network` selects the chain.
- `--data-dir` selects the data directory.
- `--listen-addr` selects the P2P bind.
- `--rpc-addr` selects the RPC bind.
- `--config` selects the file.
- `--verbose` sets the log filter to `blvm=debug,blvm_node=debug` when `RUST_LOG`, `BLVM_LOG_LEVEL`, and `[logging].filter` are unset.
- `--enable-bip158` / `--disable-bip158` set `serve_compact_filters`.
- `--enable-dandelion` sets `[relay].enable_dandelion`. `--disable-dandelion` clears `[dandelion]` and sets that relay flag false. The default binary includes the `dandelion` feature.
- `--enable-sigop` / `--disable-sigop` set `[mempool].count_sigops`. Enabling inserts the default mempool table when `[mempool]` is absent. The default binary includes the `sigop` feature.
- `--enable-stratum-v2` / `--disable-stratum-v2` do not write a node field. A binary built without the `stratum-v2` feature warns. That feature is not on by default. Miner TCP is the `blvm-stratum-v2` module.

## Environment variables this binary reads

| Variable | Writes |
|---|---|
| `BLVM_DATA_DIR` | Data directory. CLI wins. Then this variable, then `[storage].data_dir`, then `./data`. The path is written back only when `[storage]` already exists. |
| `BLVM_NETWORK` | Chain name. CLI wins, then this variable, then `protocol_version`, then regtest. |
| `BLVM_LISTEN_ADDR` | P2P bind. |
| `BLVM_RPC_ADDR` | RPC bind. CLI, then this variable, then `rpc_addr` in the file, then the network default. |
| `BLVM_NODE_MAX_PEERS` | `max_peers`. |
| `BLVM_NODE_TRANSPORT` | `transport_preference`. |
| `BLVM_NODE_FEATURES_BIP158` | `serve_compact_filters`. Compact filters are compiled in. |
| `BLVM_NODE_FEATURES_DANDELION` | `true` sets `[relay].enable_dandelion`. `false` clears `[dandelion]` and sets that flag false. |
| `BLVM_NODE_FEATURES_SIGOP` | `[mempool].count_sigops`. `true` inserts the default mempool table when `[mempool]` is absent. |
| `BLVM_NODE_FEATURES_STRATUM_V2` | No node field. `true` warns when the binary was built without `stratum-v2`. |
| `BLVM_NETWORK_TARGET_PEER_COUNT` | `[network_timing].target_outbound_peers`. |
| `BLVM_NETWORK_PEER_CONNECTION_DELAY` | `[network_timing].peer_connection_delay_seconds`. |
| `BLVM_NETWORK_MAX_ADDRESSES_FROM_DNS` | `[network_timing].max_addresses_from_dns`. |
| `BLVM_REQUEST_ASYNC_TIMEOUT` | `[request_timeouts].async_request_timeout_seconds`. |
| `BLVM_REQUEST_UTXO_COMMITMENT_TIMEOUT` | `[request_timeouts].utxo_commitment_request_timeout_seconds`. |
| `BLVM_REQUEST_CLEANUP_INTERVAL` | `[request_timeouts].request_cleanup_interval_seconds`. |
| `BLVM_REQUEST_PENDING_MAX_AGE` | `[request_timeouts].pending_request_max_age_seconds`. |
| `BLVM_MODULE_MAX_CPU_PERCENT` | `[module_resource_limits].default_max_cpu_percent`. |
| `BLVM_MODULE_MAX_MEMORY_BYTES` | `[module_resource_limits].default_max_memory_bytes`. |
| `BLVM_MODULE_MAX_FILE_DESCRIPTORS` | `[module_resource_limits].default_max_file_descriptors`. |
| `BLVM_MODULE_MAX_CHILD_PROCESSES` | `[module_resource_limits].default_max_child_processes`. |
| `BLVM_MODULE_STARTUP_WAIT_MILLIS` | `[module_resource_limits].module_startup_wait_millis`. |
| `BLVM_MODULE_SOCKET_TIMEOUT` | `[module_resource_limits].module_socket_timeout_seconds`. |
| `BLVM_MODULE_SOCKET_CHECK_INTERVAL` | `[module_resource_limits].module_socket_check_interval_millis`. |
| `BLVM_MODULE_SOCKET_MAX_ATTEMPTS` | `[module_resource_limits].module_socket_max_attempts`. |
| `BLVM_SIGNET_CHALLENGE` | `signet_challenge`, hex script bytes. |

`HOME` is read only to find `~/.config/blvm/blvm.toml`.

## File sketch

```toml
listen_addr = "0.0.0.0:8333"
rpc_addr = "127.0.0.1:8332"
protocol_version = "regtest"
max_peers = 100
transport_preference = "tcponly"
enable_self_advertisement = true
serve_compact_filters = false

[logging]
filter = "blvm=info,blvm_node=info"
json_format = false

[stratum_v2]
p2p_stratum_demux = true

[ban_list_sharing]
enabled = true
share_mode = "periodic"
periodic_interval_seconds = 300
min_ban_duration_to_share = 3600
```

`[payment]` in this file is ignored. `blvm-payment` reads `config.toml` in its own module directory. `[stratum_v2]` only switches P2P TLV demux. Miner TCP is `[modules.blvm-stratum-v2]`, not `[modules.stratum-v2]`.

A module file is `{modules.data_dir}/{manifest name}/config.toml`. `[modules.<manifest name>]` overrides only fields marked for the environment overlay.
