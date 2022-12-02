{
  description = "An xmobar configuration as a Cabal project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      ghcVersion = "ghc924";

      pkgs = nixpkgs.legacyPackages.${system};

      haskellPackages = pkgs.haskell.packages.${ghcVersion}.override {};

      xmeowbar = haskellPackages.callCabal2nix "xmeowbar" ./. {};
    in {
      packages.xmeowbar = xmeowbar;

      defaultPackage = xmeowbar;

      devShell = haskellPackages.shellFor {
        packages = p: [xmeowbar];
        buildInputs = with haskellPackages; [
          cabal-install
          haskell-language-server
          floskell
        ];
      };
    });
}
