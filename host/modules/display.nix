# modules/display.nix
{
  config,
  pkgs,
  ...
}: {
  # Display Manager (SDDM)

  services = {
    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm; # Use Qt6 version
    };

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    xserver = {
      displayManager.lightdm.enable = false; # garbage
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    getty = {
      autologinUser = "ron";
    };
  };

  programs = {
    firefox.enable = true;

    hyprland = {
      enable = true;
      # xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Add the Catppuccin SDDM theme package
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "JetBrains Mono";
      fontSize = "13";
      # background = ./wallpaper.png; # Path to your wallpaper
      loginBackground = true;
    })

    # Hyprland
    hyprshot
    hypridle
    hyprlock
    hyprpaper
    libnotify
    swaynotificationcenter
    waybar
    wofi
    wl-clipboard

    # GUI
    discord
  ];
}
