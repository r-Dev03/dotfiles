{
  description = "NixOS Config";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    legacyPackages = forAllSystems (
      system:
        import inputs.nixpkgs {
          inherit system;
          overlays = [
            (import ./pkgs)
            inputs.neovim-nightly-overlay.overlays.default
          ];
          config.allowUnfree = true;
        }
    );
    nixosConfigurations = {
      # Framework Laptop Configuration
      framework = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = legacyPackages."${system}";

        modules = [
          ./host/framework/configuration.nix
          ./host/framework/hardware-configuration.nix
          inputs.stylix.nixosModules.stylix
          nixos-hardware.nixosModules.framework-13-7040-amd

          # Add Home Manager as a module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ron = ./host/base.nix;
          }
        ];
      };
    };
  };
}
