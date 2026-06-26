{ pkgs, ... }:

{
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

  # Packages
  services.flatpak.enable = true;
  programs.xwayland.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.dbus.enable = true;
  programs.nix-ld.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    gamescopeSession.enable = true;
  };
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.amnezia-vpn.enable = true;
  services.sing-box = {
    enable = false;
    settings = {
      log = {
        level = "info";
      };
      inbounds = [
        {
          type = "socks";
          listen = "127.0.0.1";
          listen_port = 1080;
        }
      ];
      outbounds = [
        {
          type = "vless";
          tag = "proxy";
          server = "212.113.104.148";
          server_port = 443;
          uuid = "1b831036-b70f-4c86-9b3f-fd2ba3771732";
          flow = "xtls-rprx-vision";
          tls = {
            enabled = true;
            server_name = "www.asus.com";
            utls = {
              enabled = true;
              fingerprint = "firefox";
            };
            reality = {
              enabled = true;
              public_key = "qZux7SVDs3RegL-faeG1AXKpPYn1sHz_e1HUSKW9e3o";
              short_id = "cf";
            };
          };
        }
      ];
    };
  };
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

  # Nix helper settings
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
  };
}
