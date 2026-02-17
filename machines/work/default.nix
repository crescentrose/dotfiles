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
      "helm"
      # Install apps from the Mac App Store through CLI
      "mas"
      # Install Vault through Hashicorp's tap
      "hashicorp/tap/vault"
      # Install Terraform through Hashicorp's tap
      "hashicorp/tap/terraform"
      # Install Docker credential helpers
      "docker-credential-helper"
      # Set up a development database
      {
        name = "postgresql@18";
        restart_service = true;
        link = true;
        conflicts_with = [ "postgresql" ];
      }
    ];
    taps = [ "hashicorp/tap" ];
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
      "font-maple-mono"
      "zed"
    ];
  };

  # System configuration
  system.defaults = {
    # Automatic dark/light mode switch
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;

    # Disable automatic predictive text
    NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;

    # Use F1, F2, ... keys as standard function keys
    NSGlobalDomain."com.apple.keyboard.fnState" = true;

    # Enable tap-to-click
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;

    # Auto hide the Dock
    dock.autohide = true;

    # Do not show recent apps in the Dock
    dock.show-recents = false;

    # When opening a new Finder window, take me to my home directory rather
    # than Recents.
    finder.NewWindowTarget = "Home";

    # Switch between languages on Globe key.
    hitoolbox.AppleFnUsageType = "Change Input Source";
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

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
