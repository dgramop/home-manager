{pkhs, lib, config, ...}: 
let 
  lattice = (builtins.getFlake "git+ssh://git@ghe.anduril.dev/anduril/latticectl?rev=292966803a03b4a21ee1ea6538e8696287e8b6cc").packages.x86_64-linux.default;
  cfg = config.work;
in {
  imports = [];

  options = {
    work.enable = lib.mkEnableOption "Enable Work";
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases.rf = "nix develop .#nightly --command bash -c \"cargo fmt\"";
    home.packages = [
      lattice
    ];
  };
}
