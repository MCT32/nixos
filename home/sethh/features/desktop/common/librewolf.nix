{
  pkgs,
  ...
}:
{
  programs.librewolf = {
    enable = true;

    profiles = {
      default = {
        extensions = {
          force = true;

          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            sidebery
            tridactyl
          ];
        };

        userChrome = ''
          #TabsToolbar { display: none !important; }
          #sidebar-header { display: none !important; }
          #sidebar-box { padding-inline-start: 0px !important; }
          * { border-radius: 0px !important; }
        '';
      };
    };
  };

  stylix.targets.librewolf = {
    profileNames = [ "default" ];

    colorTheme.enable = true;
  };
}
