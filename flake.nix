# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";
    agenix.url = "github:ryantm/agenix";
  };
  outputs = { self, nixpkgs, ... } @ inputs:
    let
      inherit (self) outputs;

      mkNixOSConfig = system: path:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs;};
          modules = [ path ];
        };
    in
    {
      nixosConfigurations = {
        GUMMI-VM-01 = mkNixOSConfig "x86_64-linux" ./hosts/vm-01/configuration.nix;
      };
    };
}
