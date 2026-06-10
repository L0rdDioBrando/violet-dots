{ pkgs, ... }:

{
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
}
