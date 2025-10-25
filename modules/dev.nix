{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
    eza
		fzf
    fd
    gnupg
    gnumake
    ghostty
    kitty
    mycli
    neofetch
    neovim
    ripgrep
    stow
    tmux
    tree
    tealdeer
    uv
    unzip
    wezterm
    yq-go

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
