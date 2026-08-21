{ config, pkgs, ... }:
let
  plymouthCat = pkgs.callPackage ../../packages/plymouth-cat/package.nix { };
  kernel = config.boot.kernelPackages;
  zenpower5 = kernel.callPackage ../../packages/zenpower5/package.nix { };
in
{
  # Use latest available kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModulePackages = [
    # Temperature and power sensors for Zen 5 CPUs
    zenpower5

    # Temeprature, fan, and voltage readings for ASRock B850I motherboards
    # kernel.nct6687d
  ];

  boot.kernelModules = [
    "zenpower"
    # "nct6687"
  ];

  boot.kernelParams = [
    "quiet" # less noise during boot
    "rd.systemd.show_status=false" # ditto
    "splash" # use plymouth as a nice booting animation
    "boot.shell_on_fail" # self explanatory
    "rd.udev.log_level=3" # log udev events more broadly
    "udev.log_priority=3" # ditto
    "amdgpu.dcdebugmask=0x10" # fixes laggy GPU after suspend
    "amdgpu.ppfeaturemask=0xffffffff" # allow GPU overclocking (also fixes certain crashes in Proton games)
  ];

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.supportedFilesystems = [ "nfs" ];
  # Define accurate regulatory domain for Wi-Fi
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="NL"
  '';

  # nice boot animation
  boot.plymouth = {
    enable = true;
    theme = "cat";
    themePackages = [
      plymouthCat
    ];
  };

  # Bootloader stuff
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  # Keep only last 5 configurations
  boot.loader.systemd-boot.configurationLimit = 5;
}
