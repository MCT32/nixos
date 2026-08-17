{
  # TODO: Add more accounts
  accounts.email = {
    maildirBasePath = "Mail";
    accounts."ivanhen99@gmail.com" = {
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
    accounts."105751853@student.swin.edu.au" = {
      enable = true;
      address = "105751853@student.swin.edu.au";
      userName = "105751853@student.swin.edu.au";
      realName = "Seth Henderson";
      flavor = "outlook.office365.com";

      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };

      thunderbird.enable = true;
    };
  };

  programs.mbsync.enable = true;
}
