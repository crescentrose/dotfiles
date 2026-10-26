{ pkgs, ... }: {
  # == Fonts ==
  #
  # Include some standard fonts
  fonts.enableDefaultPackages = true;

  # Make fonts render twice as good as Ubuntu but half as good as macOS
  fonts.fontconfig = {
    # fixes pixelation
    antialias = true;

    # fixes antialiasing blur
    hinting.enable = true;

    # fixes height
    subpixel.rgba = "rgb";
  };

  # == Greeter and compositor ==
  #
  # Use Niri as the default compositor
  programs.niri.enable = true;

  # Set up greeter
  # TODO: this also requires some symlinks and ACLs, which is currently manual.
  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/ivan";
  };

  # Suspend the system when the DE signals it is idle
  # ref: https://www.freedesktop.org/software/systemd/man/latest/logind.conf.html
  services.logind.settings.Login = {
    IdleAction = "suspend";
    HandlePowerKey = "suspend";
  };

  # == GTK Fun Zone ==
  #
  # Icons for GTK apps
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    morewaita-icon-theme
  ];

  # Use Sushi to preview files in Nautilus
  services.gnome.sushi.enable = true;

  # Teach Niri about Nautilus
  programs.niri.useNautilus = true;

  # Set up dconf
  programs.dconf.enable = true;

  # Fix problems with icons in GTK apps
  gtk.iconCache.enable = true;

  # Allow inter-app communication
  # The GTK portal can handle most interfaces, while the WLR portal handles screenshots and screen
  # casting for Niri.
  # Notably, neither handle clipboard - seems like only the GNOME portal does that. 😕
  # more info: https://wiki.archlinux.org/title/XDG_Desktop_Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
    pkgs.gnome-keyring
  ];

  xdg.portal.config = {
    niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };

    preferred = {
      default = [
        "gnome"
        "gtk"
      ];
    };
  };
}
