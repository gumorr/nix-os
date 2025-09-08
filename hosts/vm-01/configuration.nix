{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/common.nix
  ];

  networking.hostName = "GUMMI-VM-01";

  security.sudo.extraConfig = ''
    # No sudo lecture (System impersistence would result in a lecture every reboot)
    Defaults lecture = never
  '';

  # impermanence
  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/export"
      "/var/lib"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
