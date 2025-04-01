{ config, pkgs, ... }: let
lattice = (builtins.getFlake "git+ssh://git@ghe.anduril.dev/anduril/latticectl?rev=292966803a03b4a21ee1ea6538e8696287e8b6cc").packages.x86_64-linux.default;
username = "dgramopadhye";
homedir = "/home/dgramopadhye";
email = "dgramopadhye@anduril.com";
in {
  imports = [
    ./nvim
  ];

  config = {

    home.username = "${username}";
    home.homeDirectory = "${homedir}";

    home.packages = with pkgs; [
      rustup
      trunk
      tree
      eza
      alacritty
      d2
      tmux
      gnuradio
      jq
      gh
      wget
      cmake
      htop
      #darwin.lsusb
      localsend
      _1password-cli
      geogebra6
      lattice
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

    programs.bash = {
      enable = true;
      enableCompletion = true;
    };

    programs.git = {
      enable = true;
      userEmail = "${email}";
      userName = "Dhruv Gramopadhye";
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "master";
        #gpg = {
        #  format = "ssh";
        #};
        #"gpg \"ssh\"" = {
        #  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        #};
        #commit = {
        #  gpgsign = true;
        #};
        #user = {
        #  signingKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCljmP0GXaGu97J/vOE5kvlKZt262sqx2ADiN0Glt5dMjiP4ubQLmC4vUr4rajV/n1JcTJzp12LSNmIVUQKLZgxLpwKhk7W7EAElT2rCMj6Yr1c2P5B34nGCyDYPjMWahupkZafLHze9zWxtkH+fHicH4GtOXMW4R9nZycwqtefAUsWBSbG023rYgzO9lUz8ZPb846CgwxWdtDoOdf15O58IrRfrWF3QKzWErli3OZ5K4cu70D55xCyGG9+Gpozf1u0kTF80jCb24TNr2CELEo8rqVXmJeVqA5LO1g5putLzzeTt8XL6tBjT2Wu0eQAAVOODee51QXCQ8dM29HaT7rbodeWEBrfAIY0V8FsjGQSpQv0VmcDzTyQH7Se29Pd6kPYP8M3VjPoTK+RMHSOdgTPY7iAgUo5c5qhs4DA3vXI+CgaEopL3AiKOtycYOhkMB/HGcQZiZ126BCRlr7exeM7d5/XQsNjhuLjyAnOxsWNA8DI0IvmRflakka2gVqEYRk=";
        #};
      };
    };

    programs.starship.enable = true;

    programs.home-manager.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ls = "eza";
        vim = "nvim";
        rf = "nix develop .#nightly --command bash -c \"cargo fmt\"";
      };
      history.size = 10000;
    };

    xdg.enable = true;
    xdg.desktopEntries = {
      alacritty = {
        name = "Alacritty";
        exec = "nix run --impure github:nix-community/nixGL -- alacritty";
      };
    };
  };
}
