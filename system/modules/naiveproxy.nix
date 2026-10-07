{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  nss,
  nspr,
}:

stdenv.mkDerivation rec {
  pname = "naiveproxy";
  version = "150.0.7871.63-1";

  src = fetchurl {
    url = "https://github.com/klzgrad/naiveproxy/releases/download/v150.0.7871.63-1/naiveproxy-v150.0.7871.63-1-linux-x64.tar.xz";
    sha256 = "0c4f506ce66a7881892fd6932b542c53fc06ac2351987756096c61e753c687bf";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    nss
    nspr
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp naive $out/bin/
  '';
}
