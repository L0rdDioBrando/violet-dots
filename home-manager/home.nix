{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./imports.nix
    ./default-apps.nix
  ];

  # Home-manager packages
  home.packages = with pkgs; [
    # Utils
    zellij
    wget
    psmisc
    ripgrep
    unzip
    p7zip
    curl
    unrar
    playerctl
    bat
    git
    github-cli
    imagemagick
    eza
    sqlite
    file
    fd
    jq
    fastfetch
    ffmpeg-full
    yt-dlp
    dust
    duf
    bc
    wl-clipboard
    cliphist
    nvd
    nix-output-monitor
    steam-run
    vulkan-tools
    xwayland-satellite
    (callPackage ./custom-pkgs/naiveproxy.nix { })
    (callPackage ./custom-pkgs/sing-box.nix { })
    # Apps
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    gimp
    bluetui
    (callPackage ./custom-pkgs/osu.nix { })
    lazygit
    nicotine-plus
    imv
    polkit_gnome
    telegram-desktop
    zathura
    pkgs.zathuraPkgs.zathura_pdf_mupdf
    pavucontrol
    qbittorrent
    obsidian
    kitty
    swaynotificationcenter
    rofi
    waybar
    strawberry
    # Languages
    python3
    basedpyright
    nodejs
    pnpm
    go
    gotools
    delve
    gopls
    lua
    gcc
    cargo
    rustc
    nixd
    nixfmt
    kdlfmt
    bash-language-server
    shellcheck
    shfmt
    markdown-oxide
    markdownlint-cli2
    prettier
    luarocks
    lua51Packages.jsregexp
    lua51Packages.tree-sitter-cli
    lua-language-server
    vscode-langservers-extracted
    # Qt
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    (pkgs.catppuccin-kde.override {
      flavour = [
        "macchiato"
      ];
      accents = [
        "lavender"
      ];
    })
    # Cursors
    catppuccin-cursors.macchiatoDark
    # Libs
    libnotify
    libxcursor
    libGL
    frei0r
    ladspaPlugins
    mediainfo
  ];

  programs.nh.enable = true;
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
    ];
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
      obs-gstreamer
      obs-pipewire-audio-capture
    ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    sideloadInitLua = true;
    waylandSupport = true;
  };
  programs.fzf.enable = true;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin-macchiato";
    };
    themes = {
      "catppuccin-macchiato" = builtins.readFile ./configs/btop/catppuccin_macchiato.theme;
    };
  };
  programs.zoxide.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        serverAliveInterval = 60;
        AddKeysToAgent = "yes";
      };
      "fedora" = {
        hostname = "192.168.3.91";
        user = "scoleopa";
        port = 22;
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # Cursor settings
  home.pointerCursor = {
    enable = true;
    name = "catppuccin-macchiato-dark-cursors";
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 24;
  };

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
  };

  # Qt theme
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
    qt6ctSettings = {
      Appearance = {
        color_sheme = "catppuccin-macchiato-lavender";
        icon_theme = "Papirus-Dark";
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum";
      };
      Fonts = {
        fixed = "\"FiraCode Nerd Font,12,-1,5,300,0,0,0,0,0,0,0,0,0,0,1\"";
        general = "\"FiraCode Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular\"";
      };
      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 3;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 4;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
      PaletteEditor = {
        geometry = "@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x2\x14\0\0\0\xb1\0\0\x5\x1d\0\0\x2\xc1\0\0\x2\x14\0\0\0\xb1\0\0\x5\x1d\0\0\x2\xc1\0\0\0\0\0\0\0\0\a\x80\0\0\x2\x14\0\0\0\xb1\0\0\x5\x1d\0\0\x2\xc1)";
      };
      SettingsWindow = {
        geometry = "@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\aL\0\0\x3\xe3\0\0\0\0\0\0\0\0\0\0\aL\0\0\x3\xe3\0\0\0\0\0\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\aL\0\0\x3\xe3)";
      };
      Troubleshooting = {
        force_raster_widgets = 2;
        ignored_applications = "@Invalid()";
      };
    };
    kvantum = {
      enable = true;
      settings.General = {
        theme = "catppuccin-macchiato-lavender";
      };
    };
  };

  # Import custom Kvantum theme
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-lavender/".source = ./configs/kvantum;
  };

  # Session variables
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    XCURSOR_THEME = "catppuccin-macchiato-dark-cursors";
    GTK_USE_PORTAL = "1";
    TERMINAL_FONT = "FiraCode Nerd Font Mono";
    TERMINAL = "kitty";
  };

  # Fonts settings
  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
        serif = [ "FiraCode Nerd Font Mono" ];
        sansSerif = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };

  home.username = "bopsifox";
  home.homeDirectory = "/home/bopsifox";
  home.shell.enableZshIntegration = true;

  home.stateVersion = "26.05";
}
