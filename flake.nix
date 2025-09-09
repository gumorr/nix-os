# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";
    agenix.url = "github:ryantm/agenix";
  };
  outputs = { self, nixpkgs, nixos-hardware, impermanence, agenix, ... } @ inputs:
    let
      inherit (self) outputs;

      mkNixOSConfig = system: modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs;};
          inherit modules;
        };
    in
    {
      nixosConfigurations = {
        GUMMI-VM-01 = mkNixOSConfig "x86_64-linux" [
          # config for ryzen 4650G
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-gpu-amd

          # enable system impermanence
          impermanence.nixosModules.impermanence

          # secret management
          agenix.nixosModules.default

          ./hosts/vm-01/configuration.nix
        ];
      };
    };
}
