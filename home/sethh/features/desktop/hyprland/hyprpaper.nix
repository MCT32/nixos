{
  pkgs,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/brands/gruvbox-nix.png";
    sha256 = "18j302fdjfixi57qx8vgbg784ambfv9ir23mh11rqw46i43cdqjs";
  };
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;
      wallpaper = {
        monitor = ""; # All monitors
        path = "${wallpaper}";
      };
    };
  };
}
