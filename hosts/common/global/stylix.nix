{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    # TODO: Make machine specifiy themes and wallpapers
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    opacity.terminal = 0.7;

    image = ../../../wallpapers/railway.jpg;

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
    };
  };

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    nasin-nanpa-ucsur
    nasin-nanpa-helvetica
  ];
}
