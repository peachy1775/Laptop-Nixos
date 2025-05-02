{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixcord.url = "github:kaylorben/nixcord";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs-stable, nixpkgs, home-manager, stylix, nixcord, ... }:
    let
      system = "x86_64-linux";

      overlays = [ ];

      unstable = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      stable = import nixpkgs-stable {
        inherit system overlays;
        config.allowUnfree = true;
      };
      pkgs = unstable;

    in {
      nixosConfigurations.peaches = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./config/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [ inputs.nixcord.homeModules.nixcord ];
              users.peaches = ./home/home.nix;
              extraSpecialArgs = {
                inherit pkgs unstable stable inputs;
                username = "peaches";
              };
            };
          }
          stylix.nixosModules.stylix
        ];
      };
      formatter.${system} = pkgs.nixfmt-classic;
    };
}
