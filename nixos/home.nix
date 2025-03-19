{ pkgs, config, zen-browser, cringe-emojis, ... }:
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
      swayidle # auto lock
      wl-clipboard # copy and paste
      mako # notifications
      rofi # app launcher 2: electric boogaloo
      grim # screenshots
      slurp # screenshots (select region)
      swaylock-effects # lock screen
      waybar # status bar
      swww # wallpaper
      glib # gtk config
      overskride # bluetooth
      smile # emoji picker
      thunderbird # mail
      gnome-keyring # temporary secrets storage
      xkeyboard_config

      niri # window manager 2: window manageraloo
      xwayland-satellite # xwayland outside wayland

      # apps
      kitty # terminal
      _1password-gui # secrets
      todoist-electron # task list
      discord # keep up with the egirls
      mpd # radiohead
      rmpc
      mpdscribble # scrobble
      obsidian # notes

      # Fine, I Will Use Gnome Apps
      boatswain # stream deck controller
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
      video-trimmer # if only all apps were named this consistently
      warp # file transfer

      # cli apps
      nushell # a nicer shell
      _1password-cli # secrets
      fortune # wisdom
      starship # terminal prompt
      carapace # completion
      gh # github client
      fastfetch # r/unixporn bait
      gifsicle # gif editing
      bat # nicer cat
      glow # markdown viewer
      zola # static site generator
      libnotify # for notify-send

      # developer tools
      gcc # the GNU Compiler Collection
      rustup # rust installer
      terraform # the CLOUD
      pkg-config # builds
      strace # peek under the hood

      # language servers
      gopls # golang
      lua-language-server # lua
      taplo # toml
      terraform-ls # terraform
      nil # nix
      vscode-langservers-extracted # html, css, json, eslint
      typescript-language-server # javascript, typescript

      # fonts
      noto-fonts
      noto-fonts-cjk-sans
      cascadia-code
      departure-mono
      iosevka
      liberation_ttf # replacements for common MS fonts
      twitter-color-emoji # 🤓

      # icons
      font-awesome
      nerd-fonts.symbols-only
    ] ++ [
      zen-browser.packages."x86_64-linux".default
      cringe-emojis.packages."x86_64-linux".default
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

  fonts.fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" "Twitter Color Emoji" ];

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

    # temporary secrets storage
    gnome-keyring = {
      enable = true;
    };
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
    "swaylock".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/swaylock;
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

  # Set up default apps
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "x-scheme-handler/anytype" = "anytype.desktop";
    };
  };
}
