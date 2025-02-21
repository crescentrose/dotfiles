{ pkgs, config, ... }:
{
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
      swayfx # window manager
      swayidle # auto lock
      wl-clipboard # copy and paste
      mako # notifications
      rofi # app launcher 2: electric boogaloo
      grim # screenshots
      slurp # screenshots (select region)
      swaylock-effects # lock screen
      nautilus # file browser
      waybar # status bar
      swww # wallpaper
      glib # gtk config
      overskride # bluetooth
      smile # emoji picker
      gnome-keyring # temporary secrets storage

      # apps
      firefox # firefox
      kitty # terminal
      _1password-gui # secrets
      todoist-electron # task list
      discord # keep up with the egirls
      mpd # radiohead
      rmpc
      mpdscribble # scrobble
      obsidian # notes

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

    # temporary secrets storage
    gnome-keyring = {
      enable = true;
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
    "sway".source =
      config.lib.file.mkOutOfStoreSymlink /home/ivan/Code/dotfiles/config/sway;
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
