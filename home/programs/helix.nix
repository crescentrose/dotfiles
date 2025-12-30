{
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        shell = [
          "nu"
          "-c"
        ];
        line-number = "relative";
        rulers = [ 80 ];
      };

      keys.normal = {
        "^" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
        "D" = [
          "extend_to_line_end"
          "delete_selection"
        ];
      };

      keys.select = {
        "^" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
      };

    };

    languages = {
      # Use Clippy for rust-analyzer checks
      language-server.rust-analyzer.config.check.command = "clippy";

      # Format Nix files with nixfmt
      language = [
        {
          name = "nix";
          formatter.command = "nixfmt";
          auto-format = true;
        }
      ];
    };
  };
}
