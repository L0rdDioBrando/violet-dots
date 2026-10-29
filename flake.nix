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
      url = "github:0xc000022070/zen-browser-flake";
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
                limine = prev.limine.overrideAttrs (finalAttrs: {
                  version = "12.9.4";
                  src = final.fetchurl {
                    url = "https://github.com/Limine-Bootloader/Limine/releases/download/v${finalAttrs.version}/limine-${finalAttrs.version}.tar.gz";
                    hash = "sha256:4f75ffca8e11a1030e43e2b9ab82fac1a0f8985e1c40d429fea9fd2972693447";
                  };
                });
                zapret2 = prev.zapret2.overrideAttrs (finalAttrs: {
                  src = prev.fetchFromGitHub {
                    owner = "bol-van";
                    repo = "zapret2";
                    tag = "v${finalAttrs.version}";
                    hash = "sha256-hDETz/EFqrIbtgg8cv0tK+yTsrN+dnkd3oobHmBBmRA=";
                    leaveDotGit = true;
                    postFetch = ''
                      cd "$out"
                      git rev-parse --short=12 HEAD > COMMIT
                      find "$out" -name .git -print0 | xargs -0 rm -rf
                    '';
                  };
                });
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
