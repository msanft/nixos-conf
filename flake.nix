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
  };

  outputs = inputs @ { self, nixpkgs, home-manager, darwin, ... }:
    let
      mk-darwin = import ./util/mk-darwin.nix;
      mk-linux = import ./util/mk-linux.nix;
    in
    {
      nixosConfigurations.tp = mk-linux "tp" {
        inherit nixpkgs home-manager;
        system = "x86_64-linux";
      };
      darwinConfigurations.mb = mk-darwin "mb" {
        inherit darwin nixpkgs home-manager;
        system = "aarch64-darwin";
      };
    };
}
