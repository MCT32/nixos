{
  pkgs,
  config,
  lib,
  ...
}: {
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wpa_supplicant_gui
  ];

  # Get wireless secrets from sops
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    group = "wpa_supplicant";
    mode = "0440";
  };

  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.

    # Allow temporary wifi connections
    userControlled = true;
    allowAuxiliaryImperativeNetworks = true;

    secretsFile = config.sops.secrets.wireless.path;

    # Mobile hotspot
    networks.DsquariusGreenJr = {
      pskRaw = "ext:hotspot";
    };

    # University
   networks.eduroam = {
     auth = ''
       key_mgmt=WPA-EAP
       eap=PEAP

       identity="105751853@swin.edu.au"
       password=ext:eduroam
     '';
   };

    # Home
    networks."TP-Link_41BC" = {
      pskRaw = "ext:home";
    };

    # Grandparents
    networks."Aussie Broadband 8674" = {
      pskRaw = "ext:grandparents";
    };
  };

  users.groups.wpa_supplicant = {};
}
