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
    pkgs.euphonica # music
    pkgs.foliate # ebook
    pkgs.mangohud # FPS, temp monitor
    zen-browser.packages."x86_64-linux".default # firefoxn't
  ];
}
