{
  programs.zed-editor = {
    enable = true;
    extensions = [
      # Theming
      "catppuccin"
      "catppuccin-icons"

      # Language support
      "toml"
      "dockerfile"
      "sql"
      "make"
      "terraform"
      "nix"
      "proto"
    ];

    userSettings = {
      "terminal" = {
        "font_family" = "Iosevka";
        "shell" = {
          "program" = "nu";
        };
      };
      "buffer_line_height" = "comfortable";
      "buffer_font_family" = "Iosevka";
      "buffer_font_fallbacks" = [ "Symbols Nerd Font Mono" ];
      "show_edit_predictions" = false;
      "base_keymap" = "VSCode";
      "toolbar" = {
        "code_actions" = true;
      };
      "relative_line_numbers" = "enabled";
      "helix_mode" = true;
      "ui_font_size" = 15;
      "buffer_font_size" = 14;
      "theme" = {
        "mode" = "system";
        "light" = "Catppuccin Latte";
        "dark" = "Catppuccin Macchiato";
      };
    };
  };
}
