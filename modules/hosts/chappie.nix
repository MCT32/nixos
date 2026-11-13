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
  flake.nixosConfigurations.chappie = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.chappie ];
  };

  flake.modules.nixos.chappie =
    { lib, ... }:
    {
      imports = [
        inputs.hardware.nixosModules.framework-amd-ai-300-series
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.preservation

        ../../hosts/common/global
        ../../hosts/common/users/sethh

        # Optionals
        ../../hosts/common/optional/pipewire.nix
        ../../hosts/common/optional/preservation.nix
        ../../hosts/common/optional/wireless.nix
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
            "nvme"
            "xhci_pci"
            "thunderbolt"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      networking = {
        hostName = "chappie";
        useDHCP = true;
      };

      services = {
        # TODO: Make a feature
        displayManager = {
          sddm = {
            enable = true;
            # TODO: Remove after dendritic refactor
            wayland.enable = true;
          };
          defaultSession = "hyprland";
        };
      };

      nix = {
        settings = {
          # TODO: Make common
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

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
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/rootfs" = {
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/persist" = {
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
      };

      fileSystems."/persist".neededForBoot = true;

      # TODO: Add to feature
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      # TODO: See whats already handled by nix-hardware
      hardware = {
        enableRedistributableFirmware = true;
      };

      # TODO: Move keyFile
      sops.age.keyFile = "/persist/home/sethh/.config/sops/age/keys.txt";
    };
}
