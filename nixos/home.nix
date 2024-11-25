{ pkgs, config, ... }:
{
  # Disable Richard Stallman
  nixpkgs.config.allowUnfree = true;

  programs = {
    # Home Manager manages itself
    home-manager.enable = true;
  };

  home = {
    packages = with pkgs; [
      # desktop environment
      swayfx # window manager
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

      # apps
      firefox # firefox
      kitty # terminal
      _1password-gui # secrets
      todoist-electron # task list
      obsidian # personal notes
      discord # keep up with the egirls
      mpd # radiohead
      rmpc
      mpdscribble # scrobble

      # cli apps
      nushell # a nicer shell
      _1password-cli # secrets
      fortune # wisdom
      starship # terminal prompt
      carapace # completion
      gh # github client
      neofetch # r/unixporn bait

      # developer tools
      gcc # the GNU Compiler Collection
      mise # maintain dev environments
      nodejs_22 # for Mason
      rustup # rust installer

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
      (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
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
  };
}
