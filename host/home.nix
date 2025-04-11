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

    # Build tools
    cmake

    # System
    brightnessctl
    pavucontrol
    networkmanagerapplet
    wget

    # GUI
    discord
    nautilus
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --strip-cwd-prefix";
      defaultOptions = [
        "--height=50%"
        "--layout=reverse"
        "--info=inline"
        "--border"
        "--margin=1"
        "--padding=1"
      ];
      changeDirWidgetCommand = "fd --type d";
      fileWidgetCommand = "fd --type f --strip-cwd-prefix --exclude .git";
    };

    git = {
      enable = true;
      userName = "Ribbal Hussain";
      userEmail = "ribbalh0@gmail.com";
    };

    neovim = {
      enable = true;
    };

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      defaultKeymap = "viins";
      envExtra = ''
      '';

      initExtra = ''
        if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        	exec Hyprland
        		fi

            bindkey '^ ' autosuggest-accept
            bindkey -r '\ec'
      '';

      history = {
        size = 10000;
        save = 10000;
        ignoreDups = true;
        ignoreAllDups = true;
        expireDuplicatesFirst = true;
        share = true;
      };

      shellAliases = {
        ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
        lh = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all";
        la = "eza --color=always --long --git --icons=always";
        mkdir = "mkdir -pv";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -iv";
        vim = "nvim";
      };
    };

    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    home-manager.enable = true;
  };
}
