{
  pkgs,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Catppuccin
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";
    kvantum.enable = false;
    bat.enable = true;
    firefox.enable = false;
    yazi.enable = false;
    kitty.enable = true;
    zathura.enable = true;
    obs.enable = true;
    mpv.enable = true;
    cava.enable = false;
  };

  # Home-manager packages
  home.packages = with pkgs; [
    # Utils
    tmux
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
    file
    tldr
    fd
    jq
    viu
    ueberzugpp
    dust
    duf
    bc
    wl-clipboard
    cliphist
    ninja
    cmake
    pkg-config
    grim
    slurp
    nicotine-plus
    # Graphics and media
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    steam
    hyprlock
    yt-dlp
    gimp
    discord
    hyprpicker
    hyprpolkitagent
    telegram-desktop
    pkgs.zathuraPkgs.zathura_pdf_mupdf
    kdePackages.okular
    kdePackages.dolphin
    pavucontrol
    obsidian
    kitty
    swaynotificationcenter
    rofi
    waybar
    strawberry
    neovim
    # Languages
    python3
    nodejs
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
    gnumake
    osu-lazer-bin
    luarocks
    lua51Packages.jsregexp
    lua51Packages.tree-sitter-cli
    lua-language-server
    vscode-langservers-extracted
    # XWayland
    xwayland-satellite
    # Qt
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.kde-cli-tools
    catppuccin-qt5ct
    # Cursors
    catppuccin-cursors.macchiatoDark
    # Other
    vulkan-tools
    steam-run
  ];

  # Yazi
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar; 
    };
  };

  programs.prismlauncher = {
    enable = true;
  };

  # Fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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

  programs.firefox = {
    enable = true;
    configPath = ".config/mozilla/firefox";
    profiles.bopsifox = {
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          sponsorblock
          vimium
          privacy-badger
        ];
      };
    };
  };
}
