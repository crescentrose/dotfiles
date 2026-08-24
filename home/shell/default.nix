{ pkgs, ... }:
{
  imports = [
    ./developer.nix
    ./nu.nix
    ./ripgrep.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # cli apps
    bat # nicer cat
    broot # trees
    difftastic # syntax-aware diff
    dig # it's always DNS
    fastfetch # r/unixporn bait
    fd # find replacement
    fortune # wisdom
    fq # jq for binary formats
    gh # github client
    hledger # stacks
    hledger-ui # bread
    hledger-web # dough
    imagemagick # magic of the image variety
    jujutsu # fine, i will try it...
    viu # view images in terminal
    xh # curl at home

    # developer tools
    agebox # secret
    age # more secret
    lefthook # git hooks
    gnumake # for the heathens

    # system management
    nh # nix cli helper
  ];

  xdg.dataFile."scripts".source = ../../scripts;
}
