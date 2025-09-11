{ config, ... }:
{
  virtualisation.incus.enable = true;
  users.users.local-admin.extraGroups = [ "incus-admin" ];
}
