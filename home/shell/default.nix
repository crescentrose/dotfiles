{ pkgs, ... }:
{
  imports = [
    ./developer.nix
    ./nu.nix
    ./ripgrep.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    # cli apps
    bat # nicer cat
    broot # trees
    dig # it's always DNS
    fastfetch # r/unixporn bait
    fortune # wisdom
    gh # github client
    imagemagick # magic of the image variety
    difftastic # syntax-aware diff
    jujutsu # fine, i will try it...

    # developer tools
    agebox # secret
    age # more secret
    lefthook # git hooks
  ];

  xdg.dataFile."scripts".source = ../../resources/scripts;
}
