{
  config,
  pkgs,
  ...
}: {
  # Basic user details
  home.username = "ron";
  home.homeDirectory = "/home/ron";
  home.stateVersion = "24.05";

  # Combined packages from shell.nix and vim.nix
  home.packages = with pkgs; [
    # Shell tools
    # aerc
    # age
    btop
    bat
    eza
    fzf
    fd
    gnupg
    gnumake
    ghostty
    kitty
    neofetch
    ripgrep
    stow
    tmux
    tree
    tealdeer
    uv
    vim
    wezterm

    # language servers & formatters

    nixd # nix language server
    nix-direnv # nix integration for direnv
    alejandra # formatter
    statix # linter

    lua-language-server
    stylua
    jdt-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.eslint
    gopls

    # Hyprland utilities
    hyprshot
    hypridle
    hyprlock
    hyprpaper

    # Desktop utilities
    libnotify
    swaynotificationcenter
    waybar
    wofi
    wl-clipboard

    # GUI applications
    discord
    nautilus

    # Build tools
    cmake

    brightnessctl
    pavucontrol
    networkmanagerapplet
    wget
  ];

  # Environment variables from configuration.nix
  home.sessionVariables = {
  };

  # Program configurations
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      # userName = "Your Name";
      # userEmail = "your@email.com";
    };

    neovim = {
      enable = true;
    };

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
    };

    starship = {
      enable = true;
    };

    home-manager.enable = true;
  };
}
