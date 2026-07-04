{
  imports = [
    ./global

    ./features/art
    ./features/cli/wireless
    ./features/desktop/hyprland
    ./features/desktop/keepassxc
    ./features/gaming/retroarch
    ./features/pass
    ./features/productivity
    ./features/syncthing
    ./features/udiskie
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 2736;
      height = 1824;
      scale = 2.0;
      workspace = "1";
      primary = true;
    }
  ];
}
