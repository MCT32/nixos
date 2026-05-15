{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false; # FIXME: Should this be here or in global config?
  users.users.sethh = {
    isNormalUser = true;
    # shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "docker"
      "libvirtd"
      "scanner"
      "vboxusers"
      "wpa_supplicant"
      "wheel"
    ];

    shell = pkgs.fish;  # FIXME: Does this mean i dont need to include the package elsewhere?

    hashedPasswordFile = config.sops.secrets.sethh-password.path;

    packages = with pkgs; [
      home-manager  # FIXME: Is this required?
    ];
  };

  sops.secrets.sethh-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.sethh = import ../../../../home/sethh/${config.networking.hostName}.nix;
}
