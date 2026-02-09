{ pkgs, dms, ... }:
{
  # Contains stuff pertaining to the Year of the Linux Desktop
  imports = [
    dms.homeModules.dank-material-shell
    ./audio.nix
    ./apps.nix
    ./fonts.nix
    ./gtk.nix
    ./portal.nix
    ./window-manager.nix
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
  };

  # Enable system authentication for unprivileged apps
  services.polkit-gnome.enable = true;

  # Include basic packages
  home.packages = with pkgs; [
    glib # gtk config
    wl-clipboard # copy and paste
    wtype # automate writing (for inserting emojis)
    xwayland-satellite # xwayland outside wayland
    v4l-utils # webcam settings
    libnotify # for notify-send

    # Fine, I Will Use Gnome Apps
    celluloid # video player
    decibels # audio player
    evince # document viewr
    gnome-calculator
    gnome-calendar
    gnome-maps
    gnome-weather
    gnome-text-editor
    loupe # image viewer
    nautilus # file browser
    newsflash # rss
    video-trimmer # if only all apps were named this consistently
  ];
}
