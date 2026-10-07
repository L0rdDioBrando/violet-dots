{
  pkgs ? import <nixpkgs> { },
}:

let
  pname = "osu!";
  version = "2026.804.2";
  src = pkgs.fetchurl {
    url = "https://github.com/ppy/osu/releases/download/2026.1005.1-tachyon/osu.AppImage";
    sha256 = "sha256:742fd1ee1d0e9161ab46188ae46e658057e0849a2e08d290b96f8b69cf54476e";
  };

  appimageContents = pkgs.appimageTools.extract {
    inherit pname version src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [
    pkgs.icu
  ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications $out/share/icons
    cp ${appimageContents}/*.desktop $out/share/applications/
    cp -r ${appimageContents}/usr/share/icons/* $out/share/icons/ || true
    sed -i 's/Exec=.*/Exec=${pname}/' $out/share/applications/*.desktop
  '';
}
