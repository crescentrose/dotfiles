{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.nixos-firewall-tool # ufw at home
    pkgs.cifs-utils # manage smb shares
  ];

  # Networking
  networking.hostName = "starlight";
  networking.networkmanager.enable = true;

  users.users.ivan.extraGroups = [
    "networkmanager"
  ];

  # Set up VPN
  services.tailscale.enable = true;

  # Enable firewall
  networking.firewall = {
    allowedTCPPorts = [
      2049 # NFS
    ];
    # sudo dmesg --follow --human | grep 'refused packet:'
    logRefusedPackets = true;
  };
  # Use nftables over iptables
  networking.nftables.enable = true;

  # Allow browsing Samba shares (and other file systems) from UI
  services.gvfs.enable = true;

  # Enable network auto-discovery
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
