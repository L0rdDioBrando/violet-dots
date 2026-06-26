{
  pkgs,
  lib,
  config,
  ...
}:
{
  # GTK theme
  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    theme = {
      name = "catppuccin-macchiato-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = lib.mkForce (
        pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "lavender";
        }
      );
    };
    cursorTheme = {
      name = "catppuccin-macchiato-dark-cursors";
    };
  };

  # Qt theme
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # For KDE apps
  xdg.configFile."kdeglobals".text = ''
    [Icons]
    Theme=Papirus-Dark

    [UiSettings]
    ColorScheme=qt6ct

    [General]
    TerminalApplication=kitty
  '';
}
