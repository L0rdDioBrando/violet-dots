{
  stdenv,
  fetchurl,
  pkgs,
  ...
}:

stdenv.mkDerivation {
  pname = "sing-box";
  version = "1.15.0-alpha.11";
  src = fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.11/sing-box-1.15.0-alpha.11-linux-amd64.tar.gz";
    sha256 = "00ecddab834733212260164772b6349af24827a8d103b3152ca55607c37c9fd8";
  };
  nativeBuildInputs = [ pkgs.autoPatchelfHook ];
  buildInputs = [ pkgs.stdenv.cc.cc.lib ];
  installPhase = ''
    mkdir -p $out/bin
    cp sing-box $out/bin/sing-box
    cp libcronet.so $out/bin/libcronet.so
    chmod +x $out/bin/sing-box
  '';
}
