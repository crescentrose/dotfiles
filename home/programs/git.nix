{ pkgs, ... }:
let
  onePasswordSigner =
    if pkgs.stdenv.isDarwin then
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else
      "/run/current-system/sw/bin/op-ssh-sign";
  userName = "Ivan";
  userEmail = "hi@crescentro.se";
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJdAes80dpMrc99B68/1Kx2bbfoh6IrkbFF+60cMQti";
in
{
  programs.git = {
    enable = true;

    settings = {
      user.name = userName;
      user.email = userEmail;

      core.editor = "hx";
      branch.sort = "-committerdate";
      column.ui = "auto";
      pull.ff = "only";
      push.autoSetupRemote = true;

      # Support insane Go packaga manager behaviour for private repos
      # This fucks up Xcode/Swift, though. Pick your battles.
      "url \"git@github.com:...\"".insteadOf = "https://github.com/...";
    };

    signing = {
      format = "ssh";
      key = signingKey;
      signByDefault = true;
      signer = onePasswordSigner;
    };
  };
}
