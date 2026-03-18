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
  ];
  programs.bash.enable = true;

  programs.tofi = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
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

      wallpaper = [
        {
          path = "/usr/share/wallpapers/cathedral.png";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = true;

    settings = {
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
      ];
    };
  };

  home.stateVersion = "25.11";
}
