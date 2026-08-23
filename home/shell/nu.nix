{ config, ... }:
{
  programs.nushell = {
    enable = true;

    settings = {
      show_banner = false;
      completions.external = {
        enable = true;
        max_results = 200;
      };

      cursor_shape.emacs = "line";

      history.file_format = "sqlite";
      history.isolation = true;

      use_kitty_protocol = true;
    };

    environmentVariables = {
      EDITOR = "hx";
      BAT_THEME = "ansi";
      NH_FLAKE = "${config.home.homeDirectory}/Code/dotfiles";
    };

    extraEnv = ''
      $env.NU_LIB_DIRS ++= ["${config.xdg.dataHome}/scripts/lib"]
      $env.PATH ++= ["${config.xdg.dataHome}/scripts/bin"]
    '';

    extraConfig = ''
      use pm switch # for fast swap between directories
    '';
  };
}
