{ config, lib, pkgs, ... }:

{
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.

    secretsFile = "/etc/nixos/wireless.conf";

    networks.DsquariusGreenJr = {
      priority = 1;
      psk = "11111111";
    };

    networks.eduroam = {
      priority = 2;
      auth = ''
        key_mgmt=WPA-EAP
        eap=PEAP

        identity="105751853@swin.edu.au"
        password="o4uKc5XM9!LoetbJ6y3Ruznl66oxq"
      '';
    };

    networks."TP-Link_41BC" = {
      priority = 2;
      psk = "94969740";
    };
  };

  # Enable networking
  networking.networkmanager.enable = false;
}
