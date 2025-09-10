{ inputs, config, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

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

  # agenix needs to be pointed to persistent location for ssh keys
  age.identityPaths = [ "/nix/persist/etc/ssh/ssh_host_rsa_key" "/nix/persist/etc/ssh/ssh_host_ed25519_key" ];
}
