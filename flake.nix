{
  description = "NixOS Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Latest packages
    nixos-hardware.url = "github:NixOS/nixos-hardware"; # Optional for hardware-specific configs
    ags.url = "github:aylur/ags";

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
  }: {
    nixosConfigurations = {
      # Framework Laptop Configuration
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit ags;
        };
        modules = [
          ./host/framework/configuration.nix
          ./host/framework/hardware-configuration.nix
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
