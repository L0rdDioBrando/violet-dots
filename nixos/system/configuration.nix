{ pkgs, inputs, ... }:

{
  # Imports
  imports = [
    ../hardware-configuration.nix
  ];

  # Experimental
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Nix Garbage Collector settings
  nix.settings.auto-optimise-store = true;

  # Bootloader
  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
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

  # Polkit agent
  systemd.user.services.hyprpolkitagent = {
    description = "hyprpolkitagent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Network
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      1111
      4533
      4010
      8080
    ];
    allowedUDPPorts = [
      1111
      4533
      4010
      8080
    ];
  };

  networking.nftables.enable = true;
  networking.enableIPv6 = false;

  # Cloudflare warp
  services.cloudflare-warp.enable = true;
  systemd.packages = [ pkgs.cloudflare-warp ];
  systemd.targets.multi-user.wants = [ "warp-svc.service" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XCURSOR_THEME = "catppuccin-macchiato-dark-cursors";
    TERMINAL_FONT = "FiraCode Nerd Font Mono";
    GTK_USE_PORTAL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = "*";
  };

  # Xserver
  services.xserver.enable = true;

  environment.pathsToLink = [ "/share/bash-completion" ];
  services.dbus.packages = [ pkgs.gcr ];

  # Sddm
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Configure xkb
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle,caps:escape";
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
    # Utils
    docker
    dracut
    sqlite
    limine-full
    nh
    nvd
    nix-output-monitor
    wireguard-tools
    pulseaudio
    (callPackage ./modules/naiveproxy.nix { })
    # Other
    cacert
  ];

  # Niri
  programs.niri.enable = true;
  #programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri; # Optional

  # Packages
  services.flatpak.enable = true;
  programs.xwayland.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.dbus.enable = true;
  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.amnezia-vpn.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
  programs.kdeconnect.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Nix helper settings
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
  };

  # Catppuccin
  catppuccin = {
    enable = false;
    flavor = "macchiato";
    accent = "lavender";
    tty.enable = true;
    limine.enable = true;
  };

  # Console
  console = {
    enable = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    packages = [ pkgs.terminus_font ];
  };

  console.useXkbConfig = true;

  # System font - FiraCode
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      terminus_font
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
        sansSerif = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };

  # System version
  system.stateVersion = "25.11";
}
