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
    noctalia
    dsearch

    # System
    pavucontrol
    powertop
    # bottles
    wget

    # GUI
    discord
    google-chrome
    evince
  ];

  programs = {
    niri.enable = true;
    firefox.enable = true;
    # fuse.userAllowOther = true;
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
