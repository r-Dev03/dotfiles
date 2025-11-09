{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = {
      system = "base16";
      name = "Aki";
      author = "ron";
      variant = "dark";
      palette = {
        base00 = "#101317"; # background (darkest) - bg
        base01 = "#1c1c24"; # selection_foreground/tab_bar_background - inactiveBg
        base02 = "#252530"; # color0 (black) - line
        base03 = "#454756"; # color8 (bright black) - visual
        base04 = "#D1CEC9"; # color7 (white) - fg
        base05 = "#c3c3d5"; # foreground (lightest) - property
        base06 = "#99A3C2"; # inactive_border_color - hint
        base07 = "#90a0b5"; # operator (distinct from base06)
        base08 = "#b48484"; # color1 (red) - parameter/error
        base09 = "#C3AD8B"; # color3 (yellow/orange) - warning/delta
        base0A = "#B4C7A7"; # color2 (green) - plus
        base0B = "#8f9e9b"; # mark3_background (teal) - string
        base0C = "#9bb4bc"; # color4 (blue) - type
        base0D = "#797ea3"; # color12 (bright blue) - keyword/builtin
        base0E = "#ad8dbd"; # color5 (magenta/purple) - func/number
        base0F = "#615D7D"; # darker purple - search
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
