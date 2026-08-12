{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-boxes
    dnsmasq # VM networking
    phodav # Share files with guest VMs
  ];

  # Set up virtualisation
  virtualisation.libvirtd = {
    enable = true;
  };

  # Enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;

  # Set up Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Allow myself to access these wonderful tools without sudo
  users.users.ivan.extraGroups = [
    "kvm"
    "docker"
    "libvirtd"
  ];
}
