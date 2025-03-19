{ pkgs, ... }:
let
  # TODO: move this elsewhere, it makes no sense to keep this at the top of the file
  greetConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s /etc/greetd/gtkgreet.css; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5; # hide OS choice

  # Use latest available kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # less noise during boot
  boot.kernelParams = [
    "quiet" "splash" "boot.shell_on_fail" "rd.systemd.show_status=false" "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # nice boot animation
  boot.plymouth = {
    enable = true;
    theme = "colorful_sliced";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
       selected_themes = [ "colorful_sliced" ];
       })
    ];
  };

  # Enable AMD GPU overclocking
  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xFFFFFFFF
  '';

  # Networking
  networking.hostName = "streaming-heart";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # use zsh by default for fallback
  # my personal account uses `nushell` (which I am more or less ok with)
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # experiment with fish, why not
  programs.fish.enable = true;

  # User accounts
  users.users.ivan = {
    isNormalUser = true;
    description = "Ivan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = [];
  };

  # Disable Richard Stallman
  nixpkgs.config.allowUnfree = true;

  # Enable Polkit, required for setting up a WM
  security.polkit.enable = true;

  # Do not prompt `wheel` users for the sudo password
  security.sudo.wheelNeedsPassword = false;

  # Global packages
  environment.systemPackages = with pkgs; [
    # basic shell tools
    zsh
    neovim
    git
    htop
    jq
    zip
    unzip
    ripgrep
    killall
    file
    wget

    # window manager
    sway

    # networking
    cifs-utils # Samba shares

    # auth
    lxqt.lxqt-policykit # Authorize PolicyKit actions

    # gpu controller
    lact
  ];

  # Use nvim as the default editor
  environment.variables.EDITOR = "nvim";

  # Set up dconf
  programs.dconf.enable = true;

  # Enable video
  hardware.graphics.enable = true;

  # Make fonts render twice as good as Ubuntu but half as good as macOS
  fonts.fontconfig = {
    # fixes pixelation
    antialias = true;

    # fixes antialiasing blur
    hinting.enable = true;

    # fixes height
    subpixel.rgba = "rgb";
  };


  # Enable sound (seriously, why is this not default?)
  security.rtkit.enable = true; # enable RealtimeKit for audio purposes
  services.pulseaudio.enable = false; # and good riddance, you wretched beast!
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
  };

  # Set up greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${greetConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    niri-session
    sway
    zsh
  '';

  # Show a nice background instead of a flashbang
  environment.etc."greetd/gtkgreet.css".text = ''
    window {
        background-image: url("file:///etc/greetd/greetd.png");
        background-size: cover;
        background-position: center;
    }

    box#body {
        background-color: #ffffff;
        color: black;
        border-radius: 10px;
        padding: 50px;
    }
  '';

  environment.etc."greetd/greetd.png".source = ./greetd.png;

  # Allow Zen browser to use 1Password
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      zen
    '';
    mode = "0755";
  };

  # Set up lockscreen support with Swaylock
  security.pam.services.swaylock = {};

  # Set up GAMING!
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
  };

  # set up 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ivan" ];
  };

  # Set up VPN
  services.tailscale = {
    enable = true;
  };

  # Allow browsing Samba shares (and other file systems) from UI
  services.gvfs.enable = true;

  # Enable network auto-discovery
  services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
  };

  # Mount network storage
  # This depends on a file in /etc/nixos/smb-secrets. This file should be put there somehow, but
  # I am not exactly sure how. For now I place it manually, but eventually I would prefer to
  # automate this.
  fileSystems."/mnt/music" = {
      device = "//virtuous-contract.local/music";
      fsType = "cifs";
      options = let
        automount_opts
        = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

  # Enable AMD GPU controller for easier overclocking
  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Suspend the system when the DE signals it is idle
  services.logind.extraConfig = ''
    IdleAction=suspend
  '';

  # Set up Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.extraGroups.docker.members = [ "ivan" ];

  # Keep only last 5 configurations
  boot.loader.systemd-boot.configurationLimit = 5;

  # Clean up older configurations once a week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Automatically keep the Nix store optimized by hard-linking identical files
  nix.settings.auto-optimise-store = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # HERE BE DRAGONS!!!
  system.stateVersion = "24.11";
}
