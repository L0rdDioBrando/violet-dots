{
  pkgs ? import <nixpkgs> { },
}:

let
  pname = "osu!";
  version = "2026.804.2";
  src = pkgs.fetchurl {
    url = "https://github.com/ppy/osu/releases/download/2026.921.0-lazer/osu.AppImage";
    sha256 = "dced9463b501009c95dbed891abd2f0acc2efb84ee4336f5b1cc3b7c04a5fc7d";
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
