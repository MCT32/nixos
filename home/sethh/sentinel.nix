{
  imports = [
    ./global

    ./features/art
    ./features/desktop/hyprland
    ./features/desktop/keepassxc
    ./features/desktop/obs.nix
    ./features/desktop/tagstudio.nix
    ./features/dev
    ./features/gaming
    ./features/pass
    ./features/productivity
    ./features/reverse_engineering
    ./features/syncthing
    ./features/udiskie
  ];

  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      workspace = "1";
      primary = true;
    }
  ];
}
