{
  lib,
  config,
  osConfig,
  ...
}: {
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        "eve" = { id = "QCQDKVS-IZTQANC-JAS2GF5-DHQTLQ4-GXJ4A5A-4NK3LI3-DTCEXXC-WWXNMQ5"; };
        "sentinel" = { id = "6GCXGWE-TV6XRWF-QOLYKAJ-NUF2SMC-2YHMNAL-GQCRZTH-T63ELTI-5DRKAQY"; };
        "SM-G780F" = { id = "4SR3NFH-SH6IUJW-IKWWPI3-R4GRH3C-OFZWDMT-R5OWJQA-5X6ZYMX-DTTTDAD"; };
      };

      folders = {
        "DailyNotes" = {
          path = "~/Documents/DailyNotes";
          # For globally shared folders
          devices = builtins.attrNames config.services.syncthing.settings.devices;
        };

        "Games" = {
          enable = osConfig.networking.hostName == "eve"
            || osConfig.networking.hostName == "sentinel";

          path = "~/Games";
          devices = [ "eve" "sentinel" ];
        };
      };
    };
  };

  # PS2 memory cards
  systemd.user.tmpfiles.rules = 
    lib.mkIf config.programs.retroarch.enable
      [
        "L ${config.home.homeDirectory}/.config/retroarch/system/pcsx2/memcards - - - - ${config.home.homeDirectory}/Games/Memcards"
      ];
}
