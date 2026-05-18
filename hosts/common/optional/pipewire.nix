{
  config,
  pkgs,
  ...
}: {
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;  # Enable wireplumber for device nicknames and declaritive routing
  };

  # Per-device device nicknames
  services.pipewire.wireplumber.extraConfig = {
    "alsa-nicknames" = {
      "monitor.alsa.rules" = map (d: {
        matches = [ { "node.name" = d.name; } ];
        actions = {
          update-props = {
            "node.nick" = d.nick;
            "node.description" = d.nick;
          };
        };
      }) config.audio-devices.nicknames;
    };
  };

  # Extra audio packages
  environment.systemPackages = with pkgs; [
    pavucontrol
    crosspipe
  ];
}
