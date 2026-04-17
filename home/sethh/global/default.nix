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

  stylix = {
    enable = true;

    fonts = {
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      serif = config.stylix.fonts.sansSerif;

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };

    targets = {
      fontconfig.enable = true;

      vencord = {
        enable = true;
        colors.enable = true;
      };
    };
  };

  fonts.fontconfig.enable = true;

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
