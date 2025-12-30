{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.discordAccel;
in
{
  options.programs.discordAccel = {
    enable = lib.mkEnableOption "The cursed online chat app.";
    package = lib.mkPackageOption pkgs "discord" { nullable = true; };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # Enable hardware acceleration in Discord, which is disabled by default because of reasons only
    # known to Mr. John Discord himself
    xdg.desktopEntries.discord = {
      categories = [
        "Network"
        "InstantMessaging"
      ];
      exec = "discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy";
      genericName = "All-in-one cross-platform voice and text chat for gamers";
      icon = "discord";
      mimeType = [ "x-scheme-handler/discord" ];
      name = "Discord";
      type = "Application";
      terminal = false;
    };
  };
}
