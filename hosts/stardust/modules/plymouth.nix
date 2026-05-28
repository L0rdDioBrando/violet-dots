{ pkgs, lib, ... }:

let
  myCustomTheme = pkgs.stdenv.mkDerivation {
    pname = "my-custom-plymouth-theme";
    version = "1.0";
    src = ./my-theme; 
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/plymouth/themes/my-theme
      cp * $out/share/plymouth/themes/my-theme
      find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
    '';
  };
in
{
  options.mySystem.plymouth.enable = lib.mkEnableOption "Custom Plymouth boot splash";

  config = lib.mkIf true {
    boot.plymouth = {
      enable = true;
      theme = "my-theme";
      themePackages = [ myCustomTheme ];
    };
  };
}
