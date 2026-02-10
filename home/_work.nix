{
  # only import the subset supported by macOS
  imports = [
    ./base.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/helix.nix
    ./shell
  ];

  # corporate mandated
  home.username = "ivan.ostric";
  home.homeDirectory = "/Users/ivan.ostric";

  # TODO: Ghostty is not packaged for macOS in Nix, so we can't use the same
  # config. This should be fixed.
  xdg.configFile."ghostty/config".text = ''
    command = /usr/bin/env zsh -c nu
    font-family = Maple Mono
    font-size = 14
    theme = dark:Catppuccin Macchiato,light:Catppuccin Latte
    macos-option-as-alt = true
  '';
}
