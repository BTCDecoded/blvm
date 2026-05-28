//! BLLVM - Bitcoin Low-Level Virtual Machine
//!
//! Library components for the BLLVM build orchestration system

use std::net::SocketAddr;

pub mod versions;

/// Default RPC listen address when CLI and `BLVM_RPC_ADDR` are unset.
pub fn default_rpc_addr_for_network(network: &str) -> SocketAddr {
    let addr = match network.to_lowercase().as_str() {
        "mainnet" | "bitcoinv1" => "127.0.0.1:8332",
        _ => "127.0.0.1:18332",
    };
    addr.parse().expect("valid default RPC address")
}
