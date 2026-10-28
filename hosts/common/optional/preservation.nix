{
  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [
        { file = "/etc/machine-id"; inInitrd = true; }
      ];
      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/log"
      ];
    };
  };

  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
