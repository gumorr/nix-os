{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../../modules/common.nix
  ];

  networking.hostName = "GUMMI-DC-TEST";
}
