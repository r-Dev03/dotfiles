{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        openssl
      ];
    };

    zoxide = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };

    starship = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Shell tools
    aerc
    btop
    bat
    coreutils-full
    eza
		fzf
    fd
    fastfetch
    gnupg
    gnumake
    ghostty
    kitty
    mycli
    neovim
    ripgrep
    stow
    tmux
    tree
    tealdeer
    uv
    unzip
    vim
    wezterm
    yq-go
    yazi

    # Language servers & formatters
    nil
    alejandra

    lua-language-server
    stylua

    jdt-language-server

    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint

    # Build tools
    cmake
  ];
}
