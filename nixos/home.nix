{ lib, pkgs, config, zen-browser, ... }:
{
  # Disable Richard Stallman
  nixpkgs.config.allowUnfree = true;

  programs = {
    # Home Manager manages itself
    home-manager.enable = true;

    # use 1password to authenticate with SSH
    ssh = {
      enable = true;
      extraConfig = ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
    };

    # keep per-project shell configs
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    packages = with pkgs; [
      # desktop environment
      glib # gtk config
      niri # window manager 2: window manageraloo
      hyprlock # lock screen 2: lock... yeah whatever
      hypridle # idle management daemon
      swww # dynamic wallpaper
      swaybg # static wallpaper
      thunderbird # mail
      mako # notifications
      waybar # status bar
      wl-clipboard # copy and paste
      wtype # automate writing (for inserting emojis)
      xwayland-satellite # xwayland outside wayland
      wob # overlay

      # app launcher 2: electric boogaloo
      (rofi.override (old: { plugins = [
        pkgs.rofi-emoji
        pkgs.rofi-calc
      ]; }))

      # apps
      discord # keep up with the egirls
      kitty # terminal
      mpd # radiohead
      mpdscribble # scrobble
      obsidian # notes
      rmpc # terminal music player
      todoist-electron # task list
      prismlauncher # the children yearn for the mines
      slack # work, work
      vivaldi # for when I need a chromium-based browser
      qbittorrent # yarr

      # Fine, I Will Use Gnome Apps
      boatswain # stream deck controller
      celluloid # video player
      decibels # audio player
      dialect # translation
      diebahn # choo choo 🚆
      evince # document viewr
      gnome-calculator
      gnome-calendar
      gnome-maps
      gnome-weather
      loupe # image viewer
      nautilus # file browser
      newsflash # rss
      plattenalbum # MPD client
      seahorse # secret management
      video-trimmer # if only all apps were named this consistently
      warp # file transfer

      # cli apps
      bat # nicer cat
      carapace # completion
      fastfetch # r/unixporn bait
      fortune # wisdom
      gh # github client
      gifsicle # gif editing
      glow # markdown viewer
      imagemagick # magic of the image variety
      libnotify # for notify-send
      nushell # a nicer shell
      starship # terminal prompt
      v4l-utils # webcam settings
      zola # static site generator
      libjxl # jpegxl conversion

      # developer tools
      gcc # the GNU Compiler Collection
      pkg-config # builds
      rustup # rust installer
      strace # peek under the hood
      terraform # the CLOUD

      # language servers
      gopls # golang
      lua-language-server # lua
      nil # nix
      taplo # toml
      terraform-ls # terraform
      typescript-language-server # javascript, typescript
      vscode-langservers-extracted # html, css, json, eslint

      # fonts
      cascadia-code
      departure-mono
      iosevka
      liberation_ttf # replacements for common MS fonts
      noto-fonts
      noto-fonts-cjk-sans
      twitter-color-emoji # 🤓

      # icons
      font-awesome
      nerd-fonts.symbols-only
    ] ++ [
      zen-browser.packages."x86_64-linux".default # firefoxn't
    ];

    username = "ivan";
    homeDirectory = "/home/ivan";

    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "nvim";
    };

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  # screen recording
  programs.obs-studio = {
    enable = true;
  };

  # GTK theming settings
  gtk = {
    enable = true;
    # Certain GNOME apps break without this because they are impeccably coded
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  fonts.fontconfig.defaultFonts.emoji = [ "Twitter Color Emoji" ];

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/mnt/music";
      extraConfig = ''
        auto_update "yes"

        audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
        }
      '';
    };
    mpd-discord-rpc = {
      enable = true;
    };

    # Make Bluetooth headset buttons usable with media players
    mpris-proxy.enable = true;

    # Enable system authentication for unprivileged apps
    polkit-gnome.enable = true;
  };

  # Allow inter-app communication
  # The GTK portal can handle most interfaces, while the WLR portal handles screenshots and screen
  # casting for Niri.
  # Notably, neither handle clipboard - seems like only the GNOME portal does that. 😕
  # more info: https://wiki.archlinux.org/title/XDG_Desktop_Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
    pkgs.gnome-keyring
  ];
  xdg.portal.config = {
    niri = {
      default = ["gnome" "gtk"];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };

    preferred = {
      default = [
        "gnome" "gtk"
      ];
    };
  };

  # Fix crackle in certain apps that use Pipewire/Pulseaudio combo
  xdg.configFile."pipewire/pipewire-pulse.conf.d/20-pulse-properties.conf".text = ''
  pulse.properties = {
      pulse.min.req          = 256/48000
      pulse.min.frag         = 256/48000
      pulse.min.quantum      = 256/48000
  }
  '';

  # Set up systemd units for various supporting DE services.
  systemd.user.services = {
    # Bar
    waybar = {
      Unit = {
        Description = "Waybar";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
        Requisite = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "$PATH:${lib.makeBinPath [ pkgs.imagemagick ]}";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
      };
    };

    # Notification daemon
    mako = {
      Unit = {
        Description = "Mako - Notification daemon";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.mako}/bin/mako";
        ExecReload = "${pkgs.mako}/bin/makoctl reload";
        Restart = "on-failure";
      };
    };

    # Wallpaper manager
    swww = {
      Unit = {
        Description = "Solution to Wayland Wallpaper Woes";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "niri.service" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
    };

    # Overview wallpaper manager
    swaybg = {
      Unit = {
        Description = "Background for Wayland";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "niri.service" ];
      };
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg --output=\"*\" -i /home/ivan/.cache/blurred_wallpaper.jpg";
        Restart = "on-failure";
      };
    };

    # Idle manager
    hypridle = {
      Unit = {
        Description = "Idle management daemon";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "niri.service" ];
      };
      Service = {
        ExecStart = "${pkgs.hypridle}/bin/hypridle";
        Restart = "on-failure";
      };
    };
  };

  # Dotfiles
  # I do not really want to store all of my dotfiles in the Nix language because it makes it more
  # difficult to iterate upon them and share with others who might not use NixOS. So they get
  # symlinked here.

  # TODO: Looks like only absolute paths are supported currently. Need to figure out a better way to
  # handle this.
  home.file = {
    ".gitconfig".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/gitconfig;
    "bin".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/bin;
  };

  xdg.configFile = {
    ".gitignore_global".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/gitignore_global;
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/nvim;
    "kitty".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/kitty;
    "nushell".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/nushell;
    "mise".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/mise;
    "starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/starship.toml;
    ".ripgreprc".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/ripgreprc;
    "waybar".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/waybar;
    "rmpc".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/rmpc;
    "mako".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/mako;
    "proselint".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/proselint;
    "rofi".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/rofi;
    "niri".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/niri;
    "hypr".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/hypr;
  };

  # Enable hardware acceleration in Discord, which is disabled by default because of reasons only
  # known to Mr. John Discord himself
  xdg.desktopEntries.discord = {
    categories= [ "Network" "InstantMessaging" ];
    exec = "discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy";
    genericName = "All-in-one cross-platform voice and text chat for gamers";
    icon = "discord";
    mimeType = ["x-scheme-handler/discord"];
    name = "Discord";
    type = "Application";
    terminal = false;
  };
}
