{
  # Only options supported by both macOS and Linux should go here.
  # Others should go in the respective `_work` or `_home` files.

  # Disable Richard Stallman
  nixpkgs.config.allowUnfree = true;

  programs = {
    # Home Manager manages itself
    home-manager.enable = true;

    # keep per-project shell configs
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.stateVersion = "25.11";
}
