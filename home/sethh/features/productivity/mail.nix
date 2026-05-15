{
  # TODO: Add more accounts
  accounts.email = {
    maildirBasePath = "Mail";
    accounts.gmail = {
      address = "ivanhen99@gmail.com";
      userName =  "ivanhen99@gmail.com";
      realName = "Seth Henderson";
      primary = true;
      flavor = "gmail.com";

      passwordCommand = ""; # TODO: Add key secret here

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
      };

      neomutt.enable = true;
    };
  };

  programs.mbsync.enable = true;
}
