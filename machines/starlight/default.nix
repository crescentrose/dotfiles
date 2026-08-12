{
  pkgs,
  opnix,
  ...
}:
{
  imports = [
    ./apple.nix
    ./audio.nix
    ./gui.nix
    ./hardware.nix
    ./input.nix
    ./kernel.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./virtualisation.nix
  ];

  # Disable Richard Stallman
  nixpkgs.config.allowUnfree = true;

  # use zsh by default for fallback
  # my personal account uses `nushell` (which I am more or less ok with)
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # User accounts
  users.users.ivan = {
    isNormalUser = true;
    description = "Ivan";
    extraGroups = [
      "wheel"
      "greeter"
      "plugdev"
      "dialout"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      # Authorization key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2RfXNZk0ta2DOmvrGNv6EfQCkdtUBpZ3OHiTyr4k35"
    ];
  };

  # Global packages
  environment.systemPackages =
    with pkgs;
    [
      # basic shell tools
      nano
      git
      htop
      jq
      zip
      unzip
      ripgrep
      killall
      file
      wget

      # backups
      bup

      # hardware
      usbutils # lsusb
      lm_sensors # temperature sensors
    ]
    ++ [
      opnix.packages."x86_64-linux".default
    ];

  environment.variables = {
    # Use nano as the default editor (if we do not have something user-specific)
    EDITOR = "nano";

    # Do not shove Go stuff in my home dir, ugly
    GOPATH = "$HOME/.local/share/go";

    # Do not shove Rust stuff in my home dir, ugly
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
  };

  # Set up AccountsService
  services.accounts-daemon.enable = true;

  # Set up SSH access
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    startWhenNeeded = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "ivan" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  # Set up GAMING!
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };


  # Allow direct access to certain devices
  services.udev.packages = [
    pkgs.qFlipper
  ];

  # Generate man-page indexes, so that you can tab-complete them
  documentation.man.cache.enable = true;


  # This field determines which set of default values to use.
  # WARN: Do not change this before reviewing changes: https://nixos.org/manual/nixos/unstable/release-notes
  system.stateVersion = "26.05";
}
