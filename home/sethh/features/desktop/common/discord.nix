{
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    discord = {
      vencord.enable = false;
      equicord.enable = true;
      krisp.enable = true;
    };

    # sitelen pona stuff
    quickCss = ''
      :root {
          /* Force ONLY Helvetica. If you include gg sans here, ligatures will break */
          --font-primary: "Helvetica" !important;
          --font-display: "Helvetica" !important;
          --font-headline: "Helvetica" !important;
          --font-code: "Helvetica", monospace !important;
        }

        /* Strict instructions to kick Electron's layout rules into feature substitution mode */
        body, textarea, input, button, select, span, div, ::placeholder {
          font-family: "Helvetica" !important;
          font-feature-settings: "liga" on, "clig" on !important;
          font-variant-ligatures: common-ligatures discretionary-ligatures !important;
          text-rendering: optimizeLegibility !important;
        }
    '';

    config = {
      useQuickCss = true;

      # TODO: Add more plugins
      plugins = {
        fakeNitro.enable = true;
      };
    };
  };
}
