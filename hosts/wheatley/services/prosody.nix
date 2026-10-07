let
  domainName = "mct32.xyz";
in
{
  services.prosody = {
    enable = true;
    admins = [ "admin@${domainName}" ];
    allowRegistration = false;
    authentication = "internal_plain";
    s2sSecureAuth = true;
    c2sRequireEncryption = true;
    modules = {
      admin_adhoc = false;
      cloud_notify = false;
      pep = false;
      blocklist = false;
      dialback = false;
      ping = false;
      private = false;
      register = false;
      vcard_legacy = false;
    };
    xmppComplianceSuite = false;

    virtualHosts = {
      "vhost" = {
        domain = "${domainName}";
        enabled = true;
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      5222
      5223
    ];
  };
}
