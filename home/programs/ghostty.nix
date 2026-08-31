# TODO: Ghostty is not packaged for macOS in Nix, so we can't use the same
# config. This should be fixed.
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "dark:Catppuccin Macchiato,light:Catppuccin Latte";
      font-family = "Maple Mono NF";
      font-size = 12;
      command = "/usr/bin/env nu";
      app-notifications = "no-clipboard-copy,no-config-reload";

      # send a desktop notification when a long running task is complete
      notify-on-command-finish = "unfocused";
      notify-on-command-finish-action = "no-bell,notify";

      # eyecandy, maybe distracting? tbd
      background-opacity = 0.9;
      background-blur = 20;
    };
  };
}
