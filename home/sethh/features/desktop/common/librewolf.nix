{
  pkgs,
  ...
}:
# TODO: Clean up; split into subconfigs and use functions
let
  containers = {
    entertainment = {
      color = "red";
      icon = "chill";
      id = 1;
    };
  };
in
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
            multi-account-containers
            cookie-autodelete
            sponsorblock          # TODO: Configure settings
            enhancer-for-youtube  # TODO: Configure settings
          ];

          settings = {
            "@testpilot-containers".settings = {
              "siteContainerMap@@_www.youtube.com" = {
                userContextId = toString containers.entertainment.id;
                neverAsk = false;
                hostname = "www.youtube.com";
              };
              "siteContainerMap@@_youtu.be" = {
                userContextId = toString containers.entertainment.id;
                neverAsk = false;
                hostname = "youtu.be";
              };
            };

            "CookieAutoDelete@kennydo.com".settings = {
              state = builtins.toJSON {
                settings = {
                  # Clear cookies by default
                  activeMode = {
                    name = "activeMode";
                    value = true;
                  };
                  # Enable container support
                  contextualIdentities = {
                    name = "contextualIdentities";
                    value = true;
                  };
                  contextualIdentitiesAutoRemove = {
                    name = "contextualIdentitiesAutoRemove";
                    value = true;
                  };
                };

                lists = {
                  "firefox-container-${toString containers.entertainment.id}" = [
                    {
                      expression = "*.youtube.com";
                      listType = "WHITE";
                      storeId = "firefox-container-${toString containers.entertainment.id}";
                    }
                    {
                      expression = "*.google.com";
                      listType = "WHITE";
                      storeId = "firefox-container-${toString containers.entertainment.id}";
                    }
                  ];
                };
              };
            };
          };
        };

        settings = {
          # Must be whitelisted in HTTPS-Only exceptions, cant be done declaritively
          "browser.startup.homepage" = "http://hal9000/";

          # Disable cookie clearing, handled by extension instead
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown.cookies" = false;
        };

        containersForce = true;
        inherit containers;

        userChrome = ''
          #TabsToolbar { display: none !important; }
          #sidebar-header { display: none !important; }
          #sidebar-panel-header { display: none !important; }
          #sidebar-splitter { display: none !important; }
          #sidebar-box { padding-inline-start: 0px !important; }
          * { border-radius: 0px !important; }
        '';

        userContent = ''
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
