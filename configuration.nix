{ pkgs, ... }:

{
  # Imports
  imports = [
    ./hardware-configuration.nix
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ]; # Enable flakes
    auto-optimise-store = true; # Nix Garbage Collector settings
  };

  # Bootloader
  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
      extraConfig = "
        timeout: 5
        term_palette: 24273a;ed8796;a6da95;eed49f;8aadf4;f5bde6;8bd5ca;cad3f5
        term_palette_bright: 5b6078;ed8796;a6da95;eed49f;8aadf4;f5bde6;8bd5ca;cad3f5
        term_background: 8024273a
        term_foreground: cad3f5
        term_background_bright: 5b6078
        term_foreground_bright: cad3f5
        interface_branding_color: b7bdf8
        interface_help_color: b7bdf8
        interface_help_color_bright: b7bdf8
      ";
      style = {
        wallpapers = [ ./home-manager/configs/niri/wallpapers/wallhaven-45ydw7_1920x1080.png ];
      };
      maxGenerations = 10;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  # Kernel
  boot.kernelModules = [
    "nft_queue"
    "nfnetlink_queue"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # Disk
  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/74762bf2-2f76-47ef-a3f1-adc34549cced";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    enableRedistributableFirmware = true;
  };

  # Choose your locale
  i18n.supportedLocales = [
    "ru_RU.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Select your time zone
  time.timeZone = "Asia/Yekaterinburg";

  # Polkit
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Network
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      1111
    ];
    allowedUDPPorts = [
      1111
    ];
  };

  networking.nftables.enable = true;
  networking.enableIPv6 = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # XDG
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Console
  console = {
    enable = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    packages = [ pkgs.terminus_font ];
    useXkbConfig = true;
  };

  # Xserver
  services.xserver.enable = true;

  # XKB settings
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle,caps:escape";
  };

  # Session variables
  environment.sessionVariables = {
    NH_OS_FLAKE = "/etc/nixos";
  };

  # Catppuccin
  catppuccin = {
    enable = false;
    flavor = "macchiato";
    accent = "lavender";
    tty.enable = true;
    sddm.enable = true;
  };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  # User
  users.defaultUserShell = pkgs.zsh;
  users.users.bopsifox = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "bopsifox";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "docker"
    ];
  };

  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    limine-full
    cacert
  ];

  # Packages
  programs.niri.enable = true;
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  virtualisation.docker.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr_4 ];
  };
  programs.xwayland.enable = true;
  programs.zsh.enable = true;
  hardware.steam-hardware.enable = true;
  programs.steam = {
    # I use "gamescope -W 1920 -H 1080 -f -b --force-grab-cursor --backend wayland -- %command%" steam launch arguments
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.kdeconnect.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.proxychains = {
    enable = true;
    proxyDNS = true;
    package = pkgs.proxychains-ng;
    proxies = {
      myproxy = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 8080;
      };
    };
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      fuse3
      alsa-lib
      icu
      libadwaita
      gtk4
      graphene
      libGLU
      libepoxy
      SDL2
      (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };

  # System version
  system.stateVersion = "26.05";
}
