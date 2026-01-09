{ pkgs, ragenix, ... }:
{
  imports = [
    ragenix.homeManagerModules.default
    ./base.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/walker.nix
    ./programs/mpd.nix
    ./programs/discord.nix
    ./programs/ghostty.nix
    ./programs/helix.nix
    ./programs/zed.nix
    ./desktop
    ./shell
  ];

  # keep up with the French
  programs.discordAccel.enable = true;

  home = {
    packages = [
      ragenix.packages."x86_64-linux".default
      # TODO: Extract out
      pkgs.kubernetes-helm
      pkgs.vault
    ];

    username = "ivan";
    homeDirectory = "/home/ivan";
  };
}
