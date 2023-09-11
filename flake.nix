{
  description = "NixOS / Nix-Darwin Configuration of msanft";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, darwin, nixvim, ... }: {
    nixosConfigurations.tp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/tp/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.moritzs.imports = [
            nixvim.homeManagerModules.nixvim
          ];
        }
      ];
    };
    darwinConfigurations.mb = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/mb/configuration.nix
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
