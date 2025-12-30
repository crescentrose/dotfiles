{
  # Fix crackle in certain apps that use Pipewire/Pulseaudio combo
  xdg.configFile."pipewire/pipewire-pulse.conf.d/20-pulse-properties.conf".text = ''
    pulse.properties = {
        pulse.min.req          = 256/48000
        pulse.min.frag         = 256/48000
        pulse.min.quantum      = 256/48000
    }
  '';
}
