{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.mprisence;
  settingsFormat = pkgs.formats.toml { };
in
{
  options.services.mprisence = {
    enable = lib.mkEnableOption "Highly customizable Discord Rich Presence for MPRIS media players on Linux.";

    package = lib.mkPackageOption pkgs "mprisence" { nullable = true; };

    settings = lib.mkOption {
      default = { };
      description = ''
        mprisence configuration written in Nix. See the example file at
        <https://github.com/lazykern/mprisence/blob/main/config/config.example.toml>.
      '';

    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."mprisence/config.toml" = lib.mkIf (cfg.settings != { }) {
      source = settingsFormat.generate "mprisence-config.toml" cfg.settings;
    };

    systemd.user.services.mprisence = lib.mkIf (cfg.package != null) {
      Unit = {
        Description = "Discord Rich Presence for MPRIS media players";
      };
      Service = {
        ExecStart = "${lib.getExe cfg.package}";
        Restart = "always";
        RestartSec = 10;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
