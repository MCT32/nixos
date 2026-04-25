{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    opacity.terminal = 0.7;

    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/pixelart/brown_city_planet_w.jpg";
      sha256 = "0mqhjyzbfs59a6zwfrjf39fmvrgpfi433s3s3rc79i7afi348k5n";
    };

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
}
