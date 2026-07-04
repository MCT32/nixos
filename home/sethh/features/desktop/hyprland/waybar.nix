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
        modules-right = [ "wireplumber" "bluetooth" "network" "battery" "tray" "group/system" ];

        # -- LEFT SIDE --
        clock = {
          format = "{:%H:%M %a %d %b}";
        };

        "group/system" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
            click-to-reveal = true;
          };
          modules = [ "custom/system-arrow" "cpu" "memory" "disk" ];
        };

        "custom/system-arrow" = {
          format = "󰍹 ";
        };

        # System info
        cpu = {
          interval = 10;
          format = "{}%  ";
          max-length = 10;
        };
        memory = {
          interval = 30;
          format = "{used:0.1f}G/{total:0.1f}G  ";
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

      .modules-left {
        margin: 15px 0px 0px 15px;
      }

      .modules-center {
        margin: 15px 0px 0px 0px;
        padding: 0px 15px;
      }

      .modules-right {
        margin: 15px 15px 0px 0px;
      }

      #workspaces {
        background: @base00;
      }

      #clock {
        background: @base00;
        padding: 0px 15px;
      }

      #system {
        background: @base00;
        padding: 0px 15px;
      }
    '';
  };

  stylix.targets.waybar = {
    addCss = false;
  };
}
