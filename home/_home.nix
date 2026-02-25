{
  pkgs,
  ragenix,
  ...
}:
{
  imports = [
    ragenix.homeManagerModules.default
    ./base.nix
    ./programs/git.nix
    ./programs/ssh.nix
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

      # I do not want to compile macOS versions from scratch
      # TODO: Extract out
      pkgs.kubernetes-helm
      pkgs.vault
      pkgs.terraform
      pkgs.terraform-ls

      # Resource monitor
      pkgs.btop
    ];

    username = "ivan";
    homeDirectory = "/home/ivan";
  };
}
