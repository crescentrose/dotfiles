{
  # Enable Polkit, used for doing root things as non-root user
  security.polkit.enable = true;
  # Use Soteria to authenticate with Polkit (the little thingamajig that pops up to ask you for your password)
  security.soteria.enable = true;

  # Do not prompt `wheel` users for the sudo password
  security.sudo.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';

  # Use gnome-keyring for temporary secret storage
  services.gnome.gnome-keyring.enable = true;

  # set up 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ivan" ];
  };

  # Allow Zen browser to use 1Password
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      zen
    '';
    mode = "0755";
  };
}
