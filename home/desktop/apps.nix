{ pkgs, zen-browser, ... }:
{
  # Desktop applications
  home.packages = [
    pkgs.thunderbird # email
    pkgs.ghostty # terminal
    pkgs.obsidian # notes
    pkgs.prismlauncher # the children yearn for the mines
    pkgs.slack # work, work
    pkgs.qbittorrent # yarr
    pkgs.feishin # music
    pkgs.tauon # music
    pkgs.foliate # ebook
    pkgs.mangohud # FPS, temp monitor
    pkgs.qFlipper # flipper UI
    pkgs.gnome-disk-utility # partition
    pkgs.gnome-boxes # VMs
    pkgs.lrcget # download lyrics for music files
    zen-browser.packages."x86_64-linux".default # firefoxn't
  ];
}
