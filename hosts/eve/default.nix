{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Hardware configurations
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ./audio.nix

    ../common/global
    ../common/users/sethh

    ../common/optional/localsend.nix
    ../common/optional/pipewire.nix
    ../common/optional/wireless.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking= {
    hostName = "eve";
    useDHCP = true;
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
    # TODO: Switch away from sddm, maybe make this an optional
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "hyprland-uwsm";
  };
  # services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "au,de";
  #   variant = "";
  #   options = "grp:alt_shift_toggle";
  # };

  # Enable CUPS to print documents.
  # TODO: Maybe make this global/optional
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # TODO: Make an optional
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # TODO: Make global
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # TODO: Make global
  environment.systemPackages = with pkgs; [
    git
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
