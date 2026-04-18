{
  config,
  pkgs,
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
    (discord.override {
      withVencord = true;
    })
    jellyfin-desktop
    brightnessctl
  ];

  programs.rofi = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = false;
  };

  home.stateVersion = "25.11";
}
