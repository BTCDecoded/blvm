{
  description = "BLVM heed3 package and NixOS module";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system:
        f (import nixpkgs { inherit system; }));
    in
    {
      packages = forAll (pkgs: {
        default = pkgs.callPackage ./nix/package.nix { };
      });
      nixosModules.default = import ./nix/module.nix;
    };
}
