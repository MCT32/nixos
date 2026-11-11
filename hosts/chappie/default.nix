{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Hardware configurations
    inputs.hardware.nixosModules.framework-amd-ai-300-series
    ./disko.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/sethh

    ../common/optional/pipewire.nix
    ../common/optional/preservation.nix
    ../common/optional/wireless.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "chappie";
    useDHCP = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "au,de";
  #   variant = "";
  #   options = "grp:alt_shift_toggle";
  # };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  sops.age.keyFile = "/persist/home/sethh/.config/sops/age/keys.txt";
}
