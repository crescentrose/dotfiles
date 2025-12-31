{ pkgs, ... }:
let
  # Another joy of the corporate life: your full legal name as the device
  # user...
  user = "ivan.ostric";
in
{
  system.primaryUser = user;

  environment.systemPackages = with pkgs; [
    # macOS-specific Docker stuff
    podman
    docker # use `docker` commands with podman
    docker-buildx
  ];

  # Ideally we would manage everything with Nix, but life is sad and some
  # packages are only available through Brew.
  #
  # Note that Homebrew needs to be installed manually for this to work.
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "1password"
      "1password-cli"
      "ghostty"
      "obsidian"
      "podman-desktop"
      "raycast"
      "font-cascadia-code-nf"
      "font-fira-code-nerd-font"
      "font-symbols-only-nerd-font"
    ];
  };

  # Run a PostgreSQL development database
  services.postgresql.enable = true;

  # Use ZSH as the main shell
  programs.zsh.enable = true;
  # Use Homebrew through zsh
  programs.zsh.shellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  # Use Touch ID for authentication with `sudo`
  security.pam.services.sudo_local.touchIdAuth = true;

  # Using Determinate Nix, because upstream Nix does not work as well when
  # your corporate provisioned device is loaded with Microsoft endpoint
  # security "features"
  nix.enable = false;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users."${user}" = {
    name = user;
    home = "/Users/${user}";
  };

  # WARN: Here be dragons!
  system.stateVersion = 6;
}
