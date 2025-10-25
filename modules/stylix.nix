{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = {
      system = "base16";
      name = "Aki";
      author = "ron";
      variant = "dark";
      palette = {
        base00 = "#101317"; # background (darkest)
        base01 = "#22232E"; # selection_foreground/tab_bar_background
        base02 = "#2C2D39"; # color0 (black)
        base03 = "#454756"; # color8 (bright black)
        base04 = "#D1CEC9"; # color7 (white)
        base05 = "#E4E1DD"; # foreground (lightest)
        base06 = "#99A3C2"; # inactive_border_color
        base07 = "#BDC3E6"; # lightened periwinkle (more distinct from base06)
        base08 = "#CA6D73"; # color1 (red)
        base09 = "#E6C193"; # color3 (yellow/orange)
        base0A = "#B4C7A7"; # color2 (green)
        base0B = "#9BC2B1"; # mark3_background (teal)
        base0C = "#7EB3C9"; # color4 (blue)
        base0D = "#7BC2DF"; # color12 (bright blue)
        base0E = "#AD8DBD"; # color5 (magenta/purple)
        base0F = "#8D6B94"; # darker purple (derived from AD8DBD)
      };
    };

    polarity = "dark";
    fonts.monospace = {
      name = "Rec Mono Casual";
      package = pkgs.rec-mono;
    };

    fonts.sansSerif = {
      name = "Rec Mono Casual";
      package = pkgs.rec-mono;
    };

    fonts.serif = {
      name = "Rec Mono Casual";
      package = pkgs.rec-mono;
    };

    targets.gtk.enable = true;
  };
}
