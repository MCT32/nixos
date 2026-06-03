{
  imports = [
    ./global

    ./features/art
    ./features/desktop/hyprland
    ./features/desktop/keepassxc
    ./features/gaming
    ./features/pass
    ./features/productivity
    ./features/syncthing
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
