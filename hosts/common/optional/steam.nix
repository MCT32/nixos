{ pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;

      # TODO: Consider opening remotePlay
      remotePlay.openFirewall = true;
      #   dedicatedServer.openFirewall = true;

      protontricks.enable = true;

      extraCompatPackages = with pkgs; [
        # TODO: See if there are other proton versions to add
        proton-ge-bin
      ];
    };

    gamemode.enable = true;
    gamescope.enable = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    # TODO: Configure mangohud
    mangohud

    # TODO: Probably not needed for every machine with steam
    deadlock-mod-manager # Deadlock mods
  ];
}
