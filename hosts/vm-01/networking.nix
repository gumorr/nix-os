{ inputs, config, pkgs, ... }:
{
  # networking
  networking = {
    hostName = "GUMMI-VM-01";

    nftables.enable = true;
    useDHCP = false;

    # common firewall settings
    firewall = {
      enable = true;

      # external ports
      allowedTCPPorts = [
        22
      ];
      allowedUDPPorts = [
        22
      ];

      # bridges need to be trusted for incus vms
      trustedInterfaces = [ "br0" "br1" ];
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
