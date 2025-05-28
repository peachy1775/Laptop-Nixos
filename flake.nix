{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix";
    nixcord.url = "github:kaylorben/nixcord";
    treefmt-nix.url = "github:numtide/treefmt-nix";

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
    inputs@{
      nixpkgs-stable,
      nixpkgs,
      home-manager,
      stylix,
      nixcord,
      ...
    }:
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

    in
    {
      nixosConfigurations.peaches = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [ inputs.nixcord.homeModules.nixcord ];
              users.peaches = ./home/home.nix;
              extraSpecialArgs = {
                inherit
                  pkgs
                  unstable
                  stable
                  inputs
                  ;
                username = "peaches";
              };
            };
          }
          stylix.nixosModules.stylix
        ];
      };
      formatter.${system} = inputs.treefmt-nix.lib.mkWrapper pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    };
}
