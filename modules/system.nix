{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Theme
    adwaita-icon-theme

    # Niri / Desktop utilities
    xwayland-satellite
    dsearch

    # System
    pavucontrol
    udiskie
    wget

    # GUI
    discord
    google-chrome
    evince
  ];

  programs = {
    niri.enable = true;
    firefox.enable = true;
    dms-shell = {
      enable = true;
      systemd.enable = true;
      enableSystemMonitoring = true;
      enableDynamicTheming = false;
      enableAudioWavelength = false;
      enableCalendarEvents = false;
      enableClipboardPaste = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      rec-mono
      google-fonts
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
