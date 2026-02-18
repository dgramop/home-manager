{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils, home-manager, ...}: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    packages.homeConfigurations."mac" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./mac.nix ];
    };

    packages.homeConfigurations."linux" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./linux.nix ];
    };
  });
}
