{
  config,
  ...
}: {
  imports = [
    ../common

    ./hyprpaper.nix
    ./mako.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = true;

    settings = {
      general = {
        gaps_in = 7;
        gaps_out = 15;

        border_size = 1;
      };

      "$mod" = "SUPER";

      "$terminal" = "kitty";
      "$fileManager" = "$terminal -e yazi";
      "$menu" = "rofi -show drun";

      exec-once = [
        "waybar"
        "[workspace name:discord silent] discord"
        "[workspace name:browser silent] qutebrowser"
        "[workspace name:steam silent] steam"
        "[workspace name:music silent] tidal-hifi"
      ];

      windowrule= [
        "workspace name:discord, match:class ^(discord)$"
        "no_initial_focus on, match:class ^(discord)$"
        "workspace name:browser, match:class ^(org.qutebrowser.qutebrowser)$"
        "workspace name:steam, match:class ^(steam)$"
        "no_initial_focus on, match:class ^(steam)$"
        "workspace name:music, match:class ^(tidal-hifi)$"
      ];

      bind = [
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exec, command -v hyprshutdown >/dev/null 2>%1 && hyprshutdown || hyprctl dispatch exit"
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating,"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo,"
        "$mod, J, layoutmsg, togglesplit"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Passthrough for discord global hotkeys
        ", mouse:275, pass, class:^(discord)$"
        ", KP_Home, pass, class:^(discord)$"
        ", KP_Up, pass, class:^(discord)$"

        # Binds for named workspaces
        "$mod, D, workspace, name:discord"
        "$mod SHIFT, D, movetoworkspace, name:discord"
        "$mod, A, workspace, name:browser"
        "$mod SHIFT, A, movetoworkspace, name:browser"
        "$mod, S, workspace, name:steam"
        "$mod SHIFT, S, movetoworkspace, name:steam"
        "$mod, T, workspace, name:music"
        "$mod SHIFT, T, movetoworkspace, name:music"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      monitor = map (m: "${m.name},${
        if m.enabled
        then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},${toString m.scale}"
        else "disable"
      }") (config.monitors);
    };
  };
}
