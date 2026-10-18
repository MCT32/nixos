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
      libxext
      libxrandr
      libxi
      libxcursor
      libxinerama
      libxfixes
      libice
      libsm
      libpulseaudio
      libusb1
      hidapi
      pango
      SDL2
      vulkan-loader
    ];
  };
}
