{
  pkgs,
  ...
}: {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;

    drivers = with pkgs; [
      gutenprint
    ];
  };

  # Scanning
  hardware.sane.enable = true;
}
