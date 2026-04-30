{
  config,
  ...
}: {
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        "eve" = { id = "QCQDKVS-IZTQANC-JAS2GF5-DHQTLQ4-GXJ4A5A-4NK3LI3-DTCEXXC-WWXNMQ5"; };
        "SM-G780F" = { id = "4SR3NFH-SH6IUJW-IKWWPI3-R4GRH3C-OFZWDMT-R5OWJQA-5X6ZYMX-DTTTDAD"; };
      };

      folders = {
        "DailyNotes" = {
          path = "~/Documents/DailyNotes";
          # For globally shared folders
          devices = builtins.attrNames config.services.syncthing.settings.devices;
        };
      };
    };
  };
}
