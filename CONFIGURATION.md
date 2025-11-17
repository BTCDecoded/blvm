# BLLVM Configuration Guide

## Overview

BLLVM supports multiple configuration methods with a clear hierarchy:

**Priority (highest to lowest):**
1. **CLI Arguments** - Always wins
2. **Environment Variables** - Override config file
3. **Config File** - Main configuration source
4. **Defaults** - Built-in defaults

## Configuration Methods

### 1. CLI Arguments

Common operations can be controlled via command-line flags:

```bash
# Basic usage
bllvm --network mainnet --data-dir /var/lib/bllvm

# With feature flags
bllvm --enable-stratum-v2 --enable-dandelion

# With config file
bllvm --config /etc/bllvm/bllvm.toml

# Override config file with CLI
bllvm --config /etc/bllvm/bllvm.toml --network testnet
```

**Available CLI flags:**
- `--network` - Network (regtest/testnet/mainnet)
- `--data-dir` - Data directory
- `--listen-addr` - P2P listen address
- `--rpc-addr` - RPC server address
- `--config` - Config file path
- `--verbose` - Enable verbose logging
- `--enable-stratum-v2` / `--disable-stratum-v2`
- `--enable-dandelion` / `--disable-dandelion`
- `--enable-bip158` / `--disable-bip158`
- `--enable-sigop` / `--disable-sigop`

### 2. Environment Variables

Environment variables are ideal for deployment scenarios, especially in containers:

```bash
# Deployment-critical settings
export BLLVM_DATA_DIR="/var/lib/bllvm"
export BLLVM_NETWORK="mainnet"
export BLLVM_LISTEN_ADDR="0.0.0.0:8333"
export BLLVM_RPC_ADDR="127.0.0.1:8332"
export BLLVM_LOG_LEVEL="info"

# Node settings
export BLLVM_NODE_MAX_PEERS="200"
export BLLVM_NODE_TRANSPORT="tcp_only"

# Feature flags
export BLLVM_NODE_FEATURES_STRATUM_V2="true"
export BLLVM_NODE_FEATURES_DANDELION="true"
export BLLVM_NODE_FEATURES_BIP158="true"
export BLLVM_NODE_FEATURES_SIGOP="true"

# Run node
bllvm
```

**Available Environment Variables:**

**Deployment-Critical:**
- `BLLVM_DATA_DIR` - Data directory
- `BLLVM_NETWORK` - Network (regtest/testnet/mainnet)
- `BLLVM_LISTEN_ADDR` - P2P listen address
- `BLLVM_RPC_ADDR` - RPC server address
- `BLLVM_LOG_LEVEL` - Logging level (trace/debug/info/warn/error)

**Node Settings:**
- `BLLVM_NODE_MAX_PEERS` - Maximum peer connections
- `BLLVM_NODE_TRANSPORT` - Transport preference (tcp_only/iroh_only/hybrid)

**Feature Flags:**
- `BLLVM_NODE_FEATURES_STRATUM_V2` - Enable/disable Stratum V2 (true/false)
- `BLLVM_NODE_FEATURES_DANDELION` - Enable/disable Dandelion++ (true/false)
- `BLLVM_NODE_FEATURES_BIP158` - Enable/disable BIP158 (true/false)
- `BLLVM_NODE_FEATURES_SIGOP` - Enable/disable Sigop counting (true/false)

### 3. Config File

Config files support complex nested configurations. Config files are searched in this order:

1. `--config` flag path (if specified)
2. `./bllvm.toml` (current directory)
3. `~/.config/bllvm/bllvm.toml` (user config)
4. `/etc/bllvm/bllvm.toml` (system config)

**Example config file (`bllvm.toml`):**

```toml
# Network listening address
listen_addr = "0.0.0.0:8333"

# Transport preference
transport_preference = "tcp_only"

# Maximum number of peers
max_peers = 100

# Protocol version
protocol_version = "Regtest"

# Enable self-advertisement
enable_self_advertisement = true

# Persistent peers
# persistent_peers = ["1.2.3.4:8333", "5.6.7.8:8333"]

# Stratum V2 mining configuration
# [stratum_v2]
# enabled = false
# pool_url = "tcp://pool.example.com:3333"
# listen_addr = "0.0.0.0:3333"
# transport_preference = "tcp_only"
# merge_mining_enabled = false
# secondary_chains = []

# RPC authentication
# [rpc_auth]
# required = false
# tokens = []
# certificates = []
# rate_limit_burst = 100
# rate_limit_rate = 10

# Ban list sharing
# [ban_list_sharing]
# enabled = false
# share_interval_seconds = 3600
# max_entries = 1000

# Storage and pruning
# [storage]
# backend = "redb"
# 
# [storage.pruning]
# enabled = false
# mode = "normal"
# min_blocks_to_keep = 288
# auto_prune = false
# auto_prune_interval = 3600

# Module system
# [modules]
# enabled = true
# modules_dir = "modules"
# data_dir = "data/modules"
# socket_dir = "data/modules/sockets"
# enabled_modules = []
```

## Configuration Hierarchy Examples

### Example 1: CLI Overrides Everything

```bash
# Config file has: network = "testnet"
# ENV has: BLLVM_NETWORK="mainnet"
# CLI: --network regtest

# Result: network = regtest (CLI wins)
bllvm --config bllvm.toml --network regtest
```

### Example 2: ENV Overrides Config File

```bash
# Config file has: max_peers = 50
# ENV has: BLLVM_NODE_MAX_PEERS="200"
# CLI: (not specified)

# Result: max_peers = 200 (ENV overrides config file)
export BLLVM_NODE_MAX_PEERS="200"
bllvm --config bllvm.toml
```

### Example 3: Config File Overrides Defaults

```bash
# Default: max_peers = 100
# Config file has: max_peers = 200
# ENV: (not set)
# CLI: (not specified)

# Result: max_peers = 200 (config file overrides default)
bllvm --config bllvm.toml
```

### Example 4: Feature Flags via ENV

```bash
# Enable features via environment variables
export BLLVM_NODE_FEATURES_STRATUM_V2="true"
export BLLVM_NODE_FEATURES_DANDELION="true"

# Run node (features enabled via ENV)
bllvm
```

## Deployment Examples

### Docker/Container Deployment

```bash
# Use environment variables for configuration
docker run -e BLLVM_NETWORK=mainnet \
           -e BLLVM_DATA_DIR=/data \
           -e BLLVM_LISTEN_ADDR=0.0.0.0:8333 \
           -e BLLVM_RPC_ADDR=0.0.0.0:8332 \
           -e BLLVM_NODE_MAX_PEERS=200 \
           bllvm:latest
```

### Systemd Service

```ini
[Service]
Environment="BLLVM_NETWORK=mainnet"
Environment="BLLVM_DATA_DIR=/var/lib/bllvm"
Environment="BLLVM_LISTEN_ADDR=0.0.0.0:8333"
Environment="BLLVM_RPC_ADDR=127.0.0.1:8332"
Environment="BLLVM_LOG_LEVEL=info"
ExecStart=/usr/bin/bllvm
```

### Development

```bash
# Use config file for development
bllvm --config ./bllvm.toml --network regtest --verbose
```

## Notes

- **CLI always wins**: Even if a value is set in ENV or config file, CLI arguments override everything
- **Feature flags**: Some features require compile-time flags (e.g., `--features stratum-v2`). Runtime flags will warn if feature isn't compiled in
- **Config file format**: Supports both TOML and JSON (auto-detected by file extension)
- **Secrets**: Never put secrets (API keys, passwords) in config files. Use environment variables instead

