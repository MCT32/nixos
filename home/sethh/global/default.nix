{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../features/cli
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = "sethh";
  home.homeDirectory = "/home/sethh";

  home.packages = with pkgs; [
    jellyfin-desktop
    brightnessctl
  ];

  programs.rofi = {
    enable = true;
  };

  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = false;
  };

  home.stateVersion = "25.11";
}
