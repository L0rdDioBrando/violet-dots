{ config, ... }:

{
  # Configs ~/
  home.file = {
    # Zsh
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./configs/zsh/zshrc;
    ".theme.zsh-theme".source = config.lib.file.mkOutOfStoreSymlink ./configs/zsh/theme.zsh-theme;
  };

  # Configs ~/.config/
  xdg.configFile = {
    # Niri
    "niri/".source = ./configs/niri;

    # Rofi
    "rofi/".source = config.lib.file.mkOutOfStoreSymlink ./configs/rofi;

    # Kvantum
    "Kvantum/kvantum.kvconfig".source =
      config.lib.file.mkOutOfStoreSymlink ./configs/kvantum/kvantum.kvconfig;
    "Kvantum/catppuccin-macchiato-lavender/".source =
      config.lib.file.mkOutOfStoreSymlink ./configs/kvantum/catppuccin-macchiato-lavender;

    # Swaync
    "swaync/".source = config.lib.file.mkOutOfStoreSymlink ./configs/swaync;

    # Waybar
    "waybar/".source = config.lib.file.mkOutOfStoreSymlink ./configs/waybar;

    # Qt6ct
    "qt6ct/".source = config.lib.file.mkOutOfStoreSymlink ./configs/qt6ct;

    # Yazi
    "yazi/".source = config.lib.file.mkOutOfStoreSymlink ./configs/yazi;

    # Zellij
    "zellij/".source = config.lib.file.mkOutOfStoreSymlink ./configs/zellij;
  };
}
