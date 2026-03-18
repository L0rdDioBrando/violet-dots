{ pkgs, inputs, lib, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  
  # Catppuccin settings
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";
    kitty.enable = true;
    btop.enable = false;
    kvantum.enable = true;
    yazi.enable = false;
  };

  # Home-manager packages
  home.packages = with pkgs; [
    # Utils
    btop
    fzf
    yazi
    fastfetch
    # Graphics and media
    swww
    vlc
    loupe
    zathura
    pavucontrol
    kitty
    fzf
    mako
    rofi
    wlogout
    vscode
    waybar
    # XWayland
    xwayland-satellite
    # Qt
    kdePackages.dolphin
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.kde-cli-tools
    catppuccin-qt5ct
    # Cursors
    catppuccin-cursors.macchiatoDark
    # OBS
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    })
  ];

  # Spicetify
  programs.spicetify = {
    enable = true;
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
  };

  # GTK theme
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = lib.mkForce (pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "lavender";
      });
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

  xdg.configFile."kdeglobals".text = ''
  [Icons]
  Theme=Papirus-Dark
  '';

  # Niri
  xdg.configFile."niri/config.kdl".source = ./configs/niri/config.kdl;

  # Kitty
  xdg.configFile = {
    "kitty/kitty.conf".source = ./configs/kitty/kitty.conf;
    "kitty/tab_bar.py".source = ./configs/kitty/tab_bar.py; 
  };

  # Mako
  xdg.configFile."mako/config".source = ./configs/mako/config;

  # Rofi
  xdg.configFile = {
    "rofi/config.rasi".source = ./configs/rofi/config.rasi;
    "rofi/catppuccin.rasi".source = ./configs/rofi/catppuccin.rasi;
    "rofi/catppuccin-macchiato.rasi".source = ./configs/rofi/catppuccin-macchiato.rasi;
  };

  # Wlogout
  xdg.configFile = {
    "wlogout/style.css".source = ./configs/wlogout/style.css;
    "wlogout/icons".source = ./configs/wlogout/icons; 
  };

  # Waybar
  xdg.configFile = {
    "waybar/config".source = ./configs/waybar/config.jsonc;
    "waybar/style.css".source = ./configs/waybar/style.css;
    "waybar/macchiato.css".source = ./configs/waybar/macchiato.css;
  };

  # Qt6ct
  xdg.configFile."qt6ct/qt6ct.conf".source = ./configs/qt6ct/qt6ct.conf;

  # Zathura
  xdg.configFile = {
    "zathura/zathurarc".source = ./configs/zathura/zathurarc;
    "zathura/catppuccin-macchiato".source = ./configs/zathura/catppuccin-macchiato; 
  };

  # Fastfetch
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./configs/fastfetch/config.jsonc;
    "fastfetch/ascii.txt".source = ./configs/fastfetch/ascii.txt; 
  };

  # Zsh
  home.file = {
    ".zshrc".source = ./configs/zsh/.zshrc;
    ".theme.zsh-theme".source = ./configs/zsh/.theme.zsh-theme;
  };

  # Btop
  xdg.configFile = {
    "btop/btop.conf".source = ./configs/btop/btop.conf;
    "btop/themes/catppuccin_macchiato.theme".source = ./configs/btop/themes/catppuccin_macchiato.theme;
  };

  # Bat
  xdg.configFile = {
    "bat/config".source = ./configs/bat/config;
    "bat/themes/CatppuccinMacchiato.tmTheme".source = ./configs/bat/themes/CatppuccinMacchiato.tmTheme; 
  };

  # OBS
  xdg.configFile = {
    "obs-studio/themes/Catppuccin.obt".source = ./configs/obs/Catppuccin.obt;
    "obs-studio/themes/Catppuccin_Macchiato.ovt".source = ./configs/obs/Catppuccin_Macchiato.ovt;
  };

  # Yazi
  xdg.configFile = {
    "yazi/yazi.toml".source = ./configs/yazi/yazi.toml;
    "yazi/theme.toml".source = ./configs/yazi/theme.toml;
    "yazi/CatppuccinMacchiato.tmTheme".source = ./configs/yazi/CatppuccinMacchiato.tmTheme;
  };

  # Default Applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Zathura
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/x-pdf" = [ "org.pwmt.zathura.desktop" ];

      # Loupe
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
      "image/bmp" = [ "org.gnome.Loupe.desktop" ];
      "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];

      # VLC
      "video/mp4" = [ "vlc.desktop" ];
      "video/webm" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];
    };

    associations.added = {
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
    };
  };

  home.stateVersion = "24.11"; 
}
