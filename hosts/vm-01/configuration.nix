{ inputs, config, ... }:
{
  imports = [
    # config for ryzen 4650G
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd

    # host specific config
    ./hardware-configuration.nix
    ./networking.nix

    # modules
    ../../modules/common.nix
    ../../modules/impermanence.nix
  ];

  security.sudo.extraConfig = ''
    # No sudo lecture (Impermanence would result in a lecture every reboot)
    Defaults lecture = never
  '';
}
