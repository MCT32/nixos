{
  imports = [
    ./bios.nix
  ];

  programs.retroarch = {
    enable = true;

    cores = {
      beetle-psx-hw.enable = true;
      mupen64plus.enable = true;
      pcsx2.enable = true;
    };

    settings = {
      video_driver = "vulkan";
      video_fullscreen = "true";

      # Achievements
      cheevos_enable = "true";
      cheevos_username = "MCT32";
      cheevos_password = "";
      cheevos_unlock_sound_enable = "true";
    };
  };
}
