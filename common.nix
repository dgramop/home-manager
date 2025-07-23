{ config, lib, pkgs, ... }: {
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
      _1password-cli
      nil
      util-linux
      julia-bin
      delta
      amber
      octaveFull
      meld
    ];
    home.stateVersion = "25.05";

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
        shell = "${config.home.homeDirectory}/.nix-profile/bin/bash"
        '';

        ".config/terminal-colors.d/cal.scheme".text = ''
        weekend 90
        today 1;30;42'';
    };

    home.sessionVariables = {
      EDITOR = "hx";
    };

    home.sessionPath = ["/nix/var/nix/profiles/default/bin" "${config.home.homeDirectory}/.nix-profile/bin/"];

    home.shellAliases = {
      ls = "eza";
      vim = "hx";
      nvim = "hx";
      nano = "hx";

      # Nix Build To
      nbt = "nix build && readlink result && nix copy `readlink result` --to";

      # Nix Develop
      nd = "nix develop";

      # Nix Build
      nb = "nix build";

      # Git Log
      gl = "git log --oneline --graph master HEAD";

      # Nix Flake LOck (--update-input)
      nflo = "nix flake lock --update-input";
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyFileSize = 10000;
      sessionVariables = {
        EDITOR = "hx";
      };
    };
    
    programs.starship.enable = true;

    programs.helix= {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "gruvbox";
        editor = {
          mouse = false;
          indent-heuristic = "simple";
          auto-format = false;
          line-number = "relative";
          auto-pairs = false;
          end-of-line-diagnostics = "hint";
        };
        keys.normal = {
          "0" = "goto_line_start";
          "C-h" = "select_prev_sibling";
          "C-j" = "shrink_selection";
          "C-k" = "expand_selection";
          "C-l" = "select_next_sibling";
          "C-r" = "redo";
          "G"."G" = "goto_last_line";
          "#" = "search_selection_detect_word_boundaries";
          "\\" = {
            "\\" = "changed_file_picker";
            "s" = "workspace_symbol_picker";
            "f" = "code_action";
            "h" = "hover";
            "p" = "goto_previous_buffer";
            "n" = "goto_next_buffer";
            "l" = "jump_backward";
            "o" = "file_picker";
            "t"."[" = "goto_type_definition";
            "[" = "goto_definition";
            "]" = "goto_reference";
          };
        };
      };
    };

    programs.git = {
      enable = true;
      userEmail = "${config.common.email}";
      userName = "${config.common.name}";
      lfs.enable = true;
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "master";
      };
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = config.common.name;
        user.email = config.common.email;
        ui.editor = "hx";
      };
    };

    programs.git.extraConfig = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
      delta.dark = true;
      merge.conflictstyle = "zdiff3";
    };

    programs.home-manager.enable = true;
  };
}
