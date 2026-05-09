{
  pkgs,
  ...
}: {
  services.wivrn = {
    enable = true;
    openFirewall = true;

    steam = {
      importOXRRuntimes = true;
    };

    config = {
      enable = false;
      json = {
        encoder = {
          # TODO: Get GPU encoder working
          encoder = "h264";
          codec = "h264";
        };

        application = [ pkgs.wayvr ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    xrizer
  #   wayvr
  ];

  # programs.alvr = {
  #   enable = true;
  #   openFirewall = true;
  # };
}
