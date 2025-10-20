{

  config,
  pkgs,

  ...
}: {
  # Basic user details
  home.username = "ron";
  home.homeDirectory = "/home/ron";
  home.stateVersion = "24.05";

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  stylix = {
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    targets = {
      neovim.enable = false;
      wofi.enable = false;
      tmux.enable = false;
      vim.enable = false;
      wezterm.enable = false;
      starship.enable = false;
      fzf.enable = false;
      waybar.enable = false;
      kitty.enable = false;
      ghostty.enable = false;
    };
  };

  home.packages = with pkgs; [
    # Shell tools
    aerc
    # age
    btop
    bat
    eza
    evince
    fd
    gnupg
    gnumake
    ghostty
    kitty
		mycli
    neofetch
    ripgrep
    stow
    tmux
    tree
    tealdeer
    uv
    unzip
    wezterm
		yq-go

    # language servers & formatters
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


    # theme stuff
    adwaita-icon-theme

    # Niri / Desktop utilities
		xwayland-satellite
    libnotify
    waybar
		fuzzel
		swaybg
		swayidle
		swaylock
		mako
		jetbrains.idea-ultimate

    # Build tools
    cmake

    # System
    brightnessctl
    pavucontrol
    networkmanagerapplet
    udiskie
    wget

    # GUI
    discord
    nautilus
    google-chrome
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    firefox = {
      enable = true;
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

			extraConfig = {
			 core.askPass = "";
			};

    };

    neovim = {
      enable = true;
    };

    swayimg = {
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
				bindkey '^ ' autosuggest-accept
				bindkey -r '\ec'
				bindkey -rM emacs '\ec'
				bindkey -rM viins '\ec'
				bindkey -rM vicmd '\ec'



				fs() {
					session=$(find ~/code ~/dotfiles -mindepth 1 -maxdepth 1 -type d \( -name '.git' -prune \) -o -type d -print | sed "s|^$HOME/||" | fzf)
						session_name=$(basename "$session" | tr . _)

						if ! tmux has-session -t "$session_name" 2> /dev/null; then
							tmux new-session -d -s "$session_name" -c "$session"
								fi

								if [[ -z $TMUX ]]; then
									tmux attach-session -t $session_name
								else
									tmux switch-client -t $session_name
										fi
				}


fn() {
  # If called with -r or --rescan, refresh Wi‑Fi list first
  if [[ "$1" == "-r" || "$1" == "--rescan" ]]; then
    nmcli device wifi rescan >/dev/null
  fi

  # Show the same table style as before and let fzf select
  nmcli device wifi list \
    | tail -n +2 \
    | fzf \
    | awk '{print $1}' \
    | xargs -r nmcli device wifi connect
}
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
        open = "xdg-open";
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
