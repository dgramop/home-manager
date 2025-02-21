{ config, pkgs, ... }:

{
  imports = [
    ./nvim
  ];

  home.username = "dgramop";
  home.homeDirectory = "/Users/dgramop";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    rustup
    trunk
    tree
    eza
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/alacritty/alacritty.toml".text = ''
      [font]
      size = 16
      '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
    };
    history.size = 10000;
  };

  programs.home-manager.enable = true;
}
