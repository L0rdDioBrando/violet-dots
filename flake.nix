# flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    catppuccin.url = "github:catppuccin/nix";
    pineconemc = {
      url = "github:ElyPrismLauncher/Launcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs =
    {
      nixpkgs,
      catppuccin,
      home-manager,
      zapret-discord-youtube,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ({ ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                limine = prev.limine.overrideAttrs {
                  version = "12.11.1";
                  src = final.fetchurl {
                    url = "https://github.com/Limine-Bootloader/Limine/releases/download/v12.11.1/limine-12.11.1.tar.gz";
                    hash = "sha256:95b4b52fbafeebad14d5faf9e73bf974da58f68d41d1713bcc452712baddebbd";
                  };
                };
              })
            ];
          })
          ./configuration.nix
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          zapret-discord-youtube.nixosModules.withTestTools
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.bopsifox = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };
}
