{
  programs.zed-editor = {
    enable = true;
    extensions = [
      # Theming
      "catppuccin"
      "catppuccin-icons"

      # Language support
      "astro"
      "biome"
      "dockerfile"
      "gleam"
      "html"
      "kdl"
      "make"
      "nix"
      "nu"
      "proto"
      "sql"
      "terraform"
      "toml"
      "vue"
    ];

    userSettings = {
      "terminal" = {
        "font_family" = "Maple Mono NF";
        "shell" = {
          "program" = "nu";
        };
      };
      "buffer_line_height" = "comfortable";
      "buffer_font_family" = "Maple Mono NF";
      "buffer_font_features" = {
        "calt" = 1;
        "dlig" = 1;
      };
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
