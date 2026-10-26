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
    url = "https://github.com/SagerNet/sing-box/releases/download/v${version}/sing-box-${version}-linux-amd64-glibc.tar.gz";
    sha256 = "sha256:bbacd7b220ca9bd361e6f4d2cc716fd8d7ac2d821f18c6276175e72ba6f0a61a";
  };
  buildInputs = [ pkgs.stdenv.cc.cc.lib ];
  installPhase = ''
    mkdir -p $out/bin
    cp sing-box $out/bin/sing-box
    chmod +x $out/bin/sing-box
  '';
  doCheck = false;
}
