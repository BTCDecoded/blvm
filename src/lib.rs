//! BLLVM - Bitcoin Low-Level Virtual Machine
//!
//! Library components for the BLLVM build orchestration system

use std::net::SocketAddr;

pub mod versions;

/// Parsed `-assumevalid` value.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AssumeValidArg {
    /// `0`: verify every script.
    Disabled,
    /// A block height.
    Height(u64),
    /// A block hash in internal (little-endian) byte order, the order consensus
    /// compares against the computed header hash.
    Hash([u8; 32]),
}

/// Parse `-assumevalid=<height|hash>`.
///
/// A hash is given the way Bitcoin Core and every block explorer print it: 64 hex
/// digits, most significant byte first (display order). Consensus stores and
/// compares hashes in internal order, so the bytes are reversed here.
pub fn parse_assume_valid_arg(val: &str) -> Result<AssumeValidArg, String> {
    let val = val.trim();
    if val == "0" {
        return Ok(AssumeValidArg::Disabled);
    }
    if val.len() == 64 && val.chars().all(|c| c.is_ascii_hexdigit()) {
        let mut bytes: [u8; 32] = hex::decode(val)
            .map_err(|e| format!("invalid -assumevalid hash hex: {e}"))?
            .try_into()
            .map_err(|_| "invalid -assumevalid hash length; use 64 hex chars".to_string())?;
        bytes.reverse();
        return Ok(AssumeValidArg::Hash(bytes));
    }
    val.parse::<u64>().map(AssumeValidArg::Height).map_err(|_| {
        format!(
            "invalid -assumevalid value '{val}'; use a height (e.g. 700000) or a 64-char block hash"
        )
    })
}

/// Canonical network name for config (`protocol_version` / logging).
pub fn canonical_network_name(network: &str) -> Option<&'static str> {
    match network.to_lowercase().as_str() {
        "mainnet" | "bitcoinv1" => Some("mainnet"),
        "testnet" | "testnet3" => Some("testnet"),
        "testnet4" => Some("testnet4"),
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
        "testnet4" => 48333,
        "signet" => 38333,
        _ => 18444,
    }
}

/// Default RPC listen address when CLI and `BLVM_RPC_ADDR` are unset.
pub fn default_rpc_addr_for_network(network: &str) -> SocketAddr {
    let addr = match network.to_lowercase().as_str() {
        "mainnet" | "bitcoinv1" => "127.0.0.1:8332",
        "signet" => "127.0.0.1:38332",
        "testnet4" => "127.0.0.1:48332",
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
        assert_eq!(canonical_network_name("testnet4"), Some("testnet4"));
        assert!(canonical_network_name("unknown").is_none());
    }

    #[test]
    fn default_ports_match_core_chainparams() {
        assert_eq!(default_p2p_port_for_network("mainnet"), 8333);
        assert_eq!(default_p2p_port_for_network("testnet"), 18333);
        assert_eq!(default_p2p_port_for_network("signet"), 38333);
        assert_eq!(default_p2p_port_for_network("testnet4"), 48333);
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
