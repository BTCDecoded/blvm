//! Default RPC addresses per network (CLI onboarding).

use std::net::SocketAddr;

#[test]
fn default_rpc_mainnet_uses_8332() {
    let addr: SocketAddr = blvm::default_rpc_addr_for_network("mainnet");
    assert_eq!(addr.port(), 8332);
}

#[test]
fn default_rpc_testnet_uses_18332() {
    let addr: SocketAddr = blvm::default_rpc_addr_for_network("testnet");
    assert_eq!(addr.port(), 18332);
}

#[test]
fn default_rpc_regtest_uses_18443() {
    let addr: SocketAddr = blvm::default_rpc_addr_for_network("regtest");
    assert_eq!(addr.port(), 18443);
}

#[test]
fn default_rpc_signet_uses_38332() {
    let addr: SocketAddr = blvm::default_rpc_addr_for_network("signet");
    assert_eq!(addr.port(), 38332);
}
