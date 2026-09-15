{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./imports.nix
    ./style.nix
    ./default-apps.nix
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # Home-manager packages
  home.packages = with pkgs; [
    # Utils
    zellij
    chafa
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
    lazygit
    wl-clipboard
    cliphist
    ninja
    cmake
    nvd
    nix-output-monitor
    bluetui
    # Graphics and media
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    gimp
    nicotine-plus
    imv
    scanmem
    hyprpolkitagent
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
    neovim
    lact
    # Languages
    python3
    basedpyright
    nodejs
    pnpm
    go
    (gotools.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        rm $out/bin/modernize
      '';
    }))
    delve
    gopls
    lua
    gcc
    cargo
    nixd
    nixfmt
    kdlfmt
    bash-language-server
    shellcheck
    shfmt
    luarocks
    lua51Packages.jsregexp
    lua51Packages.tree-sitter-cli
    lua-language-server
    vscode-langservers-extracted
    # XWayland
    xwayland-satellite
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
    # GTK
    sassc
    gnome-themes-extra
    # Cursors
    catppuccin-cursors.macchiatoDark
    # Libs
    libnotify
    libxcursor
    libGL
    frei0r
    ladspaPlugins
    mediainfo
    # Other
    vulkan-tools
    steam-run
  ];

  # Spicetify
  programs.spicetify = {
    enable = true;
    wayland = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullAppDisplay
      shuffle
      history
      hidePodcasts
      beautifulLyrics
      wikify
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
      lyricsPlus
      marketplace
    ];
  };

  # Nix helper settings
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
  };

  # Yazi
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };

  # Mpv
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
    ];
  };

  # OBS
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

  # Fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Btop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin-macchiato";
    };
    themes = {
      "catppuccin-macchiato" = builtins.readFile ./configs/btop/catppuccin_macchiato.theme;
    };
  };

  home.username = "bopsifox";
  home.homeDirectory = "/home/bopsifox";
  home.shell.enableZshIntegration = true;

  home.stateVersion = "24.11";
}
