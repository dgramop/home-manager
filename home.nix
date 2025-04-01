{ config, pkgs, ... }: let
username = "dgramopadhye";
homedir = "/home/dgramopadhye";
email = "dgramopadhye@anduril.com";
name = "Dhruv Gramopadhye";
in {
  imports = [
    ./nvim
    ./work.nix
    ./personal.nix
  ];

  config = {
    home.username = "${username}";
    home.homeDirectory = "${homedir}";

    work.enable = true;
    personal.enable = false;

    home.packages = with pkgs; [
      rustup
      trunk
      tree
      eza
      alacritty
      d2
      tmux
      jq
      gh
      wget
      cmake
      htop
      localsend
      _1password-cli
      geogebra6
    ];
    home.stateVersion = "24.11";

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      ".config/alacritty/alacritty.toml".text = ''
        [font]
        size = 14

        [terminal]
        shell = "${homedir}/.nix-profile/bin/zsh"
        '';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.sessionPath = ["/nix/var/nix/profiles/default/bin" "${homedir}/.nix-profile/bin/"];

    home.shellAliases = {
      ls = "eza";
      vim = "nvim";
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
    };
    
    programs.starship.enable = true;

    programs.git = {
      enable = true;
      userEmail = "${email}";
      userName = "${name}";
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "master";
      };
    };

    programs.home-manager.enable = true;

    xdg.enable = true;
    xdg.desktopEntries = {
      alacritty = {
        name = "Alacritty";
        exec = "nix run --impure github:nix-community/nixGL -- alacritty";
      };
    };
  };
}
