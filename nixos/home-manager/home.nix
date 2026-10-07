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
    # Apps
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    gimp
    bluetui
    lazygit
    nicotine-plus
    imv
    kdePackages.polkit-kde-agent-1
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

  # Polkit
  systemd.user.services.polkit-kde-agent-1 = {
    Unit = {
      Description = "polkit-kde-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home.username = "bopsifox";
  home.homeDirectory = "/home/bopsifox";
  home.shell.enableZshIntegration = true;

  home.stateVersion = "26.05";
}
