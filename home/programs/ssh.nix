{
  # use 1password to authenticate with SSH
  programs.ssh = {
    enable = true;

    # Default host config
    settings = {
      "Host *" = {
        IdentityAgent = "~/.1password/agent.sock";
      };
    };

    # Fix deprecation warning
    enableDefaultConfig = false;
  };
}
