{
  accounts.email = {
    maildirBasePath = "Mail";
    accounts.gmail = {
      address = "ivanhen99@gmail.com";
      userName =  "ivanhen99@gmail.com";
      realName = "Seth Henderson";
      primary = true;
      flavor = "gmail.com";

      passwordCommand = "echo 'qijs lfrb sjcf gzbn'";

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
