{ ... }:

{
  imports = [
    ./imports.nix
    ./home-packages.nix
    ./style.nix
    ./default-apps.nix
    ./configs
  ];

  home.username = "bopsifox";
  home.homeDirectory = "/home/bopsifox";
  home.shell.enableZshIntegration = true;

  home.stateVersion = "24.11"; 
}
