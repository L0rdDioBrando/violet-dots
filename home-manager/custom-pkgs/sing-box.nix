{
  stdenv,
  fetchurl,
  pkgs,
  ...
}:
let
  version = "1.15.0-alpha.13";
in
stdenv.mkDerivation {
  pname = "sing-box";
  version = "${version}";
  src = fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${version}/sing-box-${version}-linux-amd64.tar.gz";
    sha256 = "sha256:bfc39f643a5ecc1b702c5723ff662e61dde813f12b3af0d0cfce4f629ff74047";
  };
  buildInputs = [ pkgs.stdenv.cc.cc.lib ];
  installPhase = ''
    mkdir -p $out/bin
    cp sing-box $out/bin/sing-box
    cp libcronet.so $out/bin/libcronet.so
    chmod +x $out/bin/sing-box
  '';
  doCheck = false;
}
