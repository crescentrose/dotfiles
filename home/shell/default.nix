{ pkgs, ... }:
{
  imports = [
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
    gcc # the GNU Compiler Collection
    rustup # rust installer
    terraform # the CLOUD
    agebox # secret
    age # more secret
    uv # snek
    lefthook # git hooks

    # language servers
    gopls # golang
    lua-language-server # lua
    nixd # nix
    nixfmt-rfc-style # nix formatter
    taplo # toml
    terraform-ls # terraform
    typescript-language-server # javascript, typescript
    vscode-langservers-extracted # html, css, json, eslint
  ];

  xdg.dataFile."scripts".source = ../../resources/scripts;
}
