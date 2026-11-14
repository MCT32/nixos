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
  flake.nixosConfigurations.sentinel = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.sentinel ];
  };

  flake.modules.nixos.sentinel =
    { lib, ... }:
    {
      imports = [
        config.flake.modules.nixos.base

        config.flake.modules.nixos.hyprland

        inputs.hardware.nixosModules.common-gpu-nvidia
        inputs.hardware.nixosModules.common-cpu-amd
        inputs.hardware.nixosModules.common-pc-ssd

        ../../hosts/common/global
        ../../hosts/common/users/sethh

        # Optionals
        ../../hosts/common/optional/docker.nix
        ../../hosts/common/optional/flatpak.nix
        ../../hosts/common/optional/heroic.nix
        ../../hosts/common/optional/steam.nix
        ../../hosts/common/optional/localsend.nix
        ../../hosts/common/optional/nix-ld.nix
        ../../hosts/common/optional/pipewire.nix
        ../../hosts/common/optional/printing.nix
        ../../hosts/common/optional/sunshine.nix
        ../../hosts/common/optional/virt-manager.nix
        ../../hosts/common/optional/virtualbox.nix
        ../../hosts/common/optional/vr.nix
        ../../hosts/common/optional/waydroid.nix
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
            "ahci"
            "usbhid"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      networking = {
        hostName = "sentinel";
        useDHCP = true;
      };

      services = {
        # TODO: Make a feature
        displayManager = {
          sddm = {
            enable = true;
          };
          defaultSession = "hyprland";
        };

        # TODO: See if i can remove
        xserver = {
          enable = true;
          # TODO: Add to nvidia feature
          videoDrivers = [ "nvidia" ];
        };
      };

      nix = {
        # TODO: Make a feature
        settings = {
          substituters = [ "https://cache.nixos-cuda.org" ];
          trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
        };
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      audio-devices = {
        nicknames = [
          {
            "name" = "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output";
            "nick" = "Headphones";
          }
          {
            "name" = "alsa_output.pci-0000_09_00.1.hdmi-stereo";
            "nick" = "Monitor";
          }
          {
            "name" = "alsa_output.pci-0000_0b_00.4.analog-stereo";
            "nick" = "Motherboard";
          }
          {
            "name" = "alsa_input.usb-0c76_USB_PnP_Audio_Device-00.mono-fallback";
            "nick" = "Desk Microphone";
          }
          {
            "name" = "alsa_input.usb-XHT-5693-20092_Webcam_01.00.00-02.analog-stereo";
            "nick" = "Webcam Microphone";
          }
          {
            "name" = "alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-input";
            "nick" = "DAC Input";
          }
          {
            "name" = "alsa_input.pci-0000_0b_00.4.analog-stereo";
            "nick" = "Motherboard";
          }
        ];
      };

      # TODO: Consider managing with disko
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/acbd6f8b-210c-4fdf-a757-765b9c2da9be";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/47AE-0798";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        "/mnt/ssd" = {
          device = "/dev/disk/by-uuid/18256384-7007-4856-8884-8b18e03e4953";
          fsType = "ext4";
        };
      };

      # TODO: Might also be configurable via disko
      swapDevices = [ ];

      # TODO: See whats already handled by nix-hardware
      hardware = {
        enableRedistributableFirmware = true;

        graphics = {
          enable = true;
          enable32Bit = true;
        };

        nvidia = {
          open = true;
          modesetting.enable = true;
          prime.offload.enable = false;
        };
      };
    };
}
