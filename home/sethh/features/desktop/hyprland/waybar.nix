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
        height = 50;
#       output = [
#         "DP-1"
#       ];
        # TODO: Add pomodoro timer
        # TODO: Add unread emails
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" "bluetooth" "network" "battery" "tray" ];

        # -- LEFT SIDE --
        clock = {
          format = "{:%H:%M %a %d %b}";
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "";
        };
        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon} ";
          format-icons = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "browser" = "󰖟 ";
            "discord" = " ";
            "music" = "󰝚 ";
          } // lib.optionalAttrs osConfig.programs.steam.enable {
            "steam" = "󰓓 ";
          };
          persistent-workspaces = {
            "browser" = [];
            "discord" = [];
            "music" = [];
          } // lib.optionalAttrs osConfig.programs.steam.enable {
            "steam" = [];
          };
        };
      };
    };

    style = ''
      * {
        color: @base05;
        font-family: "FiraCode", "Symbols Nerd Font", monospace;
        font-weight: bold;
      }

      window#waybar {
        all:unset;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        margin: 15px 15px 0px 15px;
      }

      .modules-left {
      }

      .modules-center {
      }

      .modules-right {
      }

      #workspaces,
      #clock,
      #wireplumber,
      #bluetooth,
      #network,
      #battery,
      #tray {
        background: @base00;
        margin: 0px 5px;
        padding: 0px 15px;
      }

      #workspaces button.active {
        color: @base0D;
      }
    '';
  };

  stylix.targets.waybar = {
    addCss = false;
  };
}
