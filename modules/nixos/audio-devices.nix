{
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.audio-devices.nicknames = mkOption {
    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog    -stereo-output";
          };
          nick = mkOption {
            type = types.str;
            example = "Headphones";
          };
        };
      }
    );
    default = [];
  };
  # options.audio-devices.disableOthers = mkOption {
  #   type = types.booleans;
  #   default = false;
  # };
}
