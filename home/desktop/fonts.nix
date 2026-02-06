{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cascadia-code
    inter
    departure-mono
    iosevka
    liberation_ttf # replacements for common MS fonts
    maple-mono.truetype
    maple-mono.NF-unhinted
    noto-fonts
    noto-fonts-cjk-sans
    twitter-color-emoji # 🤓
    font-awesome
    nerd-fonts.symbols-only
  ];

  # Let Fontconfig know about the fonts we just installed
  fonts.fontconfig = {
    enable = true;
    defaultFonts.emoji = [ "Twitter Color Emoji" ];
  };
}
