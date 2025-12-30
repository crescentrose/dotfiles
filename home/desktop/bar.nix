{ lib, pkgs, ... }:
{
  xdg.configFile."waybar".source = ../../resources/waybar;

  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Environment = "$PATH:${lib.makeBinPath [ pkgs.imagemagick ]}";
      ExecStart = "${pkgs.waybar}/bin/waybar";
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
    };
  };
}
