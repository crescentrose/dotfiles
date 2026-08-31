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
  # see: https://danklinux.com/docs/dankgreeter/configuration#manual-sync
  programs.dank-material-shell.greeter = {
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
}
