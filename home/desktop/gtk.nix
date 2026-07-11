{ pkgs, ... }:
{
  # Manage through DMS
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };

  # GTK theming settings
  gtk = {
    enable = true;
    gtk4.theme = null;

    # Certain GNOME apps break without this because they are impeccably coded
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };
  };
}
