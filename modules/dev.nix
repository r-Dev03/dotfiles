{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Shell tools
    aerc
    btop
    bat
		direnv
		nix-direnv
    eza
    fd
		fzf
    gnupg
    gnumake
    ghostty
    kitty
    mycli
    neofetch
		neovim
    ripgrep
    stow
		starship
    tmux
    tree
    tealdeer
    uv
    unzip
    wezterm
    yq-go
		zoxide
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting

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

