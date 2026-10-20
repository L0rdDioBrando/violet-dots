{
  stdenv,
  fetchurl,
  pkgs,
  ...
}:
let
  version = "1.15.0-alpha.12";
in
stdenv.mkDerivation {
  pname = "sing-box";
  version = "${version}";
  src = fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${version}/sing-box-${version}-linux-amd64.tar.gz";
    sha256 = "b107528ec7d989333d986573c097d840b9ef1afa9bb177f8eb03e0767f370514";
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
