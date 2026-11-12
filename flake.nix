{
  description = "blvm: Bitcoin Commons node (BLVM), built from source against Cargo.lock";

  # Every input is pinned in flake.lock. Two machines that build the same
  # commit with the same flake.lock get the same derivation, which is what a
  # station config needs to be identical across keyholders.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      }));
      cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
    in
    {
      packages = forAllSystems (pkgs:
        let
          # Same toolchain as CI: read from rust-toolchain.toml.
          toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
          rustPlatform = pkgs.makeRustPlatform { cargo = toolchain; rustc = toolchain; };
          # Release feature set (scripts/ci-portable-cross-features.sh, Linux).
          linuxReleaseFeatures = [
            "heed3" "production" "utxo-commitments" "blvm-node/protocol-verification"
            "blvm-node/sysinfo" "iroh" "dandelion" "sigop" "governance" "rest-api"
            "compression" "blvm-node/libc"
          ];
          blvm = rustPlatform.buildRustPackage {
            pname = "blvm";
            version = cargoToml.package.version;
            src = pkgs.lib.cleanSourceWith {
              src = ./.;
              filter = path: type:
                let base = baseNameOf path; in
                !(builtins.elem base [ "target" "artifacts" "release-artifacts" ".git" "result" ]);
            };
            cargoLock.lockFile = ./Cargo.lock;

            # [patch.crates-io] points at sibling monorepo checkouts. Release
            # builds resolve every blvm-* crate from crates.io, so drop it here
            # exactly as CI does (rust-ci/strip-patch-crates-io).
            postPatch = ''
              awk '/^\[patch\.crates-io\]/ { skip = 1; next } skip && /^\[/ { skip = 0 } !skip { print }' \
                Cargo.toml > Cargo.toml.tmp && mv Cargo.toml.tmp Cargo.toml
            '';

            buildNoDefaultFeatures = true;
            buildFeatures = linuxReleaseFeatures;
            cargoBuildFlags = [ "--bin" "blvm" ];

            nativeBuildInputs = with pkgs; [ pkg-config perl cmake rustPlatform.bindgenHook ];
            buildInputs = with pkgs; [ openssl ];
            env = {
              BLVM_SECP256K1_NO_GPU = "1";
              OPENSSL_NO_VENDOR = "1";
            };

            # The test suite runs in CI against crates.io; the station only needs the binary.
            doCheck = false;

            meta = {
              description = "Bitcoin Commons BLVM node";
              homepage = "https://github.com/BTCDecoded/blvm";
              license = pkgs.lib.licenses.mit;
              mainProgram = "blvm";
              platforms = systems;
            };
          };
        in
        {
          inherit blvm;
          default = blvm;
        });

      nixosModules.blvm = import ./nix/module.nix self;
      nixosModules.default = self.nixosModules.blvm;

      # nix flake check builds the package and evaluates the module.
      checks = forAllSystems (pkgs: {
        blvm = self.packages.${pkgs.system}.blvm;
      });
    };
}
