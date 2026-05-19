{
  osConfig,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 30;
#       output = [
#         "DP-1"
#       ];
        # TODO: Add pomodoro timer
        # TODO: Add unread emails
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "clock" ];
        modules-right = [ "cava" "wireplumber" "bluetooth" "network" "battery" "tray" ];
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "";
        };
        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "browser" = "󰖟";
            "discord" = "";
            "music" = "󰝚";
          } // lib.optionalAttrs osConfig.programs.steam.enable {
            "steam" = "󰓓";
          };
          persistent-workspaces = {
            "browser" = [];
            "discord" = [];
            "music" = [];
          } // lib.optionalAttrs osConfig.programs.steam.enable {
            "steam" = [];
          };
        };
        "cava" = {
          method = "pipewire";
          source = "auto";
          bars = 14;
          bar_delimiter = 0;
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        };
      };
    };

    style = ''
      window#waybar {
        all:unset;
      }

      .modules-left {
        background: alpha(@base00, 0.7);
        margin: 15px 0px 0px 15px;
      }

      .modules-center {
        background: alpha(@base00, 0.7);
        margin: 15px 0px 0px 0px;
      }

      .modules-right {
        background: alpha(@base00, 0.7);
        margin: 15px 15px 0px 0px;
      }
    '';
  };

  stylix.targets.waybar = {
    addCss = false;
  };
}
