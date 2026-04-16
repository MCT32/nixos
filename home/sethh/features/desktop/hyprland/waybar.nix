{
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
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "wireplumber" "bluetooth" "network" "battery" "clock" "tray" ];
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
            "steam" = "󰓓";
            "music" = "󰝚";
          };
          persistent-workspaces = {
            "browser" = [];
            "discord" = [];
            "steam" = [];
            "music" = [];
          };
        };
      };
    };
  };
}
