{ ragenix, ... }:
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
    ./desktop
    ./shell
  ];

  # keep up with the French
  programs.discordAccel.enable = true;

  home = {
    packages = [ ragenix.packages."x86_64-linux".default ];

    username = "ivan";
    homeDirectory = "/home/ivan";
  };
}
