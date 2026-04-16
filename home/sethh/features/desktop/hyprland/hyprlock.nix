{
  programs.hyprlock = {
    enable = true;

    settings = {
      auth.fingerprint.enabled = true;
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [ "SUPER,backspace,exec,hyprlock" ];
    };
  };
}
