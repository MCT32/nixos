{
  programs.qutebrowser = {
    enable = true;

    searchEngines = {
      # Wikis
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      nw = "https://wiki.nixos.org/w/index.php?search={}";
      aw = "https://wiki.archlinux.org/?search={}";
      mn = "https://mynixos.com/search?q={}";

      gh = "https://github.com/search?q={}&type=repositories";

      yt = "https://www.youtube.com/results?search_query={}";

      ddg = "https://duckduckgo.com/?q={}";
      DEFAULT = "https://duckduckgo.com/?q={}";
    };

    quickmarks = {
      gh = "https://github.com";
      yt = "https://youtube.com";

      # Home server
      home = "http://192.168.0.238/";
    };

    settings = {
      # TODO: Change to chrome linux for best compatibility
      # Required to log in to google
      content.headers.user_agent = "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135";
    };
  };
}
