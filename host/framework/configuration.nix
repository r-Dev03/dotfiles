{
  config,
  pkgs,
  inputs,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = [
    ../../modules/dev.nix
    ../../modules/system.nix
    ../../modules/stylix.nix
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
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
    # pam = {
    #   services = {
    #     greetd.enableGnomeKeyring = true;
    #   };
    # };
  };

  powerManagement = {
    enable = true;
  };

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    fprintd.enable = false;
    displayManager = {
      dms-greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/ron";
      };
    };

    # greetd = {
    #   enable = true;
    #   settings = {
    #     default_session = {
    #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session --remember --asterisks";
    #       user = "greeter";
    #     };
    #   };
    # };

    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
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

    # getty = {
    #   autologinUser = "ron";
    # };

    power-profiles-daemon.enable = true;
    upower.enable = true;

    fwupd.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      browsed = {
        enable = true;
      };
      drivers = [
        pkgs.cups-filters # IPP Everywhere + generic drivers
        pkgs.cups-bjnp # Canon BJNP network support
        pkgs.hplip # HP printers (massive coverage)
        pkgs.epson-escpr # Epson ESC/P-R (lots of EcoTank/WorkForce models)
        pkgs.brlaser # Brother open-source laser drivers
      ];
    };

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
          # internal laptop keyboard (same as before)
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"

          # external IQUNIX keyboard over the USB‑C dock (stable across ports)
          "/dev/input/by-id/usb-RDR_IQUNIX_MG65_Mechanical_Keyboard-event-kbd"

          "/dev/input/by-id/usb-BY_Tech_NuPhy_Halo96-event-kbd"
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

  users = {
    defaultUserShell = pkgs.zsh;
    users.ron = {
      isNormalUser = true;
      useDefaultShell = true;
      description = "ron";
      extraGroups = ["networkmanager" "wheel" "docker"];
    };
  };

  programs = {
    nano.enable = false; # garbage
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      XDG_CURRENT_DESKTOP = "niri";
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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
