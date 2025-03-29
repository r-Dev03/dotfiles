{
  description = "NixOS Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Latest packages
    nixos-hardware.url = "github:NixOS/nixos-hardware"; # Optional for hardware-specific configs
  };

  outputs = { 
    self,
    nixpkgs, 
    nixos-hardware, 
    ... 
  }: 
  {
    nixosConfigurations = {
      # Framework Laptop Configuration
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/framework/configuration.nix
          ./host/framework/hardware-configuration.nix

          # Hardware support for Framework laptop (optional)
          nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };

      # Desktop PC Configuration 
      # desktop = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./host/desktop/configuration.nix
      #     ./host/desktop/hardware-configuration.nix
      #   ];
      # };
    };
  };
}

