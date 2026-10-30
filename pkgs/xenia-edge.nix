{ appimageTools, fetchurl }:
let
  pname = "xenia-edge";
  version = "4447343";

  src = fetchurl {
    url = "https://github.com/has207/xenia-edge/releases/download/${version}/xenia_edge_linux.AppImage";
    hash = "sha256-3DGm1+GKnMhHGWn/t5RgdLkNSjfoHX0mdFqkYhtreY8=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mv $out/bin/${pname} $out/bin/xenia_edge

    install -m 444 -D ${appimageContents}/xenia_edge.desktop $out/share/applications/xenia_edge.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/xenia_edge.png \
      $out/share/icons/hicolor/512x512/apps/xenia_edge.png
  '';
}
