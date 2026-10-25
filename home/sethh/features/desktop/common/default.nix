{
  pkgs,
  ...
}:
{
  # TODO: Make these not common
  imports = [
    ./discord.nix
    ./librewolf.nix
    ./qutebrowser
  ];

  # TODO: Make this not common
  home.packages = with pkgs; [
    tidal-hifi
    jellyfin-desktop
    vlc
  ];

  # TODO: Move
  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;

    settings = {
      remember_window_size = false;
    };
  };

  # TODO: Move
  programs.rofi = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };
}
