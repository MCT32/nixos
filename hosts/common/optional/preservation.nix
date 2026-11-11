{
  lib,
  pkgs,
  ...
}:
{
  preservation = {
    enable = true;
    preserveAt."/persist" = {
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];
      directories = [
        "/var/lib/systemd/timers"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
        "/var/log"
        {
          directory = "/etc/nixos";
          user = "sethh";
          group = "wheel";
          mode = "0755";
        }
      ];
    };
  };

  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

  # Rollback
  boot.initrd.systemd.services.rollback-root = {
    description = "Archive and reset btrfs root";
    wantedBy = [ "initrd.target" ];
    requires = [ "dev-mapper-crypted.device" ];
    after = [
      "dev-mapper-crypted.device"
      "systemd-cryptsetup@crypted.service"
    ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      export PATH=${lib.makeBinPath [
        pkgs.btrfs-progs pkgs.coreutils pkgs.findutils pkgs.util-linux
      ]}:$PATH
      set -eu

      mkdir -p /btrfs_tmp
      mount -o subvolid=5 /dev/mapper/crypted /btrfs_tmp
      mkdir -p /btrfs_tmp/old_roots

      delete_subvolume_recursively() {
        btrfs subvolume list -o "$1" | cut -f 9- -d ' ' | while read -r sub; do
          delete_subvolume_recursively "/btrfs_tmp/$sub"
        done
        btrfs subvolume delete "$1"
      }

      if [ -e /btrfs_tmp/rootfs ]; then
        stamp=$(date "+%Y-%m-%d_%H-%M-%S")
        mv /btrfs_tmp/rootfs "/btrfs_tmp/old_roots/$stamp"
        touch "/btrfs_tmp/old_roots/$stamp"
      fi

      find /btrfs_tmp/old_roots -maxdepth 1 -mindepth 1 -mtime +30 |
        while read -r old; do
          delete_subvolume_recursively "$old"
        done

      btrfs subvolume create /btrfs_tmp/rootfs
      umount /btrfs_tmp
    '';
  };
}
