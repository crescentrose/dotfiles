{
  services.mako = {
    enable = true;

    settings = {
      font = "Iosevka 12px";
      max-icon-size = 32;

      format = "%s";
      background-color = "#24273a";
      text-color = "#cad3f5";
      border-color = "#1e2030";

      layer = "overlay";
      group-by = "app-name";

      default-timeout = 5000;

      history = 1;
      max-history = 20;

      # If the notification has a body, separate the body and the summary with a line.
      "body~=.+" = {
        format = "%s\\n──\\n%b";
      };

      # If `do-not-disturb` mode is enabled, hide all notifications
      "mode=do-not-disturb" = {
        invisible = 1;
      };

      # If `locked` mode is enabled, do not expire notifications. Keep them all in "limbo".
      "mode=locked" = {
        ignore-timeout = 1;
        default-timeout = 0;
        invisible = 1;
      };
    };
  };
}
