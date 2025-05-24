{
  config,
  pkgs,
  inputs,
  ags,
  ...
}: let
  system = "x86_64-linux";
in {
  nixpkgs.config.allowUnfree = true;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  stylix = {
    enable = true;
    base16Scheme = {
      system = "base16";
      name = "Aki";
      author = "Your Name";
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
      name = "Commit Mono";
      package = pkgs.commit-mono;
    };

    fonts.sansSerif = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
    };

    fonts.serif = {
      name = "Liberation Serif";
      package = pkgs.liberation_ttf;
    };

    fonts.emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji;
    };
    targets.gtk.enable = true;
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "framework"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_TIME = "en_US.UTF-8";
  };

  xdg.portal.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.sddm.enableGnomeKeyring = true;
  };

  powerManagement = {
    enable = true;
  };

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
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

    power-profiles-daemon.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=suspend
      HandlePowerKeyLongPress=poweroff
    '';

    fwupd.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    kanata = {
      enable = true;
      keyboards.internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          "/dev/input/by-path/pci-0000:c3:00.4-usb-0:1.1.4:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:c3:00.4-usb-0:1.1.4:1.2-event-kbd"
        ];

        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            caps lalt lmeta ralt
          )

          (defalias
            ;; Caps Lock: Esc on tap, Ctrl on hold
            caps-ctrl (tap-hold-press 150 150 esc lctrl)
            ;; Swap Left Alt and Left Super (Meta)
            lalt-swap lmeta
            lmeta-swap lalt
          )

          (deflayer base
            @caps-ctrl @lalt-swap @lmeta-swap ralt
          )
        '';
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.ron = {
      isNormalUser = true;
      useDefaultShell = true;
      description = "ron";
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  programs = {
    nano.enable = false; # garbage
    zsh.enable = true;
    git.enable = true;

    hyprland = {
      enable = true;
      # xwayland.enable = true;
    };
  };

  environment = {
    systemPackages =
      (with ags; [packages.${system}.ags])
      ++ (with pkgs; [
        coreutils
        vim
      ]);

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
      # MOZ_ENABLE_WAYLAND = 1;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  fonts = {
    enableDefaultPackages = true; # Include default system fonts for fallback
    packages = with pkgs; [
      font-awesome
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.blex-mono
      nerd-fonts.symbols-only
      nerd-fonts.commit-mono
    ];
    fontconfig = {
      enable = true; # Enable Fontconfig for system-wide font settings
      defaultFonts = {
        monospace = ["Commit Mono"]; # Set default monospace font
        sansSerif = ["JetBrains Mono"]; # Example sans-serif fallback
        serif = ["Liberation Serif"]; # Example serif fallback
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
