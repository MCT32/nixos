{
  # TODO: Actually set this up and evaluate whether i need it
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };
}
