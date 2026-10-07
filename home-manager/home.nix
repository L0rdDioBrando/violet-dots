{ inputs, pkgs, ... }:
{
  imports = [
    ./imports.nix
    ./style.nix
    ./default-apps.nix
    inputs.catppuccin.homeModules.catppuccin
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
    proxychains-ng
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
    # Apps
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    gimp
    (callPackage ./custom-pkgs/osu.nix { })
    bluetui
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
    # GTK
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
  ];
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
  };
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
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
  programs.zoxide.enable = true;

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
    TERMINAL_FONT = "FiraCode Nerd Font Mono";
    GTK_USE_PORTAL = "1";
    NH_OS_FLAKE = "/etc/nixos";
  };

  home.username = "bopsifox";
  home.homeDirectory = "/home/bopsifox";
  home.shell.enableZshIntegration = true;

  home.stateVersion = "26.05";
}
