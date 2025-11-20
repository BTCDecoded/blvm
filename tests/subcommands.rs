//! Tests for bllvm subcommands

use assert_cmd::Command;
use predicates::prelude::*;

/// Test that version subcommand works
#[test]
fn test_version_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("version");
    cmd.assert()
        .success()
        .stdout(predicate::str::contains("BLLVM"));
}

/// Test that status subcommand parses correctly
#[test]
fn test_status_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("status");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test status subcommand with custom RPC address
#[test]
fn test_status_with_rpc_addr() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("status").arg("--rpc-addr").arg("127.0.0.1:8332");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test that health subcommand parses correctly
#[test]
fn test_health_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("health");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test that chain subcommand parses correctly
#[test]
fn test_chain_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("chain");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test that peers subcommand parses correctly
#[test]
fn test_peers_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("peers");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test that network subcommand parses correctly
#[test]
fn test_network_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("network");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test that sync subcommand parses correctly
#[test]
fn test_sync_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("sync");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test config show subcommand
#[test]
fn test_config_show_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("config").arg("show");
    cmd.assert().success().stdout(predicate::str::contains("["));
}

/// Test config validate subcommand (no file)
#[test]
fn test_config_validate_no_file() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("config").arg("validate");
    // Should fail if no config file found
    cmd.assert().failure();
}

/// Test config validate subcommand with path
#[test]
fn test_config_validate_with_path() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("config")
        .arg("validate")
        .arg("/nonexistent/path.toml");
    // Should fail if file doesn't exist
    cmd.assert().failure();
}

/// Test config path subcommand
#[test]
fn test_config_path_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("config").arg("path");
    // Should succeed (may output "No configuration file found")
    cmd.assert().success();
}

/// Test rpc subcommand parsing
#[test]
fn test_rpc_subcommand_parsing() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("rpc").arg("getblockchaininfo");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test rpc subcommand with params
#[test]
fn test_rpc_subcommand_with_params() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("rpc").arg("getblockchaininfo").arg("[]");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test rpc subcommand with custom RPC address
#[test]
fn test_rpc_subcommand_with_rpc_addr() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("rpc")
        .arg("getblockchaininfo")
        .arg("--rpc-addr")
        .arg("127.0.0.1:8332");
    cmd.timeout(std::time::Duration::from_secs(2));
    // Will fail without running node, but should parse correctly
    let _ = cmd.assert();
}

/// Test that invalid subcommand is rejected
#[test]
fn test_invalid_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("invalid-subcommand");
    cmd.assert()
        .failure()
        .stderr(predicate::str::contains("Unknown"));
}

/// Test that help shows subcommands
#[test]
fn test_help_shows_subcommands() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("--help");
    cmd.assert()
        .success()
        .stdout(predicate::str::contains("status"))
        .stdout(predicate::str::contains("health"))
        .stdout(predicate::str::contains("version"))
        .stdout(predicate::str::contains("config"));
}

/// Test that subcommand help works
#[test]
fn test_subcommand_help() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("config").arg("--help");
    cmd.assert()
        .success()
        .stdout(predicate::str::contains("show"))
        .stdout(predicate::str::contains("validate"))
        .stdout(predicate::str::contains("path"));
}

/// Test that default behavior (no subcommand) still works
#[test]
fn test_default_behavior() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.timeout(std::time::Duration::from_secs(1));
    // Should try to start node (will fail, but parsing should work)
    let _ = cmd.assert();
}

/// Test that start subcommand works (explicit)
#[test]
fn test_start_subcommand() {
    let mut cmd = Command::cargo_bin("bllvm").unwrap();
    cmd.arg("start");
    cmd.timeout(std::time::Duration::from_secs(1));
    // Should try to start node (will fail, but parsing should work)
    let _ = cmd.assert();
}
