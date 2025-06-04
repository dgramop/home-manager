{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils, home-manager, ...}: flake-utils.lib.eachDefaultSystem (system: let
    fixSdcc = final: prev: {
      # Temporary fix until 413537 merges
      sdcc = prev.sdcc.overrideAttrs {
        outputs = ["out" "doc"];
      };
    };
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    packages.homeConfigurations."dgramop" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  });
}
