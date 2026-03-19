{ config, pkgs, ... }:

{
  home.username = "sethh";
  home.homeDirectory = "/home/sethh";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kdePackages.kate
    (discord.override {
      withVencord = true;
    })
    obsidian
    jellyfin-desktop
    nerd-fonts.jetbrains-mono
    brightnessctl
  ];
  programs.bash.enable = true;

  programs.tofi = {
    enable = true;
  };

  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = "0.5";
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.waybar = {
    enable = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;

      preload = [
        "~/Pictures/Wallpapers/cathedral.png"
      ];

      wallpaper = [
        ",~/Pictures/Wallpapers/cathedral.png"
      ];
    };
  };

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
      "$menu" = "tofi-drun --drun-launch=true";

      exec-once = [
        "waybar"
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
    };
  };

  home.stateVersion = "25.11";
}
