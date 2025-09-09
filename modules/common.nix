{ inputs, config, pkgs, ... }:
{
  # use grub as bootloader
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  # local admin account
  users.users.local-admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "test";
    # hashedPasswordFile = config.age.secrets."passwords/local-admin".path;
  };

  age.secrets."passwords/local-admin".file = ../secrets/passwords/local-admin.age;
  age.identityPaths = [ "/nix/persist/etc/ssh/ssh_host_rsa_key" "/nix/persist/etc/ssh/ssh_host_ed25519_key" ];

  # security
  security.sudo.execWheelOnly = true;
  nix.settings.allowed-users = [ "@wheel" ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # packages
  environment.systemPackages = with pkgs; [
    htop
  ];

  time.timeZone = "America/Central";

  # so i dont have kitty terminfo errors
  environment.enableAllTerminfo = true;

  # only used for vm
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
      graphics = false;
    };
  };

  system.stateVersion = "25.05";
}
