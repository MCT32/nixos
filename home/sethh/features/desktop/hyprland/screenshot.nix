{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "SUPER, G, exec, grim - | tee ~/Pictures/$(date +'%s_grim.png') | wl-copy"
        "SUPERSHIFT, G, exec, grim -g \"$(slurp)\" - | tee ~/Pictures/$(date +'%s_grim.png') | wl-copy"
      ];
    };
  };
}
