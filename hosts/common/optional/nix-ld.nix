{
  pkgs,
  ...
}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # TODO: Prune unnecessary libs, or add ryubing unstable to flake
      # Ryujinx
      icu
      libGL
      fontconfig
      freetype
      zlib
      libx11
      libxext
      libxrandr
      libxi
      libxcursor
      libxinerama
      libxfixes
      libice
      libsm
      libpulseaudio
      SDL2
      vulkan-loader
    ];
  };
}
