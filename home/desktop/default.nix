{ pkgs, ... }:
{
  # Contains stuff pertaining to the Year of the Linux Desktop
  imports = [
    ./audio.nix
    ./apps.nix
    ./bar.nix
    ./idle.nix
    ./gtk.nix
    ./notifications.nix
    ./portal.nix
    ./wallpaper.nix
    ./window-manager.nix
  ];

  # Enable system authentication for unprivileged apps
  services.polkit-gnome.enable = true;

  # Include basic packages
  home.packages = with pkgs; [
    glib # gtk config
    waybar # status bar
    wl-clipboard # copy and paste
    wtype # automate writing (for inserting emojis)
    xwayland-satellite # xwayland outside wayland
    blueberry # bluetooth settings
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

    # fonts
    cascadia-code
    inter
    departure-mono
    iosevka
    liberation_ttf # replacements for common MS fonts
    noto-fonts
    noto-fonts-cjk-sans
    twitter-color-emoji # 🤓

    # icons
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    morewaita-icon-theme
    font-awesome
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig.defaultFonts.emoji = [ "Twitter Color Emoji" ];
}
