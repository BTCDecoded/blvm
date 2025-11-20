//! Tests for build order and dependency resolution

use std::fs;
use tempfile::TempDir;
use bllvm::versions::VersionsManifest;

/// Test that build order respects dependencies
#[test]
fn test_build_order_respects_dependencies() {
    // Given: bllvm-node depends on bllvm-protocol and bllvm-consensus
    // When: calculating build order
    // Then: bllvm-consensus and bllvm-protocol should come before bllvm-node
    
    let content = r#"
[versions]
bllvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
bllvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["bllvm-consensus=0.1.0"] }
bllvm-node = { version = "0.1.0", git_tag = "v0.1.0", requires = ["bllvm-protocol=0.1.0", "bllvm-consensus=0.1.0"] }
"#;
    
    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();
    
    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let build_order = manifest.build_order().expect("Should calculate build order");
    
    // Verify order
    let consensus_pos = build_order.iter().position(|r| r == "bllvm-consensus").unwrap();
    let protocol_pos = build_order.iter().position(|r| r == "bllvm-protocol").unwrap();
    let node_pos = build_order.iter().position(|r| r == "bllvm-node").unwrap();
    
    assert!(consensus_pos < protocol_pos, "bllvm-consensus should come before bllvm-protocol");
    assert!(protocol_pos < node_pos, "bllvm-protocol should come before bllvm-node");
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
    assert!(result.unwrap_err().to_string().contains("Circular dependency"));
}

/// Test parallel builds (repos with no dependencies can be built in parallel)
#[test]
fn test_parallel_builds() {
    let content = r#"
[versions]
bllvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
bllvm-sdk = { version = "0.1.0", git_tag = "v0.1.0" }
bllvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["bllvm-consensus=0.1.0"] }
"#;
    
    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();
    
    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let build_order = manifest.build_order().expect("Should calculate build order");
    
    // bllvm-consensus and bllvm-sdk have no dependencies, so they can be built in parallel
    // bllvm-protocol depends on bllvm-consensus, so consensus must come before protocol
    // bllvm-sdk has no dependencies, so its position relative to protocol is non-deterministic
    let consensus_pos = build_order.iter().position(|r| r == "bllvm-consensus").unwrap();
    let protocol_pos = build_order.iter().position(|r| r == "bllvm-protocol").unwrap();
    
    // Consensus must come before protocol (it's a dependency)
    assert!(consensus_pos < protocol_pos, "bllvm-consensus should come before bllvm-protocol (it's a dependency)");
    
    // Verify all repos are present (order between independent repos is non-deterministic)
    assert!(build_order.contains(&"bllvm-consensus".to_string()));
    assert!(build_order.contains(&"bllvm-sdk".to_string()));
    assert!(build_order.contains(&"bllvm-protocol".to_string()));
    assert_eq!(build_order.len(), 3, "Should have exactly 3 repos in build order");
}

