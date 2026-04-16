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

  fonts.fontconfig.enable = true;

  stylix.targets.vencord = {
    enable = true;
    colors.enable = true;
  };

  home.packages = with pkgs; [
    kdePackages.kate
    (discord.override {
      withVencord = true;
    })
    jellyfin-desktop
    nerd-fonts.jetbrains-mono
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
