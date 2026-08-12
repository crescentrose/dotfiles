{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      libimobiledevice
      idevicerestore
      ifuse
      rockbox-utility
      hfsprogs
      hfsutils
  ];

  # Enable Apple device support
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # Allow direct access to iPods
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "ipod";
      text = ''
        SUBSYSTEM=="block", SUBSYSTEMS=="usb", ATTRS{product}=="iPod", ATTRS{manufacturer}=="Apple Inc.", MODE="660", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/42-ipod.rules";
    })
  ];
}
