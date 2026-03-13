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

  # Custom sequences for the compose key (right ctrl)
  home.file.".XCompose" = {
    enable = true;
    text = ''
      include "%L"

      # Emoji

      <Multi_key> <colon> <parenright>                     : "🙂"  # smile
      <Multi_key> <colon> <D>                              : "😀"  # millennial laugh
      <Multi_key> <X> <D>                                  : "😂"  # boomer laugh
      <Multi_key> <T> <underscore> <T>                     : "😭"  # zoomer laugh
      <Multi_key> <X> <underscore> <X>                     : "💀"  # gen alpha laugh
      <Multi_key> <B> <parenright>                         : "😎"  # cool
      <Multi_key> <u> <w> <u>                              : "🥺"  # uwu
      <Multi_key> <plus> <1>                               : "👍"  # thumbs up
      <Multi_key> <minus> <1>                              : "👎"  # thumbs down
      <Multi_key> <6> <7>                                  : "🤷"  # shrug
      <Multi_key> <less> <3>                               : "♥"   # basic heart
      <Multi_key> <less> <less> <3>                        : "❤️"  # red heart
      <Multi_key> <colon> <less> <3>                       : "💜"  # purple heart
      <Multi_key> <asterisk> <asterisk>                    : "✨"  # sparkles

      # Arrows

      <Multi_key> <minus> <less>                           : "←"
      <Multi_key> <minus> <greater>                        : "→"
      <Multi_key> <minus> <asciicircum>                    : "↑"
      <Multi_key> <minus> <v>                              : "↓"
      <Multi_key> <minus> <minus> <v>                      : "↴"
      <Multi_key> <minus> <minus> <less>                   : "↲"

      # Misc

      <Multi_key> <minus> <minus>                          : "‒" # the not-em dash
    '';
  };
}
