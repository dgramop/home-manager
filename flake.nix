{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {self, nixpkgs, flake-utils, ...}: flake-utils.lib.eachDefaultSystem (system: let
    fixSdcc = final: prev: {
      # Temporary fix until 413537 merges
      sdcc = prev.sdcc.overrideAttrs {
        outputs = ["out" "doc"];
      };
    };

    pkgs = (import nixpkgs {
      overlays = [fixSdcc];
    }).legacyPackages.${system};
  in {
    homeConfigurations.dgramop = pkgs.callPackage ./home.nix {config = {};};
  });
}
