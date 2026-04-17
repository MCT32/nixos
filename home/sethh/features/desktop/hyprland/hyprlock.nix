{
  programs.hyprlock = {
    enable = true;

    settings = {
      auth.fingerprint.enabled = true;

      general.hide_cursor = true;
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [ "SUPER,backspace,exec,hyprlock" ];
    };
  };
}
