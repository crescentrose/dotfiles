{
  # only import the subset supported by macOS
  imports = [
    ./base.nix
    ./programs/git.nix
    ./programs/helix.nix
    ./programs/zed.nix
    ./shell
  ];

  home.username = "crescentrose";
  home.homeDirectory = "/Users/crescentrose";

  # TODO: Ghostty is not packaged for macOS in Nix, so we can't use the same
  # config. This should be fixed.
  xdg.configFile."ghostty/config".text = ''
    command = /usr/bin/env zsh -c nu
    font-family = Maple Mono
    font-size = 14
    theme = dark:Catppuccin Macchiato,light:Catppuccin Latte
    macos-option-as-alt = true
  '';

  programs.ssh = {
    enable = true;

    # Default host config
    settings = {
      "Host *" = {
        IdentityAgent = "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      };
    };

    # Fix deprecation warning
    enableDefaultConfig = false;
  };
}
