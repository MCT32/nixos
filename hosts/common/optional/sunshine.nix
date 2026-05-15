{
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # Needed for wayland
    openFirewall = true;

    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
        }
        {
          name = "Retroarch";
          cmd = "sudo -u sethh retroarch";
          image-path = "desktop.png";
        }
      ];
    };
  };
}
