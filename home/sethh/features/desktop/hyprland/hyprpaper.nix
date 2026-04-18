{
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      #splash = true;
    };
  };
}
