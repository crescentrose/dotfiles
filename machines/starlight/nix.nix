{
  # Nix managing nix

  # Define host architecture
  nixpkgs.hostPlatform = "x86_64-linux";

  # set up support for the greatest package management system of all time
  programs.nix-ld.enable = true;

   # Clean up older configurations once a week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings = {
    # Automatically keep the Nix store optimized by hard-linking identical files
    auto-optimise-store = true;
    # Enable flakes
    experimental-features = [ "nix-command" "flakes" ];
    # Allow unprivileged user to specify binary caches
    trusted-users = [
      "root"
      "ivan"
    ];
  };

}
