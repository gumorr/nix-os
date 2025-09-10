{ inputs, config, pkgs, ... }:
{
  imports = [
    # secret management
    inputs.agenix.nixosModules.default
  ];

  # use grub as bootloader
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # local admin account
  users.users.local-admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets."passwords/local-admin".path;
  };

  age = {
    # identityPaths = [ "/nix/persist/etc/ssh/ssh_host_rsa_key" "/nix/persist/etc/ssh/ssh_host_ed25519_key" ];
    secrets."passwords/local-admin".file = ../secrets/passwords/local-admin.age;
  };

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
