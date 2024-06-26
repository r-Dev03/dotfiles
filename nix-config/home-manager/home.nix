# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
  ];

  nixpkgs = {
    overlays = [
    ];

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "r-dev";
    homeDirectory = "/Users/r-dev";
    sessionVariables = {
      EDITOR = "nvim";
      DOTFILES = "$HOME/.dotfiles/";
    };
  };

  # packages
  home.packages = with pkgs; [
    # shell / terminal
    starship
    zsh-autosuggestions

    # CLI Tools
    btop
		bat
		eza
    fzf
    fd
    git
    gnumake
    platformio
    ripgrep
		rustup
    tmux
    tree
    yazi
    yq-go
		uv

    # build tools
    cmake
    gcc13
    openjdk
    (python311.withPackages (ps: with ps; [ipython black isort]))
		nodePackages.pyright

    # file format-specific tools

    # nix
    rnix-lsp # language server
    nix-direnv # nix intergration for direnv
    alejandra # black-inspired formatting
    statix # linter

    # lua
    lua-language-server
    stylua

    # java
    jdt-language-server

    # web
		nodejs_18
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint

    # go
    go
    gopls

    # typst
    typst
    typst-lsp
    typstfmt
  ];

  programs = {
    home-manager.enable = true;
    git.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    neovim = {
      enable = true;
      # extraLuaPackages = ps: [ps.magick];
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      defaultKeymap = "emacs";
      envExtra = ''
            export PATH=$HOME/Developer/utils/flutter/bin:$PATH
        export PATH=$HOME/.gem/bin:$PATH
      '';

      initExtra = ''

      '';
      history = {
        size = 10000;
        save = 10000;
        ignoreDups = true;
        expireDuplicatesFirst = true;
        share = true;
      };
      shellAliases = {
        hmbuild = "home-manager switch --flake /Users/r-dev/.config/nix-config#r-dev@rdev-mba";
        matlab = "/Applications/MATLAB_R2023b.app/bin/matlab -nodesktop -nosplash";
        dots = "cd ~/.config/";
        dev = "cd ~/Developer/";
				ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      fileWidgetCommand = "fd --type f";
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    sioyek = {
      enable = true;
    };
    starship.enable = true;
  };

  home.stateVersion = "23.05";
  systemd.user.startServices = "sd-switch";
}
