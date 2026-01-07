{ config, pkgs, ... }:
let
  # TODO: move this elsewhere, it makes no sense to keep this at the top of the file
  greetConfig = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.gtkgreet}/bin/gtkgreet -l -s /etc/greetd/gtkgreet.css; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
  plymouthCat = pkgs.callPackage ../../packages/plymouth-cat/package.nix { };
  kernel = config.boot.kernelPackages;
  zenpower5 = kernel.callPackage ../../packages/zenpower5/package.nix { };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  # Use latest available kernel
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  boot.extraModulePackages = [
    # Temperature and power sensors for Zen 5 CPUs
    zenpower5

    # Temeprature, fan, and voltage readings for ASRock B850I motherboards
    kernel.nct6687d
  ];

  boot.kernelModules = [
    "zenpower"
    "nct6687"
  ];

  # less noise during boot
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.supportedFilesystems = [ "nfs" ];

  # nice boot animation
  boot.plymouth = {
    enable = true;
    theme = "cat";
    themePackages = [
      plymouthCat
    ];
  };

  # Networking
  networking.hostName = "starlight";
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

  # User accounts
  users.users.ivan = {
    isNormalUser = true;
    description = "Ivan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = [ ];
    openssh.authorizedKeys.keys = [
      # Authorization key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2RfXNZk0ta2DOmvrGNv6EfQCkdtUBpZ3OHiTyr4k35"
    ];
  };

  # Disable Richard Stallman
  nixpkgs.config.allowUnfree = true;

  # Enable Polkit, used for doing root things as non-root user
  security.polkit.enable = true;
  # Use Soteria to authenticate with Polkit (the little thingamajig that pops up to ask you for your password)
  security.soteria.enable = true;

  # Do not prompt `wheel` users for the sudo password
  security.sudo.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';

  # Use gnome-keyring for temporary secret storage
  services.gnome.gnome-keyring.enable = true;

  # Global packages
  environment.systemPackages = with pkgs; [
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

    # binary cache
    cachix

    # window manager
    sway

    # networking
    cifs-utils # Samba shares

    # hardware
    usbutils # lsusb

    # VMs (for testing)
    qemu
    quickemu

    # icons
    adwaita-icon-theme
    adwaita-icon-theme-legacy

    # hardware
    lm_sensors
  ];

  # Use nano as the default editor (if we do not have something user-specific)
  environment.variables.EDITOR = "nano";

  # Set up dconf
  programs.dconf.enable = true;

  # Enable video
  hardware.graphics.enable = true;
  # Enable AMD hardware video encoder
  hardware.graphics.extraPackages = [ pkgs.amf ];
  hardware.amdgpu.initrd.enable = true;

  # Include some standard fonts
  fonts.enableDefaultPackages = true;

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

  environment.etc."greetd/environments".text = ''
    niri-session
    zsh
  '';

  # Show a nice background instead of a flashbang
  environment.etc."greetd/gtkgreet.css".text = ''
    window {
        background-image: url("file://${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom}/share/backgrounds/nixos/nix-wallpaper-simple-dark-gray_bottom.png");
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

  # Allow Zen browser to use 1Password
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      zen
    '';
    mode = "0755";
  };

  # Set up lockscreen support with Hyprlock
  security.pam.services.hyprlock = { };

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

  # set up support for the greatest package management system of all time
  programs.nix-ld.enable = true;

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
  fileSystems."/mnt/media" = {
    device = "192.168.1.200:/Multimedia";
    fsType = "nfs";
    options = [
      "nfsvers=4.1"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "rw"
    ];
  };
  networking.firewall = {
    allowedTCPPorts = [ 2049 ];
  };

  # Suspend the system when the DE signals it is idle
  # ref: https://www.freedesktop.org/software/systemd/man/latest/logind.conf.html
  services.logind.settings.Login = {
    IdleAction = "suspend";
    HandlePowerKey = "suspend";
  };

  # Disable mouse from waking up the computer
  # ref: https://wiki.archlinux.org/title/Udev#Waking_from_suspend_with_USB_device
  # NOTE: This applies to the Keychron wireless mouse dongle. Other mice will have different
  # hardware IDs. That also means this needs to be changed if I get a different mouse.
  # NOTE: Plug the device out then back in for this rule to take effect.
  services.udev.extraRules = ''
    # Disable mouse from waking up the computer
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d030", ATTR{power/wakeup}="disabled", ATTR{driver/1-1/power/wakeup}="disabled"
  '';

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "pegboard_udev";
      text = ''
        ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="37fa", ATTRS{idProduct}=="8201", MODE="0770", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/50-pegboard.rules";
    })
  ];

  # Set up Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Keep only last 5 configurations
  boot.loader.systemd-boot.configurationLimit = 5;

  # Clean up older configurations once a week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings = {
    # Automatically keep the Nix store optimized by hard-linking identical files
    auto-optimise-store = true;
    # Allow unprivileged user to specify binary caches
    trusted-users = [
      "root"
      "ivan"
    ];

    # # Additional binary caches
    # # Disabled temporarily because it gets queried for everything which is
    # # not necessarily what I want
    # extra-substituters = [
    #   "https://walker.cachix.org"
    #   "https://walker-git.cachix.org"
    # ];
    # extra-trusted-public-keys = [
    #   "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
    #   "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    # ];
  };

  # Maybe?
  gtk = {
    iconCache.enable = true;
  };

  # Generate man-page indexes, so that you can tab-complete them
  documentation.man.generateCaches = true;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This field determines which set of default values to use.
  # WARN: Do not change this before reviewing changes: https://nixos.org/manual/nixos/unstable/release-notes
  system.stateVersion = "25.11";
}
