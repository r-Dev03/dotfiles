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
			VISUAL = "nvim";
      DOTFILES = "$HOME/.dotfiles/";
      MANPAGER = "nvim +Man!";
    };
  };

	nix = {
		gc = {
			automatic = true;
			frequency = "weekly";
			options = "--delete-older-than 7d";
		};
	};

  # packages
  home.packages = with pkgs; [
    # shell / terminal
    starship
    zsh-autosuggestions

    # CLI Tools
		aerc
    # age
    btop
    bat
    eza
    fastfetch
    fzf
    fd
    git
		gnupg
    gnumake
		lynx
    platformio
    ripgrep
    tmux
    tree
    tealdeer
    yazi
    yq-go
    uv

    # build tools
    cmake
    gcc13
    openjdk
    (python311.withPackages (ps: with ps; [ipython black isort]))
    # nodePackages.pyright

    # file format-specific tools

    # nix
		nixd # nix language server
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
    git.delta.enable = true;

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
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      defaultKeymap = "emacs";

      envExtra = ''
        export PATH=$HOME/.gem/bin:$PATH
      '';
      # export PATH=$HOME/Developer/utils/flutter/

      initExtra = ''
            bindkey '^ ' autosuggest-accept
            bindkey -r '\ec'

        fs() {
        	session=$(find $HOME/dev $HOME/dev/scratch $HOME/.config/ -mindepth 0 -maxdepth 1 -type d | fzf)
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

      '';

      history = {
        size = 10000;
        save = 10000;
        ignoreDups = true;
        expireDuplicatesFirst = true;
        share = true;
      };

      shellAliases = {
        hms = "home-manager switch --flake $HOME/.config/nix-config#r-dev@rdev-mba";
        matlab = "/Applications/MATLAB_R2023b.app/bin/matlab -nodesktop -nosplash";
        dots = "cd ~/.config/";
        dev = "cd ~/Dev/";
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

    git.extraConfig = {
      diff.tool = "nvimdiff";
      difftool.prompt = false;
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

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    starship.enable = true;
  };

  home.stateVersion = "23.05";
  systemd.user.startServices = "sd-switch";
}
