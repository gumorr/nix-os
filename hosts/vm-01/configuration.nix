{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/common.nix
  ];

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

  # networking
  networking = {
    hostName = "GUMMI-VM-01";

    nftables.enable = true;
    useDHCP = false;

    # common firewall settings
    firewall = {
      enable = true;

      allowedTCPPorts = [
        22
      ];
      allowedUDPPorts = [
        22
      ];

      interfaces = {
        "br0" = {
          allowedTCPPorts = [
            53
            67
            547
          ];
          allowedUDPPorts = [
            53
            67
            547
          ];
        };

        "br1" = {
          allowedTCPPorts = [
            53
            67
            547
          ];
          allowedUDPPorts = [
            53
            67
            547
          ];
        };
      };
    };

    # network bridge config
    bridges = {
      # bridge for management vlan
      br0 = {
        interfaces = [ "enp35s0" ];
      };
      # bridge for storage vlan
      br1 = {
        interfaces = [ "enp36s0" ];
      };
    };
    interfaces = {
      br0 = {
        useDHCP = true;
      };
      br1 = {
        useDHCP = true;
      };
    };
  };
}
