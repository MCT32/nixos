{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = map
        (
          {
            keys,
            dispatcher,
            flags ? { },
          }:
          {
            _args = [
              keys
              (lib.generators.mkLuaInline dispatcher)
              flags
            ];
          }
        )
        [
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + G\"");
            dispatcher = "hl.dsp.exec_cmd(\"grim - | tee ~/Pictures/$(date +'%s_grim.png') | wl-copy\")";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + SHIFT + G\"");
            dispatcher = "hl.dsp.exec_cmd(\"grim -g '$(slurp)' - | tee ~/Pictures/$(date +'%s_grim.png') | wl-copy\")";
          }
        ];
    };
  };
}
