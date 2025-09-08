# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }
  outputs = { self, nixpkgs, impermanence, ... } @ inputs:
    let
      inherit (self) outputs;

      mkNixOSConfig = system: modules
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs;};
          inherit modules;
        };
    in
    {
      nixosConfigurations = {
        GUMMI-VM-01 = mkNixOSConfig "x86_64-linux" [
          # ryzen 4650G
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-gpu-amd

          impermanence.nixosModules.impermanence

          ./hosts/vm-01/configuration.nix
        ];
      };
    };
}
