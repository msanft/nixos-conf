{
  description = "NixOS / Nix-Darwin Configuration of msanft";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, darwin, stylix, ... }: {
    nixosConfigurations.tp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/tp/configuration.nix
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
      ];
    };
    darwinConfigurations.mb = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/mb/configuration.nix
        home-manager.darwinModules.home-manager
        stylix.darwinModules.stylix
      ];
    };
  };
}
