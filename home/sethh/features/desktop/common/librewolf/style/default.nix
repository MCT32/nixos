{
  config,
  lib,
  ...
}:
{
  imports = [
  ];

  programs.librewolf.profiles.default = {
    userChrome = ''
      #TabsToolbar { display: none !important; }
      #sidebar-header { display: none !important; }
      #sidebar-panel-header { display: none !important; }
      #sidebar-splitter { display: none !important; }
      #sidebar-box { padding-inline-start: 0px !important; }
      * { border-radius: 0px !important; }
    '';

    userContent = ''
      * { border-radius: 0px !important; }
      :root {
    ''
    + lib.concatLines (
      builtins.genList (
        i:
        let
          hex = lib.fixedWidthString 2 "0" (lib.toHexString i);
        in
        "--base${hex}: ${config.lib.stylix.colors.withHashtag."base${hex}"};"
      ) 24
    )
    + "}";
  };
}
