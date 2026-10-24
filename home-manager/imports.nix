{ ... }:

{
  # Configs ~/
  home.file = {
    # Zsh
    ".zshrc".source = ./configs/zsh/zshrc;
    ".theme.zsh-theme".source = ./configs/zsh/theme.zsh-theme;
    ".config/fsh/catppuccin-macchiato.ini".source = ./configs/zsh/catppuccin-macchiato-fsh.ini;
  };

  # Configs ~/.config/
  xdg.configFile = {
    # Niri
    "niri/".source = ./configs/niri;

    # Rofi
    "rofi/".source = ./configs/rofi;

    # Swaync
    "swaync/".source = ./configs/swaync;

    # Waybar
    "waybar/".source = ./configs/waybar;

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

    # Hyprtoolkit
    "hypr/".source = ./configs/hyprtoolkit;

    # OBS
    "obs-studio/themes/".source = ./configs/obs;

    # Zathura
    "zathura/".source = ./configs/zathura;

    # Cava
    #    "cava/".source = ./configs/cava;

    # Fastfetch
    "fastfetch/".source = ./configs/fastfetch;

    # Kitty
    "kitty/".source = ./configs/kitty;
  };
}
