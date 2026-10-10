{
  stdenv,
  fetchurl,
  ...
}:

stdenv.mkDerivation {
  pname = "naiveproxy";
  version = "154.0.8037.49-4";

  src = fetchurl {
    url = "https://github.com/klzgrad/naiveproxy/releases/download/v154.0.8037.49-4/naiveproxy-v154.0.8037.49-4-linux-x64.tar.xz";
    sha256 = "9d765620b90f7c60eb40c7c68b2f82537757cc52a8693dee7a00f8ba8b13dfd0";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp naive $out/bin/naive
    chmod +x $out/bin/naive
  '';
}
