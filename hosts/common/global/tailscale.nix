{
  config,
  lib,
  ...
}: {
  sops.secrets.tailscale-key = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  services.tailscale = {
    enable = true;
    #useRoutingFeatures = lib.mkDefault "client";
    authKeyFile = config.sops.secrets.tailscale-key.path;
  };
}
