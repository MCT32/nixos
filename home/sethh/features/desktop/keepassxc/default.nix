{
  programs.keepassxc = {
    enable = true;

    # TODO: Configure further
    settings = {
      Browser = {
        Enabled = true;
      };
      GUI = {
        AdvancedSettings = true;
        ApplicationTheme = "classic";
        CompactMode = true;
        HidePasswords = true;
      };
      SSHAgent = {
        Enabled = false;
      };
    };
  };
}
