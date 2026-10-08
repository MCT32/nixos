{
  pkgs,
  config,
  lib,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.sethh = {
    isNormalUser = true;
    # shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "dialout"
      "docker"
      "libvirtd"
      "scanner"
      "uinput"
      "vboxusers"
      "wpa_supplicant"
      "wheel"
    ];

    shell = pkgs.fish;

    hashedPasswordFile = config.sops.secrets.sethh-password.path;

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDyPBoreZy2k3sBX/53ZYE8B3lHh644bRhI/xBTOlRXmK0z5HnH7E9GV9EX8NNwbLxVleU+67XKFZTs9Q/OGTDOG8zDv9ypqTMm2gk5QqMhETgCJhH2XN5WosSssTDWr05Noj4OpRLRje22HYmR8hFFaIRZDiTkv08RHhHAXc1FMFUSu81qYJB4woEXzGnisUG+6sFiSYRJ2jTNVFiDuKdwiJQYvTF3fB2kU4ds1hyI3haMFNAhEUH6A4zfMWhWMtUBuDkvz2NW/eTltwdPrRTzX2GyK19nFIWu5RhDqhT/0gCxBtO6PqPjLmAbcSGT0aC1VmPzZDQaYPXAPsQ/XKzv phone"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILQTlWwUd0meijmuMF5td0/0OlcaxIm5y3JUTeusK3m5 sethh@sentinel"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP+Il81e31juwUDG1LVcd+dZHSistwdu8178NMemxrYi sethh@eve"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBU3ejdI2PGTv+PXX8eOWXThbc9YuZ54x0Q9EUoJcxnJ mct32@hal9000"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFwQoDsvuZ+k9BkHLeA7NWgkZ6gkIqzgeN6mNBaVHKj/ sethh@wheatley"
    ];

    packages = with pkgs; [
      home-manager
    ];
  };

  # Ensure dialout exists
  users.groups.dialout = { };

  sops.secrets.sethh-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.sethh = import ../../../../home/sethh/${config.networking.hostName}.nix;
}
