{ config, ... }:
{
  users.users.local-admin.extraGroups = [ "incus-admin" ];

  virtualisation.incus = {
    enable = true;

    preseed = {
      profiles = [
        # default profile, bridged to management vlan
        {
          name = "default";
          devices = {
            eth0 = {
              name = "eth0";
              nictype = "bridged";
              parent = "br0";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              size = "32GiB";
              type = "disk";
            };
          };
        }

        # storage profile, bridged to storage vlan
        {
          name = "storage";
          devices = {
            eth0 = {
              name = "eth0";
              nictype = "bridged";
              parent = "br1";
              type = "nic";
            };
            root = {
              path = "/";
              pool = "default";
              size = "32GiB";
              type = "disk";
            };
          };
        }

      ];
      storage_pools = [
        {
          name = "default";
          driver = "dir";
          config = {
            source = "/var/lib/incus/storage-pools/default";
          };
        }
      ];
    };
  };
}
