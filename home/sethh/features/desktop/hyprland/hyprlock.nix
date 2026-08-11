{
  lib,
  ...
}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      auth.fingerprint.enabled = true;

      general.hide_cursor = true;
    };
  };

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
            keys = (lib.generators.mkLuaInline "mod .. \" + backspace\"");
            dispatcher = "hl.dsp.exec_cmd(\"hyprlock\")";
          }
        ];
    };
  };
}
