//! Tests for versions.toml parsing and validation

use bllvm::versions::{ValidationResult, VersionsManifest};
use std::fs;
use tempfile::TempDir;

/// Test parsing valid versions.toml
#[test]
fn test_parse_valid_versions_toml() {
    let content = r#"
[versions]
blvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
blvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-consensus=0.1.0"] }
blvm-node = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-protocol=0.1.0", "blvm-consensus=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse valid TOML");
    assert_eq!(manifest.versions.len(), 3);
    assert!(manifest.versions.contains_key("blvm-consensus"));
    assert!(manifest.versions.contains_key("blvm-protocol"));
    assert!(manifest.versions.contains_key("blvm-node"));
}

/// Test dependency resolution
#[test]
fn test_dependency_resolution() {
    let content = r#"
[versions]
blvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
blvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-consensus=0.1.0"] }
blvm-node = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-protocol=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");

    // Verify blvm-protocol requires blvm-consensus
    let protocol = manifest.versions.get("blvm-protocol").unwrap();
    assert!(protocol
        .requires
        .iter()
        .any(|r| r.contains("blvm-consensus")));

    // Verify blvm-node requires blvm-protocol
    let node = manifest.versions.get("blvm-node").unwrap();
    assert!(node.requires.iter().any(|r| r.contains("blvm-protocol")));
}

/// Test version format validation
#[test]
fn test_version_format_validation() {
    let valid_content = r#"
[versions]
repo1 = { version = "0.1.0", git_tag = "v0.1.0" }
repo2 = { version = "1.2.3", git_tag = "v1.2.3" }
repo3 = { version = "10.20.30", git_tag = "v10.20.30" }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, valid_content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let validation = manifest.validate();
    assert!(
        validation.is_valid(),
        "Valid versions should pass validation"
    );
}

/// Test invalid version format
#[test]
fn test_invalid_version_format() {
    let invalid_content = r#"
[versions]
repo1 = { version = "1.2", git_tag = "v1.2" }
repo2 = { version = "v1.2.3", git_tag = "v1.2.3" }
repo3 = { version = "1.2.3.4", git_tag = "v1.2.3.4" }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, invalid_content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse TOML");
    let validation = manifest.validate();
    assert!(
        !validation.is_valid(),
        "Invalid versions should fail validation"
    );
    assert!(!validation.errors().is_empty());
}

/// Test circular dependency detection
#[test]
fn test_circular_dependency_detection() {
    let content = r#"
[versions]
A = { version = "0.1.0", git_tag = "v0.1.0", requires = ["B=0.1.0"] }
B = { version = "0.1.0", git_tag = "v0.1.0", requires = ["A=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    assert!(
        manifest.detect_circular_dependencies().is_some(),
        "Should detect circular dependency"
    );

    let validation = manifest.validate();
    assert!(
        !validation.is_valid(),
        "Circular dependencies should fail validation"
    );
}

/// Test missing dependency detection
#[test]
fn test_missing_dependency_detection() {
    let content = r#"
[versions]
blvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-consensus=0.1.0"] }
# blvm-consensus is missing!
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let validation = manifest.validate();
    assert!(
        !validation.is_valid(),
        "Missing dependencies should fail validation"
    );
    assert!(validation
        .errors()
        .iter()
        .any(|e| e.contains("blvm-consensus")));
}

/// Test build order calculation
#[test]
fn test_build_order() {
    let content = r#"
[versions]
blvm-consensus = { version = "0.1.0", git_tag = "v0.1.0" }
blvm-protocol = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-consensus=0.1.0"] }
blvm-node = { version = "0.1.0", git_tag = "v0.1.0", requires = ["blvm-protocol=0.1.0"] }
"#;

    let temp_dir = TempDir::new().unwrap();
    let versions_path = temp_dir.path().join("versions.toml");
    fs::write(&versions_path, content).unwrap();

    let manifest = VersionsManifest::from_file(&versions_path).expect("Should parse");
    let order = manifest
        .build_order()
        .expect("Should calculate build order");

    let consensus_pos = order.iter().position(|r| r == "blvm-consensus").unwrap();
    let protocol_pos = order.iter().position(|r| r == "blvm-protocol").unwrap();
    let node_pos = order.iter().position(|r| r == "blvm-node").unwrap();

    assert!(
        consensus_pos < protocol_pos,
        "blvm-consensus should come before blvm-protocol"
    );
    assert!(
        protocol_pos < node_pos,
        "blvm-protocol should come before blvm-node"
    );
}

/// Test build order with circular dependency
#[test]
fn test_build_order_circular() {
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
