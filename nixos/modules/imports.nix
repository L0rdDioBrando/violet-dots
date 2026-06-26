{ ... }:

{
  # Configs ~/
  home.file = {
    # Zsh
    ".zshrc".source = ./configs/zsh/zshrc;
    ".theme.zsh-theme".source = ./configs/zsh/theme.zsh-theme;
  };

  # Configs ~/.config/
  xdg.configFile = {
    # Niri
    "niri/".source = ./configs/niri;

    # Rofi
    "rofi/".source = ./configs/rofi;

    # Kvantum
    "Kvantum/kvantum.kvconfig".source = ./configs/kvantum/kvantum.kvconfig;
    "Kvantum/catppuccin-macchiato-lavender/".source = ./configs/kvantum/catppuccin-macchiato-lavender;

    # Swaync
    "swaync/".source = ./configs/swaync;

    # Waybar
    "waybar/".source = ./configs/waybar;

    # Qt6ct
    "qt6ct/".source = ./configs/qt6ct;

    # Yazi
    "yazi/".source = ./configs/yazi;

    # Zellij
    "zellij/".source = ./configs/zellij;

    # Mpv
    "mpv/".source = ./configs/mpv;

    # Bat
    "bat/".source = ./configs/bat;

    # Imv
    "imv/".source = ./configs/imv;

    # OBS
    "obs-studio/themes/".source = ./configs/obs;

    # Zathura
    "zathura/".source = ./configs/zathura;

    # Cava
    "cava/".source = ./configs/cava;

    # Fastfetch
    "fastfetch/".source = ./configs/fastfetch;

    # Kitty
    "kitty/".source = ./configs/kitty;
  };
}
