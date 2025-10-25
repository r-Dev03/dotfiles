{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Theme
    adwaita-icon-theme

    # Niri / Desktop utilities
    xwayland-satellite
    libnotify
    waybar
    fuzzel
    swaybg
    swayidle
    swaylock
    swayimg
    mako
    jetbrains.idea-ultimate

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
      defaultFonts.monospace = ["Rec Mono Casual"];
    };
  };
}
