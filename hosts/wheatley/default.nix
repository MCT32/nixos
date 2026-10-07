{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Hardware configurations
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    ./disko.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/sethh

    ./services/ejabberd
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "wheatley";
    useDHCP = false;

    interfaces.eno1.ipv4.addresses = [
      {
        address = "192.168.0.131";
        prefixLength = 24;
      }
    ];

    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.1" ];
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
}
