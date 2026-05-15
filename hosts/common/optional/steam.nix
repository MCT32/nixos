{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

    # TODO: Consider opening remotePlay
#   remotePlay.openFirewall = true;
#   dedicatedServer.openFirewall = true;

    extraCompatPackages = with pkgs; [
      # TODO: See if there are other proton versions to add
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    # TODO: Configure mangohud
    mangohud

    # TODO: Probably not needed for every machine with steam
    deadlock-mod-manager  # Deadlock mods
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
