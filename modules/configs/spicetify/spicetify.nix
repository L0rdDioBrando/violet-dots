{ inputs, pkgs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    wayland = true;
    theme = {
      name = "my-custom-theme";
      src = ./theme;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
    colorScheme = "Base";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullAppDisplay
      shuffle
      history
      hidePodcasts
      beautifulLyrics
      wikify
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
      lyricsPlus
      marketplace
    ];
  };
}
