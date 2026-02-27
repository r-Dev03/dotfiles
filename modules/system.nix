{pkgs, inputs, ...}: {

  # services.noctalia-shell = {
  #   enable = true;
  # };

  environment.systemPackages = with pkgs; [
    # Theme
    adwaita-icon-theme

    # Niri / Desktop utilities
    niri
    xwayland-satellite
    libnotify
    waybar
    fuzzel
    rofi
    swaybg
    swayidle
    swayimg
    mako
    inputs.noctalia.packages.${pkgs.system}.default

    # System
    brightnessctl
    pavucontrol
    networkmanagerapplet
    udiskie
    wget
    bluez

    # GUI
    discord
    google-chrome
    evince
  ];

  programs = {
    firefox.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      rec-mono
      font-awesome
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.blex-mono
      nerd-fonts.symbols-only
      nerd-fonts.commit-mono
    ];
    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = ["Recursive Sn Lnr St"]; 
        monospace = ["Rec Mono Casual"];
      };
    };
  };
}
