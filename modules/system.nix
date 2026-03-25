{pkgs,inputs, ...}: {
  environment.systemPackages = with pkgs; [
    # Theme
    adwaita-icon-theme

    # Niri / Desktop utilities
    niri
    xwayland-satellite
    inputs.dsearch.packages.${pkgs.system}.default

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
    firefox.enable = true;

    dank-material-shell = {
      enable = true;

      systemd = {
        enable = false; # Systemd service for auto-start
      };

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      # enableVPN = true; # VPN management widget
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      # enableAudioWavelength = true; # Audio visualizer (cava)
      # enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
      dgop.package = inputs.dgop.packages.${pkgs.system}.default;
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
