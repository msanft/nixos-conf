{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    ida-pro-overlay = {
      url = "github:msanft/ida-pro-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    {
      nixosConfigurations = {
        bastion = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/bastion/configuration.nix
            ./hosts/bastion/hardware-configuration.nix
            inputs.determinate.nixosModules.default
            inputs.lanzaboote.nixosModules.lanzaboote
            {
              nixpkgs.overlays = [
                inputs.ida-pro-overlay.overlays.default
              ];
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
