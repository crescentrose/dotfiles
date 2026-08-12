{ ... }:
{
  # https://preview.redd.it/pulseaudio-v0-03cn5brt1p7g1.jpeg?width=640&crop=smart&auto=webp&s=11c41e956980c1cdc3430a39f00cf392f71f9851

  # enable RealtimeKit for audio purposes
  security.rtkit.enable = true;

  # Enable sound (seriously, why is this not default?)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
