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
  };

  environment.systemPackages = with pkgs; [
    htop
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

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
