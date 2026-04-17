{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

#   remotePlay.openFirewall = true;
#   dedicatedServer.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    mangohud

    deadlock-mod-manager  # Deadlock mods
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
