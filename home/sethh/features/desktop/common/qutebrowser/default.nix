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
      home = "http://hal9000/";
    };

    settings = {
      content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36";

      url.start_pages = [ "http://hal9000/" ];
    };
  };
}
