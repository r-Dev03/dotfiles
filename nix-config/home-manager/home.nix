# This is your home-manager configuration file
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
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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

  # Packages
  home.packages = with pkgs; [

    # shell / terminal
    starship
    zsh-autosuggestions

    ### CLI Tools
    btop
    fzf
    fd
    git
    gnumake
    platformio
    ripgrep
    tmux
    rustup
    tree
    imagemagick

    # build tools
    cmake
    gcc13
    openjdk
    (python311.withPackages (ps: with ps; [ipython]))

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
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint

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
      extraLuaPackages = ps: [ps.magick];
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      defaultKeymap = "emacs";
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
        dev = "cd ~/Documents/Dev/";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      fileWidgetCommand = "fd --type f";
    };
    starship.enable = true;
  };

  home.stateVersion = "23.05";
  systemd.user.startServices = "sd-switch";
}
