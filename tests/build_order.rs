//! Tests for build order and dependency resolution

use bllvm::versions::VersionsManifest;
use std::fs;
use tempfile::TempDir;

/// Test that build order respects dependencies
#[test]
fn test_build_order_respects_dependencies() {
    // Given: blvm-node depends on blvm-protocol and blvm-consensus
    // When: calculating build order
    // Then: blvm-consensus and blvm-protocol should come before blvm-node

    let content = r#"
[versions]
blvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
blvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-consensus=0.1.0"] }
blvm-node = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-protocol=0.1.0", "blvm-consensus=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let build_order = manifest
        .build_order()
        .expect("Should calculate build order");

    // Verify order
    let consensus_pos = build_order
        .iter()
        .position(|r| r == "blvm-consensus")
        .unwrap();
    let protocol_pos = build_order
        .iter()
        .position(|r| r == "blvm-protocol")
        .unwrap();
    let node_pos = build_order.iter().position(|r| r == "blvm-node").unwrap();

    assert!(
        consensus_pos < protocol_pos,
        "blvm-consensus should come before blvm-protocol"
    );
    assert!(
        protocol_pos < node_pos,
        "blvm-protocol should come before blvm-node"
    );
}

/// Test circular dependency detection in build order
#[test]
fn test_circular_dependency_detection() {
    // A depends on B, B depends on A - should fail
    let content = r#"
[versions]
A = { version = "0.1.0", git_tag = "v0.1.0", requires = ["B=0.1.0"] }
B = { version = "0.1.0", git_tag = "v0.1.0", requires = ["A=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let result = manifest.build_order();

    assert!(result.is_err(), "Should fail with circular dependency");
    assert!(result
        .unwrap_err()
        .to_string()
        .contains("Circular dependency"));
}

/// Test parallel builds (repos with no dependencies can be built in parallel)
#[test]
fn test_parallel_builds() {
    let content = r#"
[versions]
blvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
bllvm-sdk = { version = "0.1.0", git_tag = "v0.1.0" }
blvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-consensus=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let build_order = manifest
        .build_order()
        .expect("Should calculate build order");

    // blvm-consensus and bllvm-sdk have no dependencies, so they can be built in parallel
    // blvm-protocol depends on blvm-consensus, so consensus must come before protocol
    // bllvm-sdk has no dependencies, so its position relative to protocol is non-deterministic
    let consensus_pos = build_order
        .iter()
        .position(|r| r == "blvm-consensus")
        .unwrap();
    let protocol_pos = build_order
        .iter()
        .position(|r| r == "blvm-protocol")
        .unwrap();

    // Consensus must come before protocol (it's a dependency)
    assert!(
        consensus_pos < protocol_pos,
        "blvm-consensus should come before blvm-protocol (it's a dependency)"
    );

    // Verify all repos are present (order between independent repos is non-deterministic)
    assert!(build_order.contains(&"blvm-consensus".to_string()));
    assert!(build_order.contains(&"bllvm-sdk".to_string()));
    assert!(build_order.contains(&"blvm-protocol".to_string()));
    assert_eq!(
        build_order.len(),
        3,
        "Should have exactly 3 repos in build order"
    );
}
