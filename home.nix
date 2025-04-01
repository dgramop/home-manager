{pkgs, lib, config, ...}: 
let 
  lattice = (builtins.getFlake "git+ssh://git@ghe.anduril.dev/anduril/latticectl?rev=292966803a03b4a21ee1ea6538e8696287e8b6cc").packages.x86_64-linux.default;
in {
  imports = [
    ./common.nix
  ];

  config = {
    home.username = "dgramopadhye";
    home.homeDirectory = "/home/dgramopadhye";
    common = {
      enable = true;
      email = "dgramopadhye@anduril.com";
      name = "Dhruv Gramopadhye";
    };
    
    home.shellAliases.rf = "nix develop .#nightly --command bash -c \"cargo fmt\"";
    home.packages = [
      lattice
    ];
  };
}
