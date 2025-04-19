{ config, lib, pkgs, ... }: {
  imports = [
    ./nvim
  ];

  options = {
    common.enable = lib.mkEnableOption "Enable Dhruv's Common Home-Manager Config";
    common.name = lib.mkOption {
      type = lib.types.string;
      default = "Unnamed Nochanges";
      example = "Dhruv Gramopadhye";
      description = "Full name";
    };
    common.email = lib.mkOption {
      type = lib.types.string;
      default = "test@example.com";
      example = "dgramopadhye@gmail.com";
      description = "User's email";
    };
  };


  config = lib.mkIf config.common.enable {
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
      btop
      localsend
      _1password-cli
      geogebra6
      nil
      delta
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
        shell = "${config.home.homeDirectory}/.nix-profile/bin/zsh"
        '';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.sessionPath = ["/nix/var/nix/profiles/default/bin" "${config.home.homeDirectory}/.nix-profile/bin/"];

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
      userEmail = "${config.common.email}";
      userName = "${config.common.name}";
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "master";
      };
    };

    programs.home-manager.enable = true;

    programs.git.extraConfig = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
      delta.dark = true;
      merge.conflictstyle = true;
    };
  };
}
