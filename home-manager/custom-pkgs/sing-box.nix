{
  stdenv,
  fetchurl,
  pkgs,
  ...
}:
let
  version = "1.15.0-alpha.15";
in
stdenv.mkDerivation {
  pname = "sing-box";
  version = "${version}";
  src = fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${version}/sing-box-${version}-linux-amd64.tar.gz";
    sha256 = "sha256:bd190adf2d1c3a3a77a1e4859bbda7768149ff4dadc2ce6c0c7d2b474d955fbf";
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
