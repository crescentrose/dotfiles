# General input configuration
{ pkgs, ... }: {
  # == Keyboard ==
  #
  # Keyboard configuration UI
  environment.systemPackages = [ pkgs.via ];

  # Enable support for QMK keyboards
  hardware.keyboard.qmk.enable = true;
  hardware.keyboard.qmk.keychronSupport = true;


  # Allow direct access to keyboard for easier configuration
  services.udev.packages = [
    pkgs.via
  ];

  # Allow key composition (e.g. `ROption+<+3` to input a Unicode heart)
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = [ pkgs.ibus-engines.uniemoji ];
  };

  # == Mouse ==
  #
  # Disable mouse from waking up the computer
  # ref: https://wiki.archlinux.org/title/Udev#Waking_from_suspend_with_USB_device
  # NOTE: This applies to the Keychron wireless mouse dongle. Other mice will have different
  # hardware IDs. That also means this needs to be changed if I get a different mouse.
  # NOTE: Plug the device out then back in for this rule to take effect.
  services.udev.extraRules = ''
    # Disable mouse from waking up the computer
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d026", ATTR{power/wakeup}="disabled", ATTR{driver/1-1/power/wakeup}="disabled"
  '';
}
