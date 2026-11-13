//! Rejects the binary crate already returns: an unknown network name,
//! and a versions file that is not there.

use std::path::Path;

use blvm::canonical_network_name;
use blvm::versions::VersionsManifest;

#[test]
fn canonical_network_name_rejects_an_unknown_network() {
    for name in ["", "testnet5", "main", "bitcoin"] {
        match canonical_network_name(name) {
            None => {}
            Some(canonical) => panic!("{name} was accepted as {canonical}"),
        }
    }
}

#[test]
fn versions_manifest_rejects_a_missing_file() {
    let dir = tempfile::TempDir::new().expect("tempdir");
    let path = dir.path().join("versions.toml");
    match VersionsManifest::from_file(Path::new(&path)) {
        Err(err) => {
            let message = err.to_string();
            assert!(
                message.contains("Failed to read versions.toml"),
                "from_file returned {message}"
            );
        }
        Ok(manifest) => panic!("missing versions file parsed: {manifest:?}"),
    }
}
