{
  pkgs,
  ...
}:
{
  # TODO: Make these not common
  imports = [
    ./discord.nix
    ./qutebrowser
  ];

  # TODO: Make this not common
  home.packages = with pkgs; [
    jetbrains.idea-oss
    tidal-hifi
    jellyfin-desktop
    vlc
  ];

  # TODO: Move
  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;
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
