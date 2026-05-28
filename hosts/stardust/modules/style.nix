{ pkgs, ... }:

{
  # Catppuccin
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";
    sddm.font = "FiraCode Nerd Font";
    tty.enable = true;
    plymouth.enable = false;
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
      nerd-fonts.dejavu-sans-mono
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
}
