{
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
  };

  # Extra audio packages
  environment.systemPackages = with pkgs; [
    pavucontrol
    crosspipe
  ];
}
