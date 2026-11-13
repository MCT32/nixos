{
  inputs,
  self,
  config,
  ...
}:
let
  inherit (self) outputs;
in
{
  flake.nixosConfigurations.wheatley = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.wheatley ];
  };

  flake.modules.nixos.wheatley =
    { lib, ... }:
    {
      imports = [
        config.flake.modules.nixos.base

        inputs.hardware.nixosModules.common-cpu-intel
        inputs.hardware.nixosModules.common-pc-ssd
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.preservation

        ../../hosts/common/global
        ../../hosts/common/users/sethh

        # Optionals
        ../../hosts/common/optional/preservation.nix

        ../../hosts/wheatley/services/ejabberd
      ];

      # TODO: Make common
      boot = {
        # Bootloader.
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "ums_realtek"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      networking = {
        hostName = "wheatley";
        useDHCP = false;

        interfaces.eno1.ipv4.addresses = [
          {
            address = "192.168.0.131";
            prefixLength = 24;
          }
        ];

        defaultGateway = "192.168.0.1";
        nameservers = [ "192.168.0.1" ];
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      disko.devices.disk = {
        disk0 = {
          type = "disk";
          device = "/dev/disk/by-id/wwn-0x500a07511581f454";
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
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  subvolumes = {
                    "/@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };

      # TODO: See whats already handled by nix-hardware
      hardware = {
        enableRedistributableFirmware = true;
      };
    };
}
