//! BLLVM - Bitcoin Low-Level Virtual Machine
//!
//! Library components for the BLLVM build orchestration system

use std::net::SocketAddr;

pub mod versions;

/// Canonical network name for config (`protocol_version` / logging).
pub fn canonical_network_name(network: &str) -> Option<&'static str> {
    match network.to_lowercase().as_str() {
        "mainnet" | "bitcoinv1" => Some("mainnet"),
        "testnet" | "testnet3" => Some("testnet"),
        "signet" => Some("signet"),
        "regtest" => Some("regtest"),
        _ => None,
    }
}

/// Default P2P listen port when CLI / config do not set `listen_addr`.
pub fn default_p2p_port_for_network(network: &str) -> u16 {
    match network.to_lowercase().as_str() {
        "mainnet" | "bitcoinv1" => 8333,
        "testnet" | "testnet3" => 18333,
        "signet" => 38333,
        _ => 18444,
    }
}

/// Default RPC listen address when CLI and `BLVM_RPC_ADDR` are unset.
pub fn default_rpc_addr_for_network(network: &str) -> SocketAddr {
    let addr = match network.to_lowercase().as_str() {
        "mainnet" | "bitcoinv1" => "127.0.0.1:8332",
        "signet" => "127.0.0.1:38332",
        "testnet" | "testnet3" => "127.0.0.1:18332",
        _ => "127.0.0.1:18443",
    };
    addr.parse().expect("valid default RPC address")
}

#[cfg(test)]
mod network_tests {
    use super::*;

    #[test]
    fn canonical_network_name_accepts_aliases() {
        assert_eq!(canonical_network_name("Mainnet"), Some("mainnet"));
        assert_eq!(canonical_network_name("testnet3"), Some("testnet"));
        assert_eq!(canonical_network_name("signet"), Some("signet"));
        assert!(canonical_network_name("unknown").is_none());
    }

    #[test]
    fn default_ports_match_core_chainparams() {
        assert_eq!(default_p2p_port_for_network("mainnet"), 8333);
        assert_eq!(default_p2p_port_for_network("testnet"), 18333);
        assert_eq!(default_p2p_port_for_network("signet"), 38333);
        assert_eq!(default_p2p_port_for_network("regtest"), 18444);
    }

    #[test]
    fn default_rpc_addrs_match_core() {
        assert_eq!(
            default_rpc_addr_for_network("signet"),
            "127.0.0.1:38332".parse().unwrap()
        );
    }
}
