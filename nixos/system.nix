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
  imports = [
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
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # Make the kernel use AMD drivers at boot already
  boot.initrd.kernelModules = [ "amdgpu" ];

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

  # User accounts
  users.groups = {
    wireshark = {
      members = [ "ivan" ];
    };
  };

  users.users.ivan = {
    isNormalUser = true;
    description = "Ivan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "docker"
      "libvirtd"
      "wireshark"
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

  # Enable Polkit, required for setting up a WM
  security.polkit.enable = true;

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
    dnsmasq # VM networking
    phodav # VM sharing

    # hardware
    usbutils # lsusb

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
  # Enable AMD hardware video encoder
  hardware.graphics.extraPackages = [ pkgs.amf ];

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

    # Expose AirPlay devices as sinks
    raopOpenFirewall = true;
    extraConfig.pipewire = {
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";
            args = {
              "raop.latency.ms" = 500;
            };
          }
        ];
      };
    };
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
  # This depends on a file in /etc/nixos/smb-secrets. This file should be put there somehow, but
  # I am not exactly sure how. For now I place it manually, but eventually I would prefer to
  # automate this.
  fileSystems."/mnt/music" = {
    device = "//virtuous-contract.local/music";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100" ];
  };

  # Enable AMD GPU controller for easier overclocking
  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # Suspend the system when the DE signals it is idle
  # ref: https://www.freedesktop.org/software/systemd/man/latest/logind.conf.html
  services.logind.extraConfig = ''
    IdleAction=suspend
    HandlePowerKey=suspend
  '';

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

  # Set up virtualisation
  virtualisation.libvirtd = {
    enable = true;

    # Enable TMP emulation
    qemu = {
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  # Enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable Wireshark with USB support
  programs.wireshark = {
    package = pkgs.wireshark;
    enable = true;
    usbmon.enable = true;
    dumpcap.enable = true;
  };

  # Keep only last 5 configurations
  boot.loader.systemd-boot.configurationLimit = 5;

  # Clean up older configurations once a week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings= {
    # Automatically keep the Nix store optimized by hard-linking identical files
    auto-optimise-store = true;
    # Allow unprivileged user to specify binary caches
    trusted-users = ["root" "ivan"];
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
  system.stateVersion = "25.05";
}
