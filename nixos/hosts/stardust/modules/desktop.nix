{ pkgs, inputs, ... }:
{
  # Niri
  programs.niri.enable = true;
  #programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri; # Optional

  environment.sessionVariables = {
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    XCURSOR_THEME = "catppuccin-macchiato-dark-cursors";
    TERMINAL_FONT = "FiraCode Nerd Font Mono";
    GTK_USE_PORTAL = "1";
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
}
