{
  disko.devices.disk = {
    disk0 = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-KINGSTON_SNV3S1000G_50026B768764CA90";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              passwordFile = "/tmp/secret.key";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                mountpoint = "/";
                mountOptions = [ "compress=zstd" "noatime" ];
                subvolumes = {
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd"  "noatime" ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress=zstd"  "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
