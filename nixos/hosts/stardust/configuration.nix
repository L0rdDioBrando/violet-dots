{ pkgs, ... }:

{
  # Imports
  imports = [
    ../../hardware-configuration.nix
    ./modules
  ];

  # Experimental
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Nix Garbage Collector settings
  nix.settings.auto-optimise-store = true;

  # Polkit
  security.polkit.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    # Other
    cacert
  ];

  # System version
  system.stateVersion = "25.11";
}
