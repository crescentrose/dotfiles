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
    };
  };
}
