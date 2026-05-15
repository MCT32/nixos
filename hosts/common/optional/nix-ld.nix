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
      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXi
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXfixes
      xorg.libICE
      xorg.libSM
      libpulseaudio
      SDL2
      vulkan-loader
    ];
  };
}
