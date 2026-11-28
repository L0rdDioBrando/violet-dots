{
  pkgs,
  fetchurl,
  lib,
  makeWrapper,
  ...
}:
pkgs.appimageTools.wrapType2 (finalAttrs: {
  pname = "osu!";
  version = "2026.1117.0-lazer";
  src = fetchurl {
    url = "https://github.com/ppy/osu/releases/download/${finalAttrs.version}/osu.AppImage";
    sha256 = "sha256:4ebbcb5b581c036f16785500af5c8d13ad1e6d93196fd36be8f245c2a0ea1d2d";
  };
  extraPkgs =
    pkgs: with pkgs; [
      icu
    ];
  extraInstallCommands = ''
    . ${makeWrapper}/nix-support/setup-hook
    install -m 444 -D ${finalAttrs.contents}/osu!.desktop -t $out/share/applications
    for i in 16 32 48 64 96 128 256 512 1024; do
      install -D ${finalAttrs.contents}/osu.png $out/share/icons/hicolor/''${i}x$i/apps/osu.png
    done
  '';
  meta = {
    description = "Rhythm is just a *click* away (AppImage version for score submission and multiplayer, and binary distribution for Darwin systems)";
    homepage = "https://osu.ppy.sh";
    changelog = "https://osu.ppy.sh/home/changelog/lazer/${finalAttrs}";
    license = with lib.licenses; [
      mit
      cc-by-nc-40
      unfreeRedistributable # osu-framework contains libbass.so in repository
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [
      gepbird
      stepbrobd
      Guanran928
    ];
    mainProgram = "osu!";
    platforms = [
      "x86_64-linux"
    ];
  };
})
