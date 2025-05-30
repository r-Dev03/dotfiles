{
  description = "NixOS Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Latest packages
    nixos-hardware.url = "github:NixOS/nixos-hardware"; # Optional for hardware-specific configs
    ags.url = "github:aylur/ags";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    ags,
    home-manager,
    ...
  }@inputs: let 
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
          overlays = [(import ./pkgs)];
          config.allowUnfree = true;
        }
    );
    nixosConfigurations = {
      # Framework Laptop Configuration
      framework = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = legacyPackages."${system}";
        specialArgs = {
          inherit ags;
        };
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
            home-manager.users.ron = ./host/home.nix;
          }
        ];
      };
    };
  };
}
