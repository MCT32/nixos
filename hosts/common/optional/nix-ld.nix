{
  pkgs,
  ...
}:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # TODO: Prune unnecessary libs, or add ryubing unstable to flake
      # Ryujinx
      atk
      cairo
      gdk-pixbuf
      glib
      gtk3
      harfbuzz
      icu
      libGL
      fontconfig
      freetype
      zlib
      libx11
      libxcb
      libxcb-wm
      libxext
      libxrandr
      libxi
      libxcursor
      libxinerama
      libxfixes
      libice
      libgbm
      libsm
      libpulseaudio
      libusb1
      libxkbcommon
      hidapi
      nspr
      nss
      pango
      SDL2
      vulkan-loader
      wayland
    ];
  };
}
