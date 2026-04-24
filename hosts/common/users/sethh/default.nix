{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.sethh = {
    isNormalUser = true;
    # shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "docker"
      "scanner"
      "wpa_supplicant"
      "wheel"
    ];

    shell = pkgs.fish;

    hashedPasswordFile = config.sops.secrets.sethh-password.path;

    packages = with pkgs; [
      home-manager
    ];
  };

  sops.secrets.sethh-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.sethh = import ../../../../home/sethh/${config.networking.hostName}.nix;
}
