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
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.kdeconnect.enable = true;

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

  # Cache
  #  nix.settings = {
  #    substituters = [
  #      "https://cache.nixos.org/"
  #      "https://nix-community.cachix.org"
  #    ];
  #    trusted-public-keys = [
  #      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #    ];
  #  };

  # Nix helper settings
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
  };
}
