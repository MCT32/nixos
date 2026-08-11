{ config, osConfig, lib,
  ...
}: {
  imports = [
    ../common

    ./hyprlock.nix
    ./hyprpaper.nix
    ./mako.nix
    ./screenshot.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = true;

    configType = "lua";

    settings = let
      terminalCmd = "kitty";
    in
    {
      mod = {
        _var = "SUPER";
      };

      terminal = {
        _var = terminalCmd;
      };

      fileManager = {
        _var = "${terminalCmd} -e yazi";
      };

      menu = {
        _var = "rofi -show drun";
      };

      config = {
        general = {
          gaps_in = 7;
          gaps_out = 15;

          border_size = 1;
        };

        decoration = {
          blur.passes = 3;
        };
      };

      monitor = map (m: {
        output = m.name;
        mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position}";
        scale = m.scale;
        disabled = !m.enabled;
      }) (config.monitors);

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
        ([
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + Q\"");
            dispatcher = "hl.dsp.exec_cmd(terminal)";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + C\"");
            dispatcher = "hl.dsp.window.close()";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + M\"");
            dispatcher = "hl.dsp.exec_cmd(\"uwsm stop\")";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + E\"");
            dispatcher = "hl.dsp.exec_cmd(fileManager)";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + V\"");
            dispatcher = "hl.dsp.window.float()";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + R\"");
            dispatcher = "hl.dsp.exec_cmd(menu)";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + P\"");
            dispatcher = "hl.dsp.window.pseudo()";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + J\"");
            dispatcher = "hl.dsp.layout(\"togglesplit\")";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + F\"");
            dispatcher = "hl.dsp.window.fullscreen()";
          }

          # Focus
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + left\"");
            dispatcher = "hl.dsp.focus({direction = \"left\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + right\"");
            dispatcher = "hl.dsp.focus({direction = \"right\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + up\"");
            dispatcher = "hl.dsp.focus({direction = \"up\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + down\"");
            dispatcher = "hl.dsp.focus({direction = \"down\"})";
          }

          # Discord passthrough
          {
            keys = "mouse:275";
            dispatcher = "hl.dsp.pass({window = \"class:^(discord)$\"})";
          }
          {
            keys = "KP_Home";
            dispatcher = "hl.dsp.pass({window = \"class:^(discord)$\"})";
          }
          {
            keys = "KP_Up";
            dispatcher = "hl.dsp.pass({window = \"class:^(discord)$\"})";
          }

          # Mouse
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + mouse:272\"");
            dispatcher = "hl.dsp.window.drag()";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + mouse:273\"");
            dispatcher = "hl.dsp.window.resize()";
          }

          # Media keys
          {
            keys = "XF86AudioRaiseVolume";
            dispatcher = "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")";
            flags = {
              locked = true;
              repeating = true;
            };
          }
          {
            keys = "XF86AudioLowerVolume";
            dispatcher = "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-\")";
            flags = {
              locked = true;
              repeating = true;
            };
          }
          {
            keys = "XF86AudioMute";
            dispatcher = "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")";
            flags = {
              locked = true;
            };
          }
          {
            keys = "XF86AudioMicMute";
            dispatcher = "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")";
            flags = {
              locked = true;
            };
          }
          {
            keys = "XF86MonBrightnessUp";
            dispatcher = "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")";
            flags = {
              locked = true;
              repeating = true;
            };
          }
          {
            keys = "XF86MonBrightnessDown";
            dispatcher = "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")";
            flags = {
              locked = true;
              repeating = true;
            };
          }

          # Workspaces
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + D\"");
            dispatcher = "hl.dsp.focus({workspace = \"name:discord\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + SHIFT + D\"");
            dispatcher = "hl.dsp.window.move({workspace = \"name:discord\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + A\"");
            dispatcher = "hl.dsp.focus({workspace = \"name:browser\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + SHIFT + A\"");
            dispatcher = "hl.dsp.window.move({workspace = \"name:browser\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + T\"");
            dispatcher = "hl.dsp.focus({workspace = \"name:music\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + SHIFT + T\"");
            dispatcher = "hl.dsp.window.move({workspace = \"name:music\"})";
          }
        ] ++ lib.optionals osConfig.programs.steam.enable [
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + S\"");
            dispatcher = "hl.dsp.focus({workspace = \"name:steam\"})";
          }
          {
            keys = (lib.generators.mkLuaInline "mod .. \" + SHIFT + S\"");
            dispatcher = "hl.dsp.window.move({workspace = \"name:steam\"})";
          }
        ] ++ (
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              {
                keys = (lib.generators.mkLuaInline "mod .. \" + code:1${toString i}\"");
                dispatcher = "hl.dsp.focus({workspace = \"${toString ws}\"})";
              }
              {
                keys = (lib.generators.mkLuaInline "mod .. \" + SHIFT + code:1${toString i}\"");
                dispatcher = "hl.dsp.window.move({workspace = \"${toString ws}\"})";
              }
            ]
          )
          9)
        ));

      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline (
            "function()\n"
            + builtins.concatStringsSep "\n" (
              [
                "hl.exec_cmd(\"waybar\")"
                "hl.exec_cmd(\"discord\", {workspace = \"name:discord silent\"})"
                "hl.exec_cmd(\"qutebrowser\", {workspace = \"name:browser silent\"})"
                "hl.exec_cmd(\"tidal-hifi\", {workspace = \"name:music silent\"})"
              ]
              ++ lib.optionals osConfig.programs.steam.enable [
                "hl.exec_cmd(\"steam\", {workspace = \"name:steam silent\"})"
              ]
            )
            + "\nend"
          ))
        ];
      };

      window_rule = [
        {
          match.class = "^(discord)$";
          workspace = "name:discord";
          no_initial_focus = true;
        }
        {
          match.class = "^(org.qutebrowser.qutebrowser)$";
          workspace = "name:browser";
        }
        {
          match.class = "^(tidal-hifi)$";
          workspace = "name:music";
        }
      ] ++ lib.optionals osConfig.programs.steam.enable [
        {
          match.class = "^(discord)$";
          workspace = "name:discord";
          no_initial_focus = true;
        }
      ];
    };
  };
}
