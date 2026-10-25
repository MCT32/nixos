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
        settings = {
          # Must be whitelisted in HTTPS-Only exceptions, cant be done declaritively
          "browser.startup.homepage" = "http://hal9000/";
        };

        userChrome = ''
          #TabsToolbar { display: none !important; }
          #sidebar-header { display: none !important; }
          #sidebar-panel-header { display: none !important; }
          #sidebar-splitter { display: none !important; }
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
