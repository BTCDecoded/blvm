//! `-assumevalid=<hash>` takes the hash in display order (as Core and explorers print
//! it); consensus compares against the internal-order header hash.

use blvm::{AssumeValidArg, parse_assume_valid_arg};

/// Bitcoin Core v31.1 mainnet defaultAssumeValid (src/kernel/chainparams.cpp), block 938343.
const CORE_MAINNET_AV: &str = "00000000000000000000ccebd6d74d9194d8dcdc1d177c478e094bfad51ba5ac";

/// The same hash in internal byte order: what `double_sha256(header)` returns and what
/// blvm-consensus compares at the assume-valid height.
const CORE_MAINNET_AV_INTERNAL: [u8; 32] = [
    0xac, 0xa5, 0x1b, 0xd5, 0xfa, 0x4b, 0x09, 0x8e, 0x47, 0x7c, 0x17, 0x1d, 0xdc, 0xdc, 0xd8, 0x94,
    0x91, 0x4d, 0xd7, 0xd6, 0xeb, 0xcc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
];

#[test]
fn core_display_hash_parses_to_internal_order() {
    assert_eq!(
        parse_assume_valid_arg(CORE_MAINNET_AV),
        Ok(AssumeValidArg::Hash(CORE_MAINNET_AV_INTERNAL))
    );
}

/// Genesis: display hex vs the header hash computed from its fields.
#[test]
fn genesis_display_hash_matches_computed_header_hash() {
    let header = hex::decode(
        "0100000000000000000000000000000000000000000000000000000000000000000000003ba3edfd7a7b12b27ac72c3e67768f617fc81bc3888a51323a9fb8aa4b1e5e4a29ab5f49ffff001d1dac2b7c",
    )
    .unwrap();
    let computed = blvm_node::storage::hashing::double_sha256(&header);
    assert_eq!(
        parse_assume_valid_arg("000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f"),
        Ok(AssumeValidArg::Hash(computed))
    );
}

#[test]
fn heights_and_disable() {
    assert_eq!(parse_assume_valid_arg("0"), Ok(AssumeValidArg::Disabled));
    assert_eq!(
        parse_assume_valid_arg("700000"),
        Ok(AssumeValidArg::Height(700_000))
    );
    assert!(parse_assume_valid_arg("nope").is_err());
    assert!(parse_assume_valid_arg(&"g".repeat(64)).is_err());
}
