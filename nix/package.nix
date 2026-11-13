{ lib, rustPlatform, pkg-config, openssl, lmdb }:

rustPlatform.buildRustPackage {
  pname = "blvm";
  version = "0.1.0";

  src = lib.cleanSourceWith {
    src = lib.cleanSource ../.;
    filter = path: type:
      let base = baseNameOf path; in
      base != "target" && base != "result";
  };

  cargoLock.lockFile = ../Cargo.lock;

  # The node test suite is not the package check. `nix build` is the package.
  doCheck = false;

  nativeBuildInputs = [ pkg-config ];
  # heed3 links liblmdb. OpenSSL is the TLS stack. RocksDB's cmake, clang,
  # lz4, zstd, and snappy are not installed; the rocksdb Cargo feature stays off.
  buildInputs = [ openssl lmdb ];

  # Same strip CI uses for the image: drop sibling path patches so this
  # builds the published crates, not this workspace.
  postPatch = ''
    awk '
      /^\[patch\.crates-io\]/ { skip = 1; next }
      skip && /^\[/ { skip = 0 }
      !skip { print }
    ' Cargo.toml > Cargo.toml.nopatch
    mv Cargo.toml.nopatch Cargo.toml
  '';

  meta = with lib; {
    description = "Bitcoin Commons BLVM node (heed3)";
    license = licenses.mit;
    mainProgram = "blvm";
    platforms = platforms.linux;
  };
}
