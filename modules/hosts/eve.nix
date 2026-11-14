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
  flake.nixosConfigurations.eve = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ config.flake.modules.nixos.eve ];
  };

  flake.modules.nixos.eve =
    { lib, ... }:
    {
      imports = [
        config.flake.modules.nixos.base

        config.flake.modules.nixos.hyprland

        inputs.hardware.nixosModules.common-gpu-intel
        inputs.hardware.nixosModules.common-cpu-intel
        inputs.hardware.nixosModules.common-pc-ssd

        ../../hosts/common/global
        ../../hosts/common/users/sethh

        # Optionals
        ../../hosts/common/optional/localsend.nix
        ../../hosts/common/optional/pipewire.nix
        ../../hosts/common/optional/printing.nix
        ../../hosts/common/optional/virtualbox.nix
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
            "xhci_pci"
            "ahci"
            "usb_storage"
            "sd_mod"
            "rtsx_pci_sdmmc"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ ];
        extraModulePackages = [ ];
      };

      networking = {
        hostName = "eve";
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

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      # TODO: Add audio devices

      # TODO: Consider managing with disko
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/f10b4da3-1e08-468f-84b3-a8d24ebc63f8";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/E94B-9EBD";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      # TODO: Might also be configurable via disko
      swapDevices = [
        { device = "/dev/disk/by-uuid/80d7e674-29f4-4803-88bd-63a99c4cca06"; }
      ];

      # TODO: See whats already handled by nix-hardware
      hardware = {
        enableRedistributableFirmware = true;
      };
    };
}
