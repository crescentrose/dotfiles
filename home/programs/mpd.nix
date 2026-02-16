{
  imports = [
    ../../modules/services/mprisence.nix
  ];

  age.secrets.mpdscribble.file = ../../secrets/mpdscribble.age;

  services = {
    mpd = {
      enable = false;
      musicDirectory = "/mnt/media/Music";
      extraConfig = ''
        auto_update "yes"

        audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
        }

        audio_output {
          type "fifo"
          name "visualizer"
          path "~/.local/share/mpd/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };

    # control mpd through the MPRIS protocol
    mpd-mpris.enable = false;

    # daemon that tracks media player activity
    playerctld.enable = true;

    # Make Bluetooth headset buttons usable with media players
    mpris-proxy.enable = true;

    # Enable Discord rich presence
    mprisence = {
      enable = false;
      settings = {
        player = {
          default = {
            ignore = true;
          };
          "io.github.htkhiem.Euphonica" = {
            ignore = true;
          };
          "*mpd*" = {
            ignore = false;
          };
          zen = {
            ignore = true;
          };
        };
      };
    };

    # Enable scrobbling
    mpdscribble = {
      enable = false;
      endpoints."last.fm" = {
        passwordFile = "/run/user/1000/agenix/mpdscribble"; # TODO: super hacky
        username = "crescentr0se";
      };
    };
  };

  # Ensure that the mpd state directory exists for the FIFO to be created
  xdg.dataFile."mpd/.keep".text = "";
}
