{
  description = "NixOS Configuration of msanft";

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
  };

  outputs = inputs @ {self, nixpkgs, home-manager, darwin, ...}: let
    mk-darwin = import ./util/mk-darwin.nix;
  in {
    nixosConfigurations.tp = nixpkgs.lib.nixosSystem {
      inherit nixpkgs home-manager;
      system = "x86_64-linux";
      modules = [ ./tp/configuration.nix ];
    };
    darwinConfigurations.mb = mk-darwin "mb" {
      inherit darwin nixpkgs home-manager;
      system = "aarch64-darwin";
    };
  };
}
