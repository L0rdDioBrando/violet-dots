{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./imports.nix
    ./theme.nix
  ];

  # Home-manager packages
  home.packages = with pkgs; [
    # Utils
    zellij
    wget
    psmisc
    ripgrep
    p7zip
    curl
    playerctl
    bat
    git
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
    ipset
    trash-cli
    (callPackage ./custom-pkgs/naiveproxy.nix { })
    (callPackage ./custom-pkgs/sing-box.nix { })
    # Apps
    chromium
    inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    gimp
    bluetui
    (callPackage ./custom-pkgs/osu.nix { })
    lazygit
    gitui
    nicotine-plus
    imv
    libreoffice
    telegram-desktop
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    pavucontrol
    qbittorrent
    obsidian
    kitty
    swaynotificationcenter
    rofi
    strawberry
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
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
    fish-lsp
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
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.waybar.enable = true;
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };
  programs.nix-your-shell.enable = true;
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 180;
        sensitivity = 100;
        bars = 0;
        bar_width = 3;
        bar_spacing = 2;
      };
      input = {
        method = "pipewire";
        source = "auto";
      };
      output.method = "ncurses";
      color = {
        foreground = "\"#b7bdf8\"";
      };
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
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin-macchiato";
    };
    themes = {
      "catppuccin-macchiato" = builtins.readFile ./configs/btop/catppuccin_macchiato.theme;
    };
  };
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

  # Polkit agent
  services.hyprpolkitagent.enable = true;

  # Automount
  services.udiskie.enable = true;

  # Cursor settings
  home.pointerCursor = {
    enable = true;
    name = "catppuccin-macchiato-dark-cursors";
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 24;
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
  fonts.fontconfig.defaultFonts = {
    monospace = [ "FiraCode Nerd Font Mono" ];
    serif = [ "FiraCode Nerd Font Mono" ];
    sansSerif = [ "FiraCode Nerd Font Mono" ];
  };

  # XDG settings
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      config.common.default = "gnome";
    };
    userDirs = {
      setSessionVariables = true;
      extraConfig = {
        DOCUMENTS = "${config.home.homeDirectory}/Documents";
        DOWNLOADS = "${config.home.homeDirectory}/Downloads";
        MUSIC = "${config.home.homeDirectory}/Music";
        PICTURES = "${config.home.homeDirectory}/Pictures";
        VIDEOS = "${config.home.homeDirectory}/Videos";
        PROJECTS = "${config.home.homeDirectory}/Projects";
        PUBLICSHARE = "${config.home.homeDirectory}";
        DESKTOP = "${config.home.homeDirectory}";
        TEMPLATES = "${config.home.homeDirectory}";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        # Zathura
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/x-pdf" = [ "org.pwmt.zathura.desktop" ];

        # Imv
        "image/*" = [ "imv.desktop" ];

        # Mpv
        "video/*" = [ "mpv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];

        # Neovim
        "text/*" = [ "neovim.desktop" ];
      };
      associations.added = {
        "image/*" = [ "imv.desktop" ];
        "video/*" = [ "mpv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];
      };
    };
  };

  home.username = "bopsifox";
  home.homeDirectory = "/home/bopsifox";
  home.shell.enableFishIntegration = true;

  home.stateVersion = "26.05";
}
