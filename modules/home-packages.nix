{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
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
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    chromium
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
    ghostty
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
