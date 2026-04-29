{
  lib,
  config,
  ...
}: {
  imports = [
    ./bios.nix
  ];

  programs.retroarch = {
    enable = true;

    cores = {
      beetle-psx-hw.enable = true;
      mupen64plus.enable = true;
      nestopia.enable = true;
      pcsx2.enable = true;
    };

    settings = {
      video_driver = "vulkan";
      video_fullscreen = "true";

      # Achievements
      cheevos_enable = "true";
      cheevos_username = "MCT32";
      cheevos_unlock_sound_enable = "true";
    };
  };

  sops.secrets.retroachievements = {
    sopsFile = ../../../../../hosts/common/secrets.yaml;
  };

  # Patch config file with secret
  home.activation.patchRetroarchConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    cfg=~/.config/retroarch/retroarch.cfg
    password="$(cat ${config.sops.secrets.retroachievements.path})"
    line="cheevos_password = \"$password\""

    if grep -q '^cheevos_password' "$cfg"; then
      sed -i "s|^cheevos_password.*|$line|" "$cfg"
    else
      echo "$line" >> "$cfg"
    fi
  '';
}
