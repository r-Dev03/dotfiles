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
    mycli
    neovim
    ripgrep
    stow
    tmux
    typst
    tree-sitter
    tree
    tealdeer
    uv
    unzip
    vim
    wezterm
    yq-go
    yazi

    # Language servers & formatters
    # Nix 
    nil
    alejandra

    # Lua
    lua-language-server
    stylua

    # Java
    jdt-language-server

    # Typst
    tinymist

    # Python
    basedpyright
    python312Packages.black

    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint

    # Build tools
    cmake
  ];
}
