{ pkgs, ... }:
{
  # only import the subset supported by macOS
  imports = [
    ./base.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/ghostty.nix
    ./programs/helix.nix
    ./shell
  ];

  # corporate mandated
  home.username = "ivan.ostric";
  home.directory = "/Users/ivan.ostric";

  # :squints:
  programs.ghostty.settings.font-size = pkgs.mkForce 12;
}
