# modules/display.nix
{
  config,
  pkgs,
  ags,
  ...
}: let
  system = "x86_64-linux";
in 
{
  # Display Manager (SDDM)

  services = {
    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
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
environment.systemPackages = (with ags; [packages.${system}.ags]) ++ (with pkgs; [ 
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
  ]);
}

    # (
    #   ags.packages.${system}.ags.override
    #   {
    #     extraPackages = with ags.packages.${system}; [
    #       battery
    #     ];
    #   }
    # )

