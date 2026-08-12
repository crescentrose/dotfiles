{ modulesPath, pkgs, ... }:
{
  # Combination of auto generated hardware-configuration and tweaks for this particular system.

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Add available hardware to initrd kernel modules
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "uas"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [
    "kvm-amd"
  ];
  boot.extraModulePackages = [ ];

  # File systems and swap
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1aeda520-b526-4e92-87c3-04d115be267b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A9A7-81B8";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  # Mount network storage
  fileSystems."/mnt/media" = {
    device = "192.168.2.200:/Multimedia";
    fsType = "nfs";
    options = [
      "nfsvers=4.1"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "rw"
    ];
  };

  # The RAMageddon is real
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];


  # Allow microcode updates
  hardware.cpu.amd.updateMicrocode = true;

  # Enable video
  hardware.graphics.enable = true;

  # Enable AMD hardware video encoder
  hardware.graphics.extraPackages = [ pkgs.amf ];
  hardware.amdgpu.initrd.enable = true;

  # Wireless: include the regulatory database so that signal strength can
  # be set appropriately
  hardware.wirelessRegulatoryDatabase = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
