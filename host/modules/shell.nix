# modules/shell.nix
{
  config,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.zsh;
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
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
  };

  environment = {
    systemPackages = with pkgs; [
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
      zsh-autosuggestions

      # flavours
    ];
  };
}
