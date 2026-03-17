{ config, pkgs, ... }:

{
  home.username = "sethh";
  home.homeDirectory = "/home/sethh";

  home.packages = with pkgs; [
    kdePackages.kate
    (discord.override {
      withVencord = true;
    })
    obsidian
    jellyfin-desktop
  ];
  programs.bash.enable = true;

  home.stateVersion = "25.11";
}
