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
    ### Text editor
    neovim

    ### CLI Tools
    btop
    fzf
    fd
    git
    gnumake
    platformio
    ripgrep
    starship
    tmux
    zsh-autosuggestions

    ### build tools
    cmake
    gcc13
    openjdk
    (python311.withPackages (ps: with ps; [ipython]))

    ### File format-specific tools

    ### Nix
    rnix-lsp # language server
    nix-direnv # nix intergration for direnv
    alejandra # black-inspired formatting
    statix # linter

    ### Lua
    lua-language-server
    stylua

    ###Java
		jdt-language-server

    ### Web
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint

    ### Typst
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
        dots = "cd ~/.config/";
        dev = "cd ~/Documents/Dev/";
        vi = "nvim";
        vim = "nvim";
        vimdiff = "nvim -d";
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
