{
  # TODO: Add more accounts
  accounts.email = {
    maildirBasePath = "Mail";
    accounts.gmail = {
      enable = true;
      address = "ivanhen99@gmail.com";
      userName =  "ivanhen99@gmail.com";
      realName = "Seth Henderson";
      primary = true;
      flavor = "gmail.com";

      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
      };

      thunderbird.enable = true;
    };
  };

  programs.mbsync.enable = true;
}
