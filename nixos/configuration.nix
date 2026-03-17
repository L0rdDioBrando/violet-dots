{
  config,
  pkgs,
  inputs,
  ... 
}:

{
  # Imports
  imports = [
    ./hardware-configuration.nix 
  ];

  # Experimental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Nix Garbage Collector settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = false;
      efiSupport = true;
      device = "nodev";
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  # Kernel
  boot.kernelParams = [
    "amdgpu.dc=1" 
    "amdgpu.dpm=1" 
    "amdgpu.noretry=0"
  ];
  boot.kernelModules = [ "nft_queue" "nfnetlink_queue" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Network
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  networking.enableIPv6 = true;

  # Time zone
  time.timeZone = "Asia/Yekaterinburg";

  # Locale
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Console
  i18n.supportedLocales = [ "ru_RU.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];

  console = {
    enable = true;
    colors = [
      "24273a" # black
      "ed8796" # red
      "a6da95" # green
      "eed49f" # yellow
      "8aadf4" # blue
      "f5bde6" # magenta
      "91d7e3" # cyan
      "cad3f5" # white
      "5b6078" # bright black
      "ed8796" # bright red
      "a6da95" # bright green
      "eed49f" # bright yellow
      "b7bdf8" # bright blue
      "f5bde6" # bright magenta
      "91d7e3" # bright cyan
      "a5adcb" # bright white
    ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    packages = [ pkgs.terminus_font ];
};

  # System fonts - FiraCode
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      font-awesome
      corefonts
      terminus_font
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
        sansSerif = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };

  # Xserver
  services.xserver.enable = true;
  security.polkit.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.pathsToLink = [ "/share/bash-completion" ];
  services.dbus.packages = [ pkgs.gcr ];

  # Catppuccin sddm
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";
    sddm.enable = true;
  };

  # Sddm
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Desktops
  programs.niri.enable = true;
  services.desktopManager.plasma6.enable = false;
  programs.river-classic.enable = true;

  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    XWAYLAND_NO_GLAMOR = "0";
    XCURSOR_THEME = "catppuccin-macchiato-dark-cursors";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
    TERMINAL_FONT = "FiraCode Nerd Font Mono";
    AMD_VULKAN_ICD = "RADV";
    LIBVA_DRIVER_NAME = "radeonsi";
    GTK_USE_PORTAL = "1";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # User
  users.users.user = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "docker" ];
  };

  # Xkb
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  console.useXkbConfig = true;

  # Packages
  systemd.packages = [ pkgs.cloudflare-warp ];
  systemd.targets.multi-user.wants = [ "warp-svc.service" ];
  programs.firefox.enable = true;
  services.zapret = {
    enable = true;
    params = [
      "--dpi-desync=disorder2"
      "--dpi-desync-split-pos=midsld"
      "--dpi-desync-ttl=3"
      "--dpi-desync-any-protocol=yes"
      "--dpi-desync-repeats=6"
    ];
  };
  services.flatpak.enable = true;
  programs.xwayland.enable = true;
  programs.zsh.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.dbus.enable = true;
  programs.nix-ld.enable = true;
  
  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.etc."xdg/menus/applications.menu".source = "${pkgs.gnome-menus}/etc/xdg/menus/applications.menu";

  # System packages
  environment.systemPackages = with pkgs; [
    # Utils
    wget
    pkgs.cloudflare-warp
    psmisc
    tmux
    bc
    unzip
    chafa
    p7zip
    fd
    bat
    eza
    curl
    git
    unrar
    playerctl
    steam-run
    steam
    docker
    # Languages
    python3
    nodejs
    go
    lua
    luarocks
    lua51Packages.jsregexp
    lua-language-server
    # libraries
    libXi
    libXcursor
    libnotify
    libXinerama
    # Other
    vulkan-tools
    cacert
  ];

  # System version
  system.stateVersion = "25.05";
}
