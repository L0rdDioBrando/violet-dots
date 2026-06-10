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
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # Catppuccin
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";
    kvantum.enable = false;
    bat.enable = true;
    yazi.enable = false;
    kitty.enable = true;
    zathura.enable = true;
    obs.enable = true;
    mpv.enable = true;
    cava.enable = false;
    lazygit.enable = true;
    zellij.enable = false;
  };

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
    file
    tldr
    fd
    jq
    viu
    gvfs
    ffmpeg-full
    ueberzugpp
    dust
    duf
    bc
    lazygit
    wl-clipboard
    cliphist
    ninja
    cmake
    pkg-config
    nicotine-plus
    # Graphics and media
    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    osu-lazer-bin
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
    kdlfmt
    gnumake
    luarocks
    lua51Packages.jsregexp
    lua51Packages.tree-sitter-cli
    lua-language-server
    vscode-langservers-extracted
    # XWayland
    xwayland-satellite
    # Qt
    pkgs.kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.kde-cli-tools
    # Cursors
    catppuccin-cursors.macchiatoDark
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

  # Yazi
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };

  # Fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
