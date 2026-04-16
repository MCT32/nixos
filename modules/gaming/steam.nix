{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

#   remotePlay.openFirewall = true;
#   dedicatedServer.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    wayvr
    mangohud
  ];

  # Extra dependencies for steamVR
  programs.steam.package = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [ 
      libcap 
      procps
      usbutils
      xorg.xrandr      # SteamVR uses this for display detection
      polkit            # needed for some privilege escalation dialogs
      gtk3              # settings window is a GTK app
      webkitgtk_4_1    # SteamVR settings uses an embedded browser
      nss        # <-- this is the fix
      nspr       # <-- companion lib, often needed alongside nss
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
