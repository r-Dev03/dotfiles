{
  config,
  pkgs,
  ...
}: {
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

  programs = {
    git = {
      enable = true;
      userName = "Ribbal Hussain";
      userEmail = "ribbalh0@gmail.com";

      extraConfig = {
        core.askPass = "";
      };
    };

    home-manager.enable = true;
  };
}
