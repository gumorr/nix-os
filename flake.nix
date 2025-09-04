# flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      inherit (self) outputs;

      mkNixOSConfig = path: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs;};
          modules = [path];
        };
    in
    {
      nixosConfigurations = {
        GUMMI-DC-TEST = mkNixOSConfig ./hosts/gummi-dc-test/configuration.nix "x86_64-linux";
      };
    };
}
