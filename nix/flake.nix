{
  description = "Nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin-login-items.url = "github:uncenter/nix-darwin-login-items";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      darwin-login-items,
      ...
    }:
    let
      user = import ./user.nix;
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      mkDarwinConfiguration =
        system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            darwin-login-items.darwinModules.default
            (
              { pkgs, ... }:
              import ./darwin.nix {
                inherit self pkgs user;
              }
            )
          ];
        };
    in
    {
      darwinConfigurations."Arturs-MacBook-Pro" = mkDarwinConfiguration "aarch64-darwin";
      darwinConfigurations."MacBook-Pro-Andrej-2" = mkDarwinConfiguration "x86_64-darwin";

      homeConfigurations.${user.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        modules = [
          ./home.nix
          { _module.args = { inherit user; }; }
        ];
      };

      homeConfigurations.andrey = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        modules = [
          ./home.nix
          { _module.args = { inherit user; }; }
        ];
      };
    };
}
