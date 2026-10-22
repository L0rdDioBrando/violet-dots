{
  stdenv,
  fetchurl,
  ...
}:
let
  version = "154.0.8037.49-5";
in
stdenv.mkDerivation {
  pname = "naiveproxy";
  version = "${version}";
  src = fetchurl {
    url = "https://github.com/klzgrad/naiveproxy/releases/download/v${version}/naiveproxy-v${version}-linux-x64.tar.xz";
    sha256 = "sha256:80214dfea1767f6ecf63a3a79dc9f48b203460f51abc609357fff48dd5844c7d";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp naive $out/bin/naive
    chmod +x $out/bin/naive
  '';
  doCheck = false;
}
