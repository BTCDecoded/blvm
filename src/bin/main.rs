//! BLVM - Bitcoin Low-Level Virtual Machine Node
//!
//! Main entry point for the Bitcoin Commons BLVM node binary.
//! This binary starts a full Bitcoin node using the blvm-node library.

use anyhow::{Context, Result};
use blvm_node::ProtocolVersion;
use blvm_node::config::NodeConfig;
use blvm_node::node::Node as ReferenceNode;
use clap::{Parser, Subcommand, ValueEnum};
use serde_json::{Value, json};
use std::env;
use std::net::SocketAddr;
use std::path::{Path, PathBuf};
use std::sync::atomic::Ordering;
use std::time::Duration;
use tracing::{error, info, warn};

#[derive(Parser)]
#[command(name = "blvm")]
#[command(about = "Bitcoin Commons BLVM - Bitcoin Low-Level Virtual Machine Node", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Option<Command>,

    /// Network to connect to
    #[arg(short, long, value_enum)]
    network: Option<Network>,

    /// RPC server address (default depends on --network when omitted)
    #[arg(short, long)]
    rpc_addr: Option<SocketAddr>,

    /// P2P listen address (default depends on --network: 8333/18333/18444)
    #[arg(short, long)]
    listen_addr: Option<SocketAddr>,

    /// Data directory (CLI overrides ENV and config; default ./data when not specified)
    #[arg(short, long)]
    data_dir: Option<String>,

    /// Configuration file path (TOML or JSON)
    #[arg(short, long)]
    config: Option<PathBuf>,

    /// Enable verbose logging
    #[arg(short, long)]
    verbose: bool,

    /// Feature flags (runtime-configurable features)
    #[command(flatten)]
    features: FeatureFlags,

    /// Advanced configuration options
    #[command(flatten)]
    advanced: AdvancedConfig,

    /// Do not auto-migrate from a Bitcoin Core datadir on start
    #[arg(long)]
    no_auto_migrate: bool,

    /// BLVM store path when auto-migrating from Core (default: `<datadir>/blvm`)
    #[arg(long, value_name = "PATH")]
    migrate_destination: Option<String>,

    /// Migrate from Core datadir and exit without starting the node
    #[cfg(feature = "rocksdb")]
    #[arg(long)]
    migrate_core_only: bool,
}

#[derive(Subcommand)]
enum Command {
    /// Start the node (default)
    Start,
    /// Show comprehensive node status
    Status {
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Health check (exit code 0 if healthy)
    Health {
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Show version and build information
    Version,
    /// Show blockchain information
    Chain {
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Show connected peers
    Peers {
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Show network information
    Network {
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Show sync status
    Sync {
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Configuration management
    Config {
        #[command(subcommand)]
        subcommand: ConfigCommand,
    },
    /// Direct RPC call
    Rpc {
        /// RPC method name
        method: String,
        /// RPC parameters (JSON array)
        #[arg(default_value = "[]")]
        params: String,
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Module lifecycle (load, unload, reload, list)
    Module {
        #[command(subcommand)]
        subcommand: ModuleCommand,
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Migration and data conversion tools
    #[cfg(feature = "rocksdb")]
    Migrate {
        #[command(subcommand)]
        subcommand: MigrateCommand,
    },
    /// Print config file path for a module (works offline)
    ConfigPath {
        /// Module name (e.g. datum, stratum-v2, mesh)
        module: String,
    },
    /// Load a module at runtime (node must be running)
    Load {
        /// Module name
        module: String,
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Unload a module at runtime (node must be running)
    Unload {
        /// Module name
        module: String,
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Reload a module at runtime (node must be running)
    Reload {
        /// Module name
        module: String,
        /// RPC server address (overrides config)
        #[arg(long)]
        rpc_addr: Option<SocketAddr>,
    },
    /// Dynamic module commands (e.g. blvm sync-policy list) from getmoduleclispecs
    #[command(external_subcommand)]
    ModuleCli(Vec<String>),
}

#[cfg(feature = "rocksdb")]
#[derive(Subcommand)]
enum MigrateCommand {
    /// Migrate Bitcoin Core data directory to BLVM format
    Core {
        /// Bitcoin Core data directory (default: auto-detect)
        #[arg(short, long)]
        source: Option<String>,
        /// Destination directory for BLVM database
        #[arg(short, long, required = true)]
        destination: String,
        /// Network type (mainnet, testnet, regtest, signet)
        #[arg(short, long, default_value = "mainnet")]
        network: String,
        /// Verify migrated data
        #[arg(short, long)]
        verify: bool,
        /// Verbose output
        #[arg(short, long)]
        verbose: bool,
    },
}

#[derive(Subcommand)]
enum ModuleCommand {
    /// Load a module at runtime (hot load)
    Load {
        /// Module name
        name: String,
    },
    /// Unload a module at runtime (hot unload)
    Unload {
        /// Module name
        name: String,
    },
    /// Reload a module at runtime (hot reload)
    Reload {
        /// Module name
        name: String,
    },
    /// List loaded modules
    List,
}

#[derive(Subcommand)]
enum ConfigCommand {
    /// Show loaded configuration
    Show,
    /// Validate configuration file
    Validate {
        /// Configuration file path
        path: Option<PathBuf>,
    },
    /// Show configuration file path
    Path,
    /// Set config value(s). Use dotted keys for primary and module config.
    /// Examples: storage.data_dir=./data, modules.stratum-v2.listen_addr=0.0.0.1:3333
    Set {
        /// One or more key=value assignments
        #[arg(required = true, value_name = "KEY=VALUE")]
        assignments: Vec<String>,
    },
    /// Convert Bitcoin Core bitcoin.conf to blvm config.toml
    ConvertCore {
        /// Bitcoin Core config file (bitcoin.conf)
        input: PathBuf,
        /// Output path (default: config.toml)
        #[arg(default_value = "config.toml")]
        output: PathBuf,
        /// Verbose output
        #[arg(short, long)]
        verbose: bool,
    },
}

#[derive(Parser, Debug, Clone, Default)]
#[group(id = "features")]
struct FeatureFlags {
    /// Enable Stratum V2 mining (requires compile-time feature)
    #[arg(long)]
    enable_stratum_v2: bool,

    /// Enable BIP158 block filtering (requires compile-time feature)
    #[arg(long)]
    enable_bip158: bool,

    /// Enable Dandelion++ privacy relay (requires compile-time feature)
    #[arg(long)]
    enable_dandelion: bool,

    /// Enable signature operations counting (requires compile-time feature)
    #[arg(long)]
    enable_sigop: bool,

    /// Disable Stratum V2 mining
    #[arg(long)]
    disable_stratum_v2: bool,

    /// Disable BIP158 block filtering
    #[arg(long)]
    disable_bip158: bool,

    /// Disable Dandelion++ privacy relay
    #[arg(long)]
    disable_dandelion: bool,

    /// Disable signature operations counting
    #[arg(long)]
    disable_sigop: bool,
}

/// Advanced configuration options (CLI overrides)
#[derive(Parser, Debug, Clone, Default)]
#[group(id = "advanced")]
struct AdvancedConfig {
    /// Assume-valid: skip script verification for blocks before this height or block hash.
    /// Use -assumevalid=0 or -noassumevalid to disable.
    /// Value: decimal height (e.g. 700000) or 64-char block hash (hex).
    #[arg(long, value_name = "HEIGHT_OR_HASH")]
    assumevalid: Option<String>,

    /// Disable assume-valid (validate all blocks). Same as -assumevalid=0.
    #[arg(long)]
    noassumevalid: bool,

    /// AssumeUTXO: load UTXO snapshot at block hash for fast sync.
    /// Block hash must be 64 hex chars. Snapshot file must exist.
    #[arg(long, value_name = "BLOCKHASH")]
    assumeutxo: Option<String>,

    /// Target number of peers to connect to (default: 8)
    #[arg(long)]
    target_peer_count: Option<usize>,

    /// Async request timeout in seconds (default: 300)
    #[arg(long)]
    async_request_timeout: Option<u64>,

    /// Module max CPU usage percentage (default: 50)
    #[arg(long)]
    module_max_cpu_percent: Option<u32>,

    /// Module max memory in bytes (default: 536870912 = 512MB)
    #[arg(long)]
    module_max_memory_bytes: Option<u64>,
}

#[derive(Clone, Debug, ValueEnum)]
enum Network {
    /// Regression testing network (default, safe for development)
    Regtest,
    /// Bitcoin test network
    Testnet,
    /// Bitcoin signet (BIP325 test network)
    Signet,
    /// Bitcoin mainnet (use with caution)
    Mainnet,
}

impl From<Network> for ProtocolVersion {
    fn from(network: Network) -> Self {
        match network {
            Network::Regtest => ProtocolVersion::Regtest,
            Network::Signet => ProtocolVersion::Signet,
            Network::Testnet => ProtocolVersion::Testnet3,
            Network::Mainnet => ProtocolVersion::BitcoinV1,
        }
    }
}

#[tokio::main]
async fn main() -> Result<()> {
    let cli = Cli::parse();

    // Initialize tracing: RUST_LOG > BLVM_LOG_LEVEL > default (verbose ? debug : info)
    let default_filter = if cli.verbose {
        "blvm=debug,blvm_node=debug"
    } else {
        "blvm=info,blvm_node=info"
    };
    let filter = match tracing_subscriber::EnvFilter::try_from_default_env() {
        Ok(f) => f,
        Err(_) => {
            if let Ok(level) = env::var("BLVM_LOG_LEVEL") {
                if let Ok(f) = tracing_subscriber::EnvFilter::try_new(&level) {
                    f
                } else {
                    tracing_subscriber::EnvFilter::new(default_filter)
                }
            } else {
                tracing_subscriber::EnvFilter::new(default_filter)
            }
        }
    };

    tracing_subscriber::fmt().with_env_filter(filter).init();

    // Handle subcommands
    match cli.command {
        Some(Command::Status { rpc_addr }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_status(rpc_addr, &config).await
        }
        Some(Command::Health { rpc_addr }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_health(rpc_addr, &config).await
        }
        Some(Command::Version) => handle_version(),
        Some(Command::Chain { rpc_addr }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_chain(rpc_addr, &config).await
        }
        Some(Command::Peers { rpc_addr }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_peers(rpc_addr, &config).await
        }
        Some(Command::Network { rpc_addr }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_network(rpc_addr, &config).await
        }
        Some(Command::Sync { rpc_addr }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_sync(rpc_addr, &config).await
        }
        Some(Command::Config { ref subcommand }) => {
            let (config, _, _, _, _) = build_final_config(&cli)?;
            match subcommand {
                ConfigCommand::Show => handle_config_show(&config),
                ConfigCommand::Validate { path } => {
                    handle_config_validate(path.clone(), &cli.config)
                }
                ConfigCommand::Path => handle_config_path(&cli.config),
                ConfigCommand::Set { assignments } => handle_config_set(&cli.config, assignments),
                ConfigCommand::ConvertCore {
                    input,
                    output,
                    verbose,
                } => {
                    blvm_node::cli::run_config_convert_core(input, output, *verbose)?;
                    Ok(())
                }
            }
        }
        #[cfg(feature = "rocksdb")]
        Some(Command::Migrate { ref subcommand }) => match subcommand {
            MigrateCommand::Core {
                source,
                destination,
                network,
                verify,
                verbose,
            } => {
                use blvm_node::storage::bitcoin_detection::CoreDataNetwork;
                let network_parsed: CoreDataNetwork = network
                    .parse()
                    .map_err(|e: String| anyhow::anyhow!("Invalid network: {}", e))?;
                let source_path = source.as_ref().map(std::path::PathBuf::from);
                blvm_node::cli::run_migrate_core_cli(
                    source_path,
                    std::path::PathBuf::from(destination),
                    network_parsed,
                    *verify,
                    *verbose,
                )?;
                Ok(())
            }
        },
        Some(Command::Rpc {
            ref method,
            ref params,
            rpc_addr,
        }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            let params: Value = serde_json::from_str(params).context("Invalid JSON parameters")?;
            handle_rpc(rpc_addr, method, params, &config).await
        }
        Some(Command::Module {
            ref subcommand,
            rpc_addr,
        }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_module(rpc_addr, subcommand, &config).await
        }
        Some(Command::ConfigPath { ref module }) => {
            let (config, data_dir, _, _, _) = build_final_config(&cli)?;
            handle_module_config_path(module, &config, &data_dir)
        }
        Some(Command::Load {
            ref module,
            rpc_addr,
        }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_module(
                rpc_addr,
                &ModuleCommand::Load {
                    name: module.clone(),
                },
                &config,
            )
            .await
        }
        Some(Command::Unload {
            ref module,
            rpc_addr,
        }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_module(
                rpc_addr,
                &ModuleCommand::Unload {
                    name: module.clone(),
                },
                &config,
            )
            .await
        }
        Some(Command::Reload {
            ref module,
            rpc_addr,
        }) => {
            let (config, _, _, resolved_rpc, _) = build_final_config(&cli)?;
            let rpc_addr = rpc_addr.unwrap_or(resolved_rpc);
            handle_module(
                rpc_addr,
                &ModuleCommand::Reload {
                    name: module.clone(),
                },
                &config,
            )
            .await
        }
        Some(Command::ModuleCli(ref args)) => {
            let (config, _, _, rpc_addr, _) = build_final_config(&cli)?;
            handle_module_cli(rpc_addr, args, &config).await
        }
        None | Some(Command::Start) => {
            // Start node (default behavior)
            let (mut config, data_dir, listen_addr, rpc_addr, network) = build_final_config(&cli)?;

            #[cfg(feature = "rocksdb")]
            if cli.migrate_core_only {
                use blvm_node::storage::Storage;
                if !blvm_node::storage::bitcoin_detection::BitcoinCoreDetection::is_core_layout_at(
                    std::path::Path::new(&data_dir),
                ) {
                    anyhow::bail!(
                        "--migrate-core-only requires a Bitcoin Core datadir at {}",
                        data_dir
                    );
                }
                if let Some(storage) = config.storage.as_mut() {
                    storage.auto_migrate_core = true;
                } else {
                    config.storage = Some(blvm_node::config::StorageConfig {
                        auto_migrate_core: true,
                        ..Default::default()
                    });
                }
                let protocol_version: ProtocolVersion = network.into();
                let store = Storage::prepare_node_store_from_protocol(
                    &data_dir,
                    protocol_version,
                    config.storage.as_ref(),
                )?;
                info!("Core migration complete. BLVM store at {}", store.display());
                return Ok(());
            }

            info!("Starting Bitcoin Commons BLVM Node");
            info!("Network: {:?}", network);
            info!("RPC address: {}", rpc_addr);
            info!("P2P listen address: {}", listen_addr);
            info!("Data directory: {}", data_dir);

            unsafe {
                std::env::set_var("DATA_DIR", &data_dir);
            }

            let protocol_version: ProtocolVersion = network.into();
            let mut node = match ReferenceNode::with_storage_config(
                &data_dir,
                listen_addr,
                rpc_addr,
                Some(protocol_version),
                config.storage.as_ref(),
            ) {
                Ok(node) => node,
                Err(e) => {
                    error!("Failed to create node: {}", e);
                    return Err(e);
                }
            };

            node = node
                .with_config(config.clone())
                .map_err(|e| anyhow::anyhow!("Failed to apply config: {}", e))?;

            #[cfg(feature = "wasm-modules")]
            {
                node = node.with_wasm_loader(std::sync::Arc::new(blvm_sdk::BlvmSdkWasmLoader));
            }

            // with_modules_from_config takes ownership, so we need to handle it carefully
            node = match node.with_modules_from_config(&config) {
                Ok(n) => n,
                Err(e) => {
                    warn!(
                        "Failed to configure modules: {}. Continuing without modules.",
                        e
                    );
                    // If it fails, we can't recover the node since with_modules_from_config consumes it
                    // We need to return an error - the node has been consumed
                    return Err(anyhow::anyhow!("Failed to configure modules: {}", e));
                }
            };

            // Pin the node future so we can poll it again after a signal without
            // dropping it (dropping would orphan the IBD validation thread and skip the
            // final watermark flush).
            let mut node_fut = std::pin::pin!(node.start());
            let mut shutdown_initiated = false;

            loop {
                if shutdown_initiated {
                    // Signal received: give the IBD loop up to 60 s to drain in-flight
                    // work and persist the watermark checkpoint, then force-exit.
                    match tokio::time::timeout(Duration::from_secs(60), &mut node_fut).await {
                        Ok(Ok(())) => {}
                        Ok(Err(e)) => {
                            // IBD_STOP_REQUESTED causes the validation loop to exit before
                            // reaching `effective_end_height`; that surfaces as an error
                            // with the word "shutdown" or "disconnected".  Treat it as a
                            // clean stop rather than a hard failure.
                            let msg = e.to_string();
                            if msg.contains("shutdown")
                                || msg.contains("disconnected")
                                || msg.contains("Graceful")
                            {
                                info!("Node exited cleanly after shutdown signal");
                            } else {
                                error!("Node error after shutdown: {}", e);
                            }
                        }
                        Err(_elapsed) => {
                            warn!("Graceful IBD shutdown timed out after 60 s — forcing exit");
                        }
                    }
                    break;
                }

                tokio::select! {
                    result = &mut node_fut => {
                        if let Err(e) = result {
                            error!("Node error: {}", e);
                            return Err(e);
                        }
                        break;
                    }
                    _ = blvm_node::utils::wait_for_shutdown_signal() => {
                        info!("Shutdown signal received — waiting for IBD to flush watermark…");
                        blvm_node::node::parallel_ibd::IBD_SHUTDOWN_REQUESTED
                            .store(true, Ordering::Release);
                        shutdown_initiated = true;
                        // Loop again: poll node_fut with a timeout instead of dropping it.
                    }
                }
            }

            Ok(())
        }
    }
}

/// Environment variable overrides
#[derive(Debug, Clone, Default)]
struct EnvOverrides {
    data_dir: Option<String>,
    network: Option<String>,
    listen_addr: Option<SocketAddr>,
    rpc_addr: Option<SocketAddr>,
    max_peers: Option<usize>,
    transport: Option<String>,
    // Feature flags
    stratum_v2: Option<bool>,
    dandelion: Option<bool>,
    bip158: Option<bool>,
    sigop: Option<bool>,
    // Network timing config
    target_peer_count: Option<usize>,
    peer_connection_delay: Option<u64>,
    max_addresses_from_dns: Option<usize>,
    // Request timeout config
    async_request_timeout: Option<u64>,
    utxo_commitment_timeout: Option<u64>,
    request_cleanup_interval: Option<u64>,
    pending_request_max_age: Option<u64>,
    // Module resource limits config
    module_max_cpu_percent: Option<u32>,
    module_max_memory_bytes: Option<u64>,
    module_max_file_descriptors: Option<u32>,
    module_max_child_processes: Option<u32>,
    module_startup_wait_millis: Option<u64>,
    module_socket_timeout: Option<u64>,
    module_socket_check_interval: Option<u64>,
    module_socket_max_attempts: Option<usize>,
    /// BIP325 signet challenge script override (hex)
    signet_challenge: Option<String>,
}

impl EnvOverrides {
    /// Load configuration from environment variables
    fn from_env() -> Self {
        Self {
            data_dir: env::var("BLVM_DATA_DIR").ok(),
            network: env::var("BLVM_NETWORK").ok(),
            listen_addr: env::var("BLVM_LISTEN_ADDR")
                .ok()
                .and_then(|s| s.parse().ok()),
            rpc_addr: env::var("BLVM_RPC_ADDR").ok().and_then(|s| s.parse().ok()),
            max_peers: env::var("BLVM_NODE_MAX_PEERS")
                .ok()
                .and_then(|s| s.parse().ok()),
            transport: env::var("BLVM_NODE_TRANSPORT").ok(),
            // Feature flags
            stratum_v2: env::var("BLVM_NODE_FEATURES_STRATUM_V2")
                .ok()
                .and_then(|s| s.parse().ok()),
            dandelion: env::var("BLVM_NODE_FEATURES_DANDELION")
                .ok()
                .and_then(|s| s.parse().ok()),
            bip158: env::var("BLVM_NODE_FEATURES_BIP158")
                .ok()
                .and_then(|s| s.parse().ok()),
            sigop: env::var("BLVM_NODE_FEATURES_SIGOP")
                .ok()
                .and_then(|s| s.parse().ok()),
            // Network timing config
            target_peer_count: env::var("BLVM_NETWORK_TARGET_PEER_COUNT")
                .ok()
                .and_then(|s| s.parse().ok()),
            peer_connection_delay: env::var("BLVM_NETWORK_PEER_CONNECTION_DELAY")
                .ok()
                .and_then(|s| s.parse().ok()),
            max_addresses_from_dns: env::var("BLVM_NETWORK_MAX_ADDRESSES_FROM_DNS")
                .ok()
                .and_then(|s| s.parse().ok()),
            // Request timeout config
            async_request_timeout: env::var("BLVM_REQUEST_ASYNC_TIMEOUT")
                .ok()
                .and_then(|s| s.parse().ok()),
            utxo_commitment_timeout: env::var("BLVM_REQUEST_UTXO_COMMITMENT_TIMEOUT")
                .ok()
                .and_then(|s| s.parse().ok()),
            request_cleanup_interval: env::var("BLVM_REQUEST_CLEANUP_INTERVAL")
                .ok()
                .and_then(|s| s.parse().ok()),
            pending_request_max_age: env::var("BLVM_REQUEST_PENDING_MAX_AGE")
                .ok()
                .and_then(|s| s.parse().ok()),
            // Module resource limits config
            module_max_cpu_percent: env::var("BLVM_MODULE_MAX_CPU_PERCENT")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_max_memory_bytes: env::var("BLVM_MODULE_MAX_MEMORY_BYTES")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_max_file_descriptors: env::var("BLVM_MODULE_MAX_FILE_DESCRIPTORS")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_max_child_processes: env::var("BLVM_MODULE_MAX_CHILD_PROCESSES")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_startup_wait_millis: env::var("BLVM_MODULE_STARTUP_WAIT_MILLIS")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_socket_timeout: env::var("BLVM_MODULE_SOCKET_TIMEOUT")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_socket_check_interval: env::var("BLVM_MODULE_SOCKET_CHECK_INTERVAL")
                .ok()
                .and_then(|s| s.parse().ok()),
            module_socket_max_attempts: env::var("BLVM_MODULE_SOCKET_MAX_ATTEMPTS")
                .ok()
                .and_then(|s| s.parse().ok()),
            signet_challenge: env::var("BLVM_SIGNET_CHALLENGE").ok(),
        }
    }
}

/// Find config file in standard locations
fn find_config_file(cli_config: &Option<PathBuf>) -> Option<PathBuf> {
    // 1. CLI-specified config file (highest priority)
    if let Some(path) = cli_config {
        if path.exists() {
            return Some(path.clone());
        }
    }

    // 2. Current directory
    let current_dir = Path::new("./blvm.toml");
    if current_dir.exists() {
        return Some(current_dir.to_path_buf());
    }

    // 3. User config directory
    if let Ok(home) = env::var("HOME") {
        let user_config = Path::new(&home).join(".config/blvm/blvm.toml");
        if user_config.exists() {
            return Some(user_config);
        }
    }

    // 4. System config directory
    let system_config = Path::new("/etc/blvm/blvm.toml");
    if system_config.exists() {
        return Some(system_config.to_path_buf());
    }

    None
}

/// Build final configuration with hierarchy: CLI > ENV > Config > Defaults
fn network_from_cli_enum(network: &Network) -> &'static str {
    match network {
        Network::Mainnet => "mainnet",
        Network::Testnet => "testnet",
        Network::Regtest => "regtest",
        Network::Signet => "signet",
    }
}

fn network_from_str(s: &str) -> Option<Network> {
    match blvm::canonical_network_name(s)? {
        "mainnet" => Some(Network::Mainnet),
        "testnet" => Some(Network::Testnet),
        "signet" => Some(Network::Signet),
        "regtest" => Some(Network::Regtest),
        _ => None,
    }
}

/// Derive a Network from a loaded NodeConfig's `protocol_version`, defaulting to Regtest.
fn network_from_config_or_default(config: &NodeConfig) -> Network {
    config
        .protocol_version
        .as_deref()
        .and_then(network_from_str)
        .unwrap_or(Network::Regtest)
}

fn build_final_config(cli: &Cli) -> Result<(NodeConfig, String, SocketAddr, SocketAddr, Network)> {
    // 1. Start with defaults
    let mut config = NodeConfig::default();
    let mut config_loaded_from_file = false;

    // 2. Load config file (if found)
    if let Some(config_path) = find_config_file(&cli.config) {
        info!("Loading configuration from: {}", config_path.display());
        match NodeConfig::from_file(&config_path) {
            Ok(file_config) => {
                info!("Configuration loaded successfully from file");
                config = file_config; // Config file overrides defaults
                config_loaded_from_file = true;
            }
            Err(e) => {
                warn!("Failed to load config file: {}. Using defaults.", e);
            }
        }
    } else if cli.config.is_some() {
        warn!("Config file specified but not found. Using defaults.");
    }

    // 3. Load ENV overrides
    let env_overrides = EnvOverrides::from_env();

    // Apply ENV overrides (ENV overrides config file)
    if let Some(data_dir) = &env_overrides.data_dir {
        info!("Data directory overridden by ENV: {}", data_dir);
    }
    if let Some(network) = &env_overrides.network {
        info!("Network overridden by ENV: {}", network);
        // Will be handled below
    }
    if let Some(listen_addr) = env_overrides.listen_addr {
        info!("Listen address overridden by ENV: {}", listen_addr);
        config.listen_addr = Some(listen_addr);
    }
    if let Some(rpc_addr) = env_overrides.rpc_addr {
        info!("RPC address overridden by ENV: {}", rpc_addr);
    }
    if let Some(max_peers) = env_overrides.max_peers {
        info!("Max peers overridden by ENV: {}", max_peers);
        config.max_outbound_peers = Some(max_peers);
    }
    if let Some(transport) = &env_overrides.transport {
        info!("Transport overridden by ENV: {}", transport);
        // Parse transport preference
        match transport.to_lowercase().as_str() {
            "tcp_only" | "tcp" => {
                config.transport_preference = blvm_node::config::TransportPreferenceConfig::TcpOnly;
            }
            #[cfg(feature = "iroh")]
            "iroh_only" | "iroh" => {
                config.transport_preference =
                    blvm_node::config::TransportPreferenceConfig::IrohOnly;
            }
            #[cfg(feature = "iroh")]
            "hybrid" => {
                config.transport_preference = blvm_node::config::TransportPreferenceConfig::Hybrid;
            }
            _ => {
                warn!(
                    "Unknown transport preference: {}. Using default.",
                    transport
                );
            }
        }
    }

    // Apply ENV feature flags
    apply_env_feature_flags(&mut config, &env_overrides);

    // Apply ENV overrides for new config options
    apply_env_config_overrides(&mut config, &env_overrides);

    // 4. Determine final values — precedence: CLI explicit > ENV > config file > built-in default

    // Network: CLI explicit → BLVM_NETWORK env → config file protocol_version → regtest
    let network = if let Some(ref cli_net) = cli.network {
        cli_net.clone()
    } else if let Some(network_str) = &env_overrides.network {
        match network_from_str(network_str) {
            Some(net) => net,
            None => {
                warn!(
                    "Unknown network in BLVM_NETWORK: '{}'. Falling back to config/default.",
                    network_str
                );
                network_from_config_or_default(&config)
            }
        }
    } else if config_loaded_from_file {
        network_from_config_or_default(&config)
    } else {
        Network::Regtest
    };

    // data_dir: CLI > ENV > config.storage.data_dir > default
    let data_dir = cli
        .data_dir
        .clone()
        .or_else(|| env_overrides.data_dir.clone())
        .or_else(|| config.storage.as_ref().map(|s| s.data_dir.clone()))
        .unwrap_or_else(|| "./data".to_string());

    // listen_addr: CLI → ENV → config file (if loaded) → network-aware default
    let default_listen_port = blvm::default_p2p_port_for_network(network_from_cli_enum(&network));
    let listen_addr = cli
        .listen_addr
        .or(env_overrides.listen_addr)
        .or(if config_loaded_from_file {
            config.listen_addr
        } else {
            None
        })
        .unwrap_or_else(|| SocketAddr::from(([0, 0, 0, 0], default_listen_port)));

    let rpc_addr = cli
        .rpc_addr
        .or(env_overrides.rpc_addr)
        .unwrap_or_else(|| blvm::default_rpc_addr_for_network(network_from_cli_enum(&network)));

    // Apply resolved values to config so downstream code reads them from one place
    config.listen_addr = Some(listen_addr);
    config.protocol_version = Some(network_from_cli_enum(&network).to_string());

    // Apply CLI feature flags (CLI overrides ENV and config file)
    apply_feature_flags(&mut config, &cli.features);

    // Apply CLI advanced config (CLI overrides everything)
    apply_cli_advanced_config(&mut config, &cli.advanced);

    apply_cli_core_migrate_config(&mut config, cli);

    // Per-network default assume-valid when block_validation is None and not regtest
    if config.block_validation.is_none() {
        let default_height = blvm_node::config::default_assume_valid_height_for_network(
            network_from_cli_enum(&network),
        );
        if default_height > 0 {
            config.block_validation = Some(blvm_node::config::BlockValidationNodeConfig {
                assume_valid_height: default_height,
                assume_valid_hash: None,
            });
            info!(
                "Assume-valid config seed for {:?}: height {} (superseded by BLVM_ASSUME_VALID_HEIGHT / node merge when set)",
                network, default_height
            );
        }
    }

    // Validate config before returning (semantic checks: pruning, etc.)
    config.validate().context("Invalid configuration")?;

    Ok((config, data_dir, listen_addr, rpc_addr, network))
}

/// Apply feature flags from environment variables
#[allow(unused_variables)]
fn apply_env_feature_flags(config: &mut NodeConfig, env: &EnvOverrides) {
    // Stratum V2
    if let Some(enabled) = env.stratum_v2 {
        #[cfg(feature = "stratum-v2")]
        {
            if config.stratum_v2.is_none() {
                config.stratum_v2 = Some(Default::default());
            }
            if let Some(ref mut sv2) = config.stratum_v2 {
                sv2.enabled = enabled;
            }
            info!(
                "Stratum V2 {} via ENV",
                if enabled { "enabled" } else { "disabled" }
            );
        }
        #[cfg(not(feature = "stratum-v2"))]
        {
            if enabled {
                warn!(
                    "Stratum V2 feature not compiled in. Rebuild with --features stratum-v2 to enable."
                );
            }
        }
    }

    // Dandelion
    if let Some(enabled) = env.dandelion {
        #[cfg(feature = "dandelion")]
        {
            info!(
                "Dandelion++ {} via ENV",
                if enabled { "enabled" } else { "disabled" }
            );
            // Dandelion may be controlled via relay policies in NodeConfig
        }
        #[cfg(not(feature = "dandelion"))]
        {
            if enabled {
                warn!(
                    "Dandelion++ feature not compiled in. Rebuild with --features dandelion to enable."
                );
            }
        }
    }

    // BIP158 (compact block filters; always compiled in, like Bitcoin Core)
    if let Some(enabled) = env.bip158 {
        info!(
            "BIP158 block filtering {} via ENV",
            if enabled { "enabled" } else { "disabled" }
        );
    }

    // Sigop
    if let Some(enabled) = env.sigop {
        #[cfg(feature = "sigop")]
        {
            info!(
                "Signature operations counting {} via ENV",
                if enabled { "enabled" } else { "disabled" }
            );
        }
        #[cfg(not(feature = "sigop"))]
        {
            if enabled {
                warn!("Sigop feature not compiled in. Rebuild with --features sigop to enable.");
            }
        }
    }
}

/// Apply feature flags from CLI to config
#[allow(unused_variables)]
fn apply_feature_flags(config: &mut NodeConfig, features: &FeatureFlags) {
    // Stratum V2
    if features.enable_stratum_v2 || features.disable_stratum_v2 {
        #[cfg(feature = "stratum-v2")]
        {
            if features.enable_stratum_v2 {
                if config.stratum_v2.is_none() {
                    config.stratum_v2 = Some(Default::default());
                }
                if let Some(ref mut sv2) = config.stratum_v2 {
                    sv2.enabled = true;
                }
                info!("Stratum V2 enabled via CLI");
            }
            if features.disable_stratum_v2 {
                if let Some(ref mut sv2) = config.stratum_v2 {
                    sv2.enabled = false;
                }
                info!("Stratum V2 disabled via CLI");
            }
        }
        #[cfg(not(feature = "stratum-v2"))]
        {
            warn!(
                "Stratum V2 feature not compiled in. Rebuild with --features stratum-v2 to enable."
            );
        }
    }

    // Note: Dandelion and sigop may still be compile-time gated; BIP158 is always on.
    // through the node's runtime configuration rather than NodeConfig.
    // These features are typically controlled at compile-time via Cargo features,
    // but some may have runtime toggles. Check the node implementation for details.

    if features.enable_bip158 || features.disable_bip158 {
        info!(
            "BIP158 block filtering {} via CLI",
            if features.enable_bip158 {
                "enabled"
            } else {
                "disabled"
            }
        );
    }

    if features.enable_dandelion || features.disable_dandelion {
        #[cfg(feature = "dandelion")]
        {
            info!(
                "Dandelion++ privacy relay {} via CLI",
                if features.enable_dandelion {
                    "enabled"
                } else {
                    "disabled"
                }
            );
            // Dandelion may be controlled via relay policies in NodeConfig
        }
        #[cfg(not(feature = "dandelion"))]
        {
            warn!(
                "Dandelion++ feature not compiled in. Rebuild with --features dandelion to enable."
            );
        }
    }

    if features.enable_sigop || features.disable_sigop {
        #[cfg(feature = "sigop")]
        {
            info!(
                "Signature operations counting {} via CLI",
                if features.enable_sigop {
                    "enabled"
                } else {
                    "disabled"
                }
            );
        }
        #[cfg(not(feature = "sigop"))]
        {
            warn!("Sigop feature not compiled in. Rebuild with --features sigop to enable.");
        }
    }
}

/// Apply environment config overrides (non-feature flags)
/// ENV overrides config file; values are written to config for downstream use.
fn apply_env_config_overrides(config: &mut NodeConfig, env: &EnvOverrides) {
    if let Some(ref challenge) = env.signet_challenge {
        info!("Signet challenge overridden by ENV");
        config.signet_challenge = Some(challenge.clone());
    }

    // Network timing config
    if env.target_peer_count.is_some()
        || env.peer_connection_delay.is_some()
        || env.max_addresses_from_dns.is_some()
    {
        let timing = config
            .network_timing
            .get_or_insert_with(blvm_node::config::NetworkTimingConfig::default);
        if let Some(v) = env.target_peer_count {
            info!("Target peer count overridden by ENV: {}", v);
            timing.target_outbound_peers = v;
        }
        if let Some(v) = env.peer_connection_delay {
            info!("Peer connection delay overridden by ENV: {}", v);
            timing.peer_connection_delay_seconds = v;
        }
        if let Some(v) = env.max_addresses_from_dns {
            info!("Max addresses from DNS overridden by ENV: {}", v);
            timing.max_addresses_from_dns = v;
        }
    }

    // Request timeout config
    if env.async_request_timeout.is_some()
        || env.utxo_commitment_timeout.is_some()
        || env.request_cleanup_interval.is_some()
        || env.pending_request_max_age.is_some()
    {
        let timeouts = config
            .request_timeouts
            .get_or_insert_with(blvm_node::config::RequestTimeoutConfig::default);
        if let Some(v) = env.async_request_timeout {
            info!("Async request timeout overridden by ENV: {}", v);
            timeouts.async_request_timeout_seconds = v;
        }
        if let Some(v) = env.utxo_commitment_timeout {
            info!("UTXO commitment timeout overridden by ENV: {}", v);
            timeouts.utxo_commitment_request_timeout_seconds = v;
        }
        if let Some(v) = env.request_cleanup_interval {
            info!("Request cleanup interval overridden by ENV: {}", v);
            timeouts.request_cleanup_interval_seconds = v;
        }
        if let Some(v) = env.pending_request_max_age {
            info!("Pending request max age overridden by ENV: {}", v);
            timeouts.pending_request_max_age_seconds = v;
        }
    }

    // Module resource limits config
    if env.module_max_cpu_percent.is_some()
        || env.module_max_memory_bytes.is_some()
        || env.module_max_file_descriptors.is_some()
        || env.module_max_child_processes.is_some()
        || env.module_startup_wait_millis.is_some()
        || env.module_socket_timeout.is_some()
        || env.module_socket_check_interval.is_some()
        || env.module_socket_max_attempts.is_some()
    {
        let limits = config
            .module_resource_limits
            .get_or_insert_with(blvm_node::config::ModuleResourceLimitsConfig::default);
        if let Some(v) = env.module_max_cpu_percent {
            info!("Module max CPU percent overridden by ENV: {}", v);
            limits.default_max_cpu_percent = v;
        }
        if let Some(v) = env.module_max_memory_bytes {
            info!("Module max memory bytes overridden by ENV: {}", v);
            limits.default_max_memory_bytes = v;
        }
        if let Some(v) = env.module_max_file_descriptors {
            info!("Module max file descriptors overridden by ENV: {}", v);
            limits.default_max_file_descriptors = v;
        }
        if let Some(v) = env.module_max_child_processes {
            info!("Module max child processes overridden by ENV: {}", v);
            limits.default_max_child_processes = v;
        }
        if let Some(v) = env.module_startup_wait_millis {
            info!("Module startup wait millis overridden by ENV: {}", v);
            limits.module_startup_wait_millis = v;
        }
        if let Some(v) = env.module_socket_timeout {
            info!("Module socket timeout overridden by ENV: {}", v);
            limits.module_socket_timeout_seconds = v;
        }
        if let Some(v) = env.module_socket_check_interval {
            info!("Module socket check interval overridden by ENV: {}", v);
            limits.module_socket_check_interval_millis = v;
        }
        if let Some(v) = env.module_socket_max_attempts {
            info!("Module socket max attempts overridden by ENV: {}", v);
            limits.module_socket_max_attempts = v;
        }
    }
}

/// Apply CLI Core migration options into storage config.
fn apply_cli_core_migrate_config(config: &mut NodeConfig, cli: &Cli) {
    if !cli.no_auto_migrate && cli.migrate_destination.is_none() {
        return;
    }
    let storage = config
        .storage
        .get_or_insert_with(blvm_node::config::StorageConfig::default);
    if cli.no_auto_migrate {
        info!("Core auto-migrate disabled via --no-auto-migrate");
        storage.auto_migrate_core = false;
    }
    if let Some(ref dest) = cli.migrate_destination {
        info!("Core migrate destination set via CLI: {}", dest);
        storage.core_migrate_destination = Some(dest.clone());
    }
}

/// Apply CLI advanced config options
fn apply_cli_advanced_config(config: &mut NodeConfig, advanced: &AdvancedConfig) {
    // Assume-valid: CLI overrides config file (Option A: height or hash)
    if advanced.noassumevalid || advanced.assumevalid.as_deref() == Some("0") {
        config.block_validation = Some(blvm_node::config::BlockValidationNodeConfig {
            assume_valid_height: 0,
            assume_valid_hash: None,
        });
    } else if let Some(ref val) = advanced.assumevalid {
        let is_hex_hash = val.len() == 64 && val.chars().all(|c| c.is_ascii_hexdigit());
        if is_hex_hash {
            // Parse 64-char hex to [u8; 32] for hash-based ancestry verification.
            if let Ok(hash_bytes) = hex::decode(val) {
                if hash_bytes.len() == 32 {
                    let mut arr = [0u8; 32];
                    arr.copy_from_slice(&hash_bytes);
                    config.block_validation = Some(blvm_node::config::BlockValidationNodeConfig {
                        assume_valid_height: 0, // Hash takes precedence
                        assume_valid_hash: Some(arr),
                    });
                } else {
                    tracing::warn!("Invalid -assumevalid hash length. Use 64 hex chars.");
                }
            } else {
                tracing::warn!("Invalid -assumevalid hash hex. Use 64 hex chars.");
            }
        } else if let Ok(height) = val.parse::<u64>() {
            config.block_validation = Some(blvm_node::config::BlockValidationNodeConfig {
                assume_valid_height: height,
                assume_valid_hash: None,
            });
        } else {
            tracing::warn!(
                "Invalid -assumevalid value '{}'. Use height (e.g. 700000) or 64-char block hash.",
                val
            );
        }
    }

    // AssumeUTXO: -assumeutxo=<64-char block hash>
    if let Some(ref val) = advanced.assumeutxo {
        if val.len() == 64 && val.chars().all(|c| c.is_ascii_hexdigit()) {
            if let Ok(hash_bytes) = hex::decode(val) {
                if hash_bytes.len() == 32 {
                    let mut arr = [0u8; 32];
                    arr.copy_from_slice(&hash_bytes);
                    config.assumeutxo_blockhash = Some(arr);
                    info!(
                        "AssumeUTXO: will attempt to load snapshot at block hash {}",
                        val
                    );
                }
            }
        } else {
            tracing::warn!(
                "Invalid -assumeutxo: use 64 hex chars (block hash). Got: {}",
                val
            );
        }
    }

    // CLI overrides config file and ENV for these options
    if let Some(v) = advanced.target_peer_count {
        info!("Target peer count set via CLI: {}", v);
        let timing = config
            .network_timing
            .get_or_insert_with(blvm_node::config::NetworkTimingConfig::default);
        timing.target_outbound_peers = v;
    }
    if let Some(v) = advanced.async_request_timeout {
        info!("Async request timeout set via CLI: {}", v);
        let timeouts = config
            .request_timeouts
            .get_or_insert_with(blvm_node::config::RequestTimeoutConfig::default);
        timeouts.async_request_timeout_seconds = v;
    }
    if advanced.module_max_cpu_percent.is_some() || advanced.module_max_memory_bytes.is_some() {
        let limits = config
            .module_resource_limits
            .get_or_insert_with(blvm_node::config::ModuleResourceLimitsConfig::default);
        if let Some(v) = advanced.module_max_cpu_percent {
            info!("Module max CPU percent set via CLI: {}", v);
            limits.default_max_cpu_percent = v;
        }
        if let Some(v) = advanced.module_max_memory_bytes {
            info!("Module max memory bytes set via CLI: {}", v);
            limits.default_max_memory_bytes = v;
        }
    }
}

// RPC client helper

fn rpc_connect_failure_hint(rpc_addr: SocketAddr) -> String {
    match rpc_addr.port() {
        18332 => format!(
            "\nHint: CLI default RPC is regtest ({rpc_addr}). For mainnet use --network mainnet (repeat --config if you started with one), or --rpc-addr 127.0.0.1:8332"
        ),
        8332 => format!(
            "\nHint: is the mainnet node running on {rpc_addr}? Start it first with blvm --network mainnet --config …"
        ),
        _ => String::new(),
    }
}

async fn rpc_call(rpc_addr: SocketAddr, method: &str, params: Value) -> Result<Value> {
    rpc_call_with_auth(rpc_addr, method, params, None, None).await
}

/// JSON-RPC to a running node using credentials from the loaded `blvm.toml` (`[rpc_auth]`).
async fn rpc_call_with_config(
    rpc_addr: SocketAddr,
    config: &NodeConfig,
    method: &str,
    params: Value,
) -> Result<Value> {
    if let Some(auth) = &config.rpc_auth {
        if let Some(token) = auth.admin_tokens.first() {
            return rpc_call_with_bearer(rpc_addr, method, params, token).await;
        }
        if let Some(token) = auth.tokens.first() {
            return rpc_call_with_bearer(rpc_addr, method, params, token).await;
        }
        if let Some(ref password) = auth.password {
            let user = auth.username.as_deref().unwrap_or("btc");
            return rpc_call_with_auth(
                rpc_addr,
                method,
                params,
                Some(user),
                Some(password.as_str()),
            )
            .await;
        }
        if auth.required {
            anyhow::bail!(
                "RPC authentication required: set [rpc_auth].admin_tokens, tokens, or password in the same config file used with --config"
            );
        }
    }
    rpc_call(rpc_addr, method, params).await
}

async fn rpc_call_with_bearer(
    rpc_addr: SocketAddr,
    method: &str,
    params: Value,
    token: &str,
) -> Result<Value> {
    let url = format!("http://{rpc_addr}");
    let client = reqwest::Client::new();
    let request = json!({
        "jsonrpc": "2.0",
        "method": method,
        "params": params,
        "id": 1
    });
    let response = client
        .post(&url)
        .header("Authorization", format!("Bearer {token}"))
        .json(&request)
        .send()
        .await
        .map_err(|e| {
            let hint = rpc_connect_failure_hint(rpc_addr);
            anyhow::anyhow!("Failed to connect to RPC server at {rpc_addr}{hint}: {e}")
        })?;
    let status = response.status();
    if !status.is_success() {
        anyhow::bail!("RPC request failed with status: {}", status);
    }
    let json: Value = response
        .json()
        .await
        .context("Failed to parse RPC response")?;
    if let Some(error) = json.get("error") {
        anyhow::bail!("RPC error: {}", error);
    }
    json.get("result")
        .cloned()
        .ok_or_else(|| anyhow::anyhow!("No result in RPC response"))
}

async fn rpc_call_with_auth(
    rpc_addr: SocketAddr,
    method: &str,
    params: Value,
    user: Option<&str>,
    password: Option<&str>,
) -> Result<Value> {
    let url = format!("http://{rpc_addr}");
    let client = reqwest::Client::new();

    let request = json!({
        "jsonrpc": "2.0",
        "method": method,
        "params": params,
        "id": 1
    });

    let mut req = client.post(&url).json(&request);

    // Use provided credentials or defaults
    let rpc_user = user.unwrap_or("btc");
    let rpc_password = password.unwrap_or("");
    req = req.basic_auth(rpc_user, Some(rpc_password));

    let response = req.send().await.map_err(|e| {
        let hint = rpc_connect_failure_hint(rpc_addr);
        anyhow::anyhow!("Failed to connect to RPC server at {rpc_addr}{hint}: {e}")
    })?;

    let status = response.status();
    if !status.is_success() {
        anyhow::bail!("RPC request failed with status: {}", status);
    }

    let json: Value = response
        .json()
        .await
        .context("Failed to parse RPC response")?;

    if let Some(error) = json.get("error") {
        anyhow::bail!("RPC error: {}", error);
    }

    json.get("result")
        .cloned()
        .ok_or_else(|| anyhow::anyhow!("No result in RPC response"))
}

// Subcommand handlers
async fn handle_status(rpc_addr: SocketAddr, config: &NodeConfig) -> Result<()> {
    let chain_info = rpc_call_with_config(rpc_addr, config, "getblockchaininfo", json!([])).await?;
    let network_info = rpc_call_with_config(rpc_addr, config, "getnetworkinfo", json!([])).await?;
    let peer_info = rpc_call_with_config(rpc_addr, config, "getpeerinfo", json!([])).await?;

    println!("=== Node Status ===");
    println!(
        "Block Height: {}",
        chain_info
            .get("blocks")
            .and_then(|v| v.as_u64())
            .unwrap_or(0)
    );
    println!(
        "Chain: {}",
        chain_info
            .get("chain")
            .and_then(|v| v.as_str())
            .unwrap_or("unknown")
    );
    println!(
        "Verification Progress: {:.2}%",
        chain_info
            .get("verificationprogress")
            .and_then(|v| v.as_f64())
            .unwrap_or(0.0)
            * 100.0
    );
    println!(
        "Connected Peers: {}",
        peer_info.as_array().map(|a| a.len()).unwrap_or(0)
    );
    println!(
        "Network Active: {}",
        network_info
            .get("networkactive")
            .and_then(|v| v.as_bool())
            .unwrap_or(false)
    );

    Ok(())
}

async fn handle_health(rpc_addr: SocketAddr, config: &NodeConfig) -> Result<()> {
    match rpc_call_with_config(rpc_addr, config, "getblockchaininfo", json!([])).await {
        Ok(_) => {
            println!("✅ Node is healthy");
            Ok(())
        }
        Err(e) => {
            eprintln!("❌ Health check failed: {e}");
            std::process::exit(1);
        }
    }
}

fn handle_version() -> Result<()> {
    println!("blvm {}", env!("CARGO_PKG_VERSION"));
    println!("Repository: {}", env!("CARGO_PKG_REPOSITORY"));

    // Try to get git info if available
    if let Ok(sha) = std::process::Command::new("git")
        .args(["rev-parse", "--short", "HEAD"])
        .output()
    {
        if let Ok(sha_str) = String::from_utf8(sha.stdout) {
            println!("Git: {}", sha_str.trim());
        }
    }

    // Show enabled features
    println!("\nFeatures:");
    #[cfg(feature = "utxo-commitments")]
    println!("  ✓ utxo-commitments");
    #[cfg(feature = "dandelion")]
    println!("  ✓ dandelion");
    #[cfg(feature = "ctv")]
    println!("  ✓ ctv");
    #[cfg(feature = "stratum-v2")]
    println!("  ✓ stratum-v2");
    println!("  ✓ bip158 (always on)");
    #[cfg(feature = "sigop")]
    println!("  ✓ sigop");

    Ok(())
}

async fn handle_chain(rpc_addr: SocketAddr, config: &NodeConfig) -> Result<()> {
    let info = rpc_call_with_config(rpc_addr, config, "getblockchaininfo", json!([])).await?;

    println!("=== Blockchain Information ===");
    println!(
        "Chain: {}",
        info.get("chain")
            .and_then(|v| v.as_str())
            .unwrap_or("unknown")
    );
    println!(
        "Blocks: {}",
        info.get("blocks").and_then(|v| v.as_u64()).unwrap_or(0)
    );
    println!(
        "Headers: {}",
        info.get("headers").and_then(|v| v.as_u64()).unwrap_or(0)
    );
    if let Some(hash) = info.get("bestblockhash").and_then(|v| v.as_str()) {
        println!("Best Block: {hash}");
    }
    if let Some(diff) = info.get("difficulty").and_then(|v| v.as_f64()) {
        println!("Difficulty: {diff:.2}");
    }
    if let Some(progress) = info.get("verificationprogress").and_then(|v| v.as_f64()) {
        println!("Verification Progress: {:.2}%", progress * 100.0);
    }

    Ok(())
}

async fn handle_peers(rpc_addr: SocketAddr, config: &NodeConfig) -> Result<()> {
    let peers = rpc_call_with_config(rpc_addr, config, "getpeerinfo", json!([])).await?;

    println!("=== Connected Peers ===");
    if let Some(peer_array) = peers.as_array() {
        if peer_array.is_empty() {
            println!("No peers connected");
        } else {
            for (i, peer) in peer_array.iter().enumerate() {
                println!("\nPeer {}:", i + 1);
                if let Some(addr) = peer.get("addr").and_then(|v| v.as_str()) {
                    println!("  Address: {addr}");
                }
                if let Some(version) = peer.get("version").and_then(|v| v.as_u64()) {
                    println!("  Version: {version}");
                }
                if let Some(latency) = peer.get("latency").and_then(|v| v.as_f64()) {
                    println!("  Latency: {:.2}ms", latency * 1000.0);
                }
            }
        }
    }

    Ok(())
}

async fn handle_network(rpc_addr: SocketAddr, config: &NodeConfig) -> Result<()> {
    let info = rpc_call_with_config(rpc_addr, config, "getnetworkinfo", json!([])).await?;

    println!("=== Network Information ===");
    println!(
        "Version: {}",
        info.get("version").and_then(|v| v.as_u64()).unwrap_or(0)
    );
    println!(
        "Subversion: {}",
        info.get("subversion")
            .and_then(|v| v.as_str())
            .unwrap_or("unknown")
    );
    println!(
        "Network Active: {}",
        info.get("networkactive")
            .and_then(|v| v.as_bool())
            .unwrap_or(false)
    );
    if let Some(connections) = info.get("connections").and_then(|v| v.as_u64()) {
        println!("Connections: {connections}");
    }
    if let Some(local_addrs) = info.get("localaddresses").and_then(|v| v.as_array()) {
        if !local_addrs.is_empty() {
            println!("Local Addresses:");
            for addr in local_addrs {
                if let Some(addr_str) = addr.get("address").and_then(|v| v.as_str()) {
                    println!("  {addr_str}");
                }
            }
        }
    }

    Ok(())
}

async fn handle_sync(rpc_addr: SocketAddr, config: &NodeConfig) -> Result<()> {
    let info = rpc_call_with_config(rpc_addr, config, "getblockchaininfo", json!([])).await?;

    let blocks = info.get("blocks").and_then(|v| v.as_u64()).unwrap_or(0);
    let headers = info.get("headers").and_then(|v| v.as_u64()).unwrap_or(0);
    let progress = info
        .get("verificationprogress")
        .and_then(|v| v.as_f64())
        .unwrap_or(0.0);
    let initial_block_download = info
        .get("initialblockdownload")
        .and_then(|v| v.as_bool())
        .unwrap_or(false);

    println!("=== Sync Status ===");
    println!("Blocks: {blocks}");
    println!("Headers: {headers}");
    println!("Progress: {:.2}%", progress * 100.0);
    if initial_block_download {
        println!("Initial block download: yes (active IBD)");
    }

    if blocks == headers && progress >= 1.0 {
        println!("Status: ✅ Fully synced");
    } else if headers > blocks {
        println!("Status: ⏳ Syncing ({} blocks behind)", headers - blocks);
    } else if progress < 0.999 && blocks > 0 {
        println!("Status: ⏳ Verifying downloaded blocks");
        println!(
            "Note: During active IBD, node logs (`IBD: <height> / <tip>`) are often ahead of this RPC view."
        );
    } else {
        println!("Status: ⏳ Verifying");
    }

    Ok(())
}

fn handle_config_show(config: &NodeConfig) -> Result<()> {
    println!(
        "{}",
        toml::to_string_pretty(config).context("Failed to serialize config")?
    );
    Ok(())
}

fn handle_config_validate(path: Option<PathBuf>, cli_config: &Option<PathBuf>) -> Result<()> {
    let config_path = path
        .or_else(|| cli_config.clone())
        .or_else(|| find_config_file(cli_config));

    match config_path {
        Some(path) => match NodeConfig::from_file(&path) {
            Ok(config) => match config.validate() {
                Ok(()) => {
                    println!("✅ Configuration file is valid: {}", path.display());
                    Ok(())
                }
                Err(e) => {
                    eprintln!("❌ Configuration validation failed: {e}");
                    std::process::exit(1);
                }
            },
            Err(e) => {
                eprintln!("❌ Configuration file is invalid: {e}");
                std::process::exit(1);
            }
        },
        None => {
            eprintln!("❌ No configuration file found");
            std::process::exit(1);
        }
    }
}

fn handle_config_path(cli_config: &Option<PathBuf>) -> Result<()> {
    if let Some(path) = find_config_file(cli_config) {
        println!("{}", path.display());
        Ok(())
    } else {
        println!("No configuration file found");
        Ok(())
    }
}

/// Set config value(s) in the config file. Supports dotted keys for primary and module config.
/// Examples: storage.data_dir=./data, modules.stratum-v2.listen_addr=0.0.0.1:3333
fn handle_config_set(cli_config: &Option<PathBuf>, assignments: &[String]) -> Result<()> {
    let config_path = find_config_file(cli_config)
        .or_else(|| Some(PathBuf::from("./blvm.toml")))
        .ok_or_else(|| anyhow::anyhow!("No config file path"))?;

    let mut content = if config_path.exists() {
        std::fs::read_to_string(&config_path).context("Failed to read config file")?
    } else {
        String::new()
    };

    let mut root: toml::Value = if content.trim().is_empty() {
        toml::Value::Table(toml::map::Map::new())
    } else {
        content
            .parse()
            .context("Failed to parse config file as TOML")?
    };

    for assignment in assignments {
        let (key, value_str) = assignment.split_once('=').ok_or_else(|| {
            anyhow::anyhow!("Invalid assignment '{}': expected key=value", assignment)
        })?;
        let key = key.trim();
        let value_str = value_str.trim();

        let value = parse_toml_value(value_str)?;
        set_toml_dotted(&mut root, key, value)?;
    }

    content = toml::to_string_pretty(&root).context("Failed to serialize config")?;
    std::fs::write(&config_path, content).context("Failed to write config file")?;
    println!("Updated {}", config_path.display());
    Ok(())
}

fn parse_toml_value(s: &str) -> Result<toml::Value> {
    let s = s.trim();
    if s == "true" {
        return Ok(toml::Value::Boolean(true));
    }
    if s == "false" {
        return Ok(toml::Value::Boolean(false));
    }
    if let Ok(i) = s.parse::<i64>() {
        return Ok(toml::Value::Integer(i));
    }
    if let Ok(f) = s.parse::<f64>() {
        return Ok(toml::Value::Float(f));
    }
    Ok(toml::Value::String(s.to_string()))
}

fn set_toml_dotted(root: &mut toml::Value, key: &str, value: toml::Value) -> Result<()> {
    let parts: Vec<&str> = key.split('.').collect();
    if parts.is_empty() {
        anyhow::bail!("Empty key");
    }

    let mut current = root;
    for (i, part) in parts.iter().enumerate() {
        let is_last = i == parts.len() - 1;
        if is_last {
            if let toml::Value::Table(t) = current {
                t.insert(part.to_string(), value);
                return Ok(());
            }
            anyhow::bail!(
                "Key '{}': expected table at '{}'",
                key,
                parts[..=i].join(".")
            );
        }
        if let toml::Value::Table(t) = current {
            let entry = t
                .entry(part.to_string())
                .or_insert_with(|| toml::Value::Table(toml::map::Map::new()));
            if let toml::Value::Table(_) = entry {
                current = entry;
            } else {
                anyhow::bail!(
                    "Key '{}': '{}' exists but is not a section",
                    key,
                    parts[..=i].join(".")
                );
            }
        } else {
            anyhow::bail!(
                "Key '{}': expected table at '{}'",
                key,
                parts[..=i].join(".")
            );
        }
    }
    Ok(())
}

/// Print config file path for a module (works offline; uses config to resolve path)
fn handle_module_config_path(module: &str, config: &NodeConfig, data_dir: &str) -> Result<()> {
    let modules_data_dir = config
        .modules
        .as_ref()
        .map(|m| PathBuf::from(&m.data_dir))
        .unwrap_or_else(|| PathBuf::from(data_dir).join("modules"));
    let path = modules_data_dir.join(module).join("config.toml");
    println!("{}", path.display());
    Ok(())
}

async fn handle_rpc(
    rpc_addr: SocketAddr,
    method: &str,
    params: Value,
    config: &NodeConfig,
) -> Result<()> {
    let result = rpc_call_with_config(rpc_addr, config, method, params).await?;
    println!("{}", serde_json::to_string_pretty(&result)?);
    Ok(())
}

async fn handle_module(
    rpc_addr: SocketAddr,
    subcommand: &ModuleCommand,
    config: &NodeConfig,
) -> Result<()> {
    let (method, params) = match subcommand {
        ModuleCommand::Load { name } => ("loadmodule", json!([name])),
        ModuleCommand::Unload { name } => ("unloadmodule", json!([name])),
        ModuleCommand::Reload { name } => ("reloadmodule", json!([name])),
        ModuleCommand::List => ("listmodules", json!([])),
    };
    let result = rpc_call_with_config(rpc_addr, config, method, params).await?;
    println!("{}", serde_json::to_string_pretty(&result)?);
    Ok(())
}

/// Handle dynamic module CLI (e.g. blvm sync-policy list)
async fn handle_module_cli(
    rpc_addr: SocketAddr,
    args: &[String],
    config: &NodeConfig,
) -> Result<()> {
    if args.len() < 2 {
        anyhow::bail!(
            "Usage: blvm <module_name> <subcommand> [args...]\n\
             Example: blvm sync-policy list\n\
             Run 'blvm' with no args to see core commands. Module commands require the node to be running."
        );
    }
    let module_name = &args[0];
    let subcommand = &args[1];
    let sub_args: Vec<String> = args[2..].to_vec();
    let params = {
        let mut p = vec![json!(module_name), json!(subcommand)];
        p.extend(sub_args.into_iter().map(Value::from));
        Value::Array(p)
    };
    let result = rpc_call_with_config(rpc_addr, config, "runmodulecli", params).await?;
    let stdout = result.get("stdout").and_then(|v| v.as_str()).unwrap_or("");
    let stderr = result.get("stderr").and_then(|v| v.as_str()).unwrap_or("");
    let exit_code = result
        .get("exit_code")
        .and_then(|v| v.as_i64())
        .unwrap_or(1);
    if !stdout.is_empty() {
        print!("{stdout}");
    }
    if !stderr.is_empty() {
        eprint!("{stderr}");
    }
    if exit_code != 0 {
        std::process::exit(exit_code as i32);
    }
    Ok(())
}
