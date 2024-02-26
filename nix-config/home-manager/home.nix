# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {

    overlays = [

    ];

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "r-dev";
    homeDirectory = "/Users/r-dev";
  };

# Packages
  home.packages = 
  with pkgs; [  

	### Text editor 
	neovim

	### CLI Tools
	btop
	fzf
	fd
	git
	gnumake
	nix-direnv
	platformio
	ripgrep
	starship
	tmux
	zsh-autosuggestions

	### build tools
	cmake
	gcc13
	openjdk
	(python311.withPackages (ps: with ps; [ipython]))
	

 	### File format-specific tools


  ];

 programs = {
    home-manager.enable = true;
	git.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
	};

	};

home.stateVersion = "23.05";
systemd.user.startServices = "sd-switch";

}
