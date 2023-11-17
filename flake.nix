{
  description = "NixOS / Nix-Darwin Configuration of msanft";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    berkeley-mono = {
      url = "git+ssh://git@github.com/msanft/berkeley-mono";
      inputs.nixpkgs.follows = "nixpkgs";
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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: with inputs; {

    nixosConfigurations.tp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/tp/configuration.nix
        ./hosts/tp/hardware-configuration.nix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        ./hosts/tp/disko.nix
        {
          home-manager.users.moritzs.imports = [
            nixvim.homeManagerModules.nixvim
          ];
        }
      ];
      specialArgs = { inherit inputs; };
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
