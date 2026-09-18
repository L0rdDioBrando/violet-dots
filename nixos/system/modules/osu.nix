{
  pkgs ? import <nixpkgs> { },
}:

let
  pname = "osu!";
  version = "2026.804.2";
  src = pkgs.fetchurl {
    url = "https://github.com/ppy/osu/releases/download/2026.804.2-lazer/osu.AppImage";
    sha256 = "d0afddcaf230ae507371ec580c20a294d92725d1198dad4e4df028b4fe8cbe36";
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
