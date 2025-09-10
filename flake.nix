{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    disko.url = "github:nix-community/disko";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ida-pro-overlay = {
      url = "github:msanft/ida-pro-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    rec {
      nixosConfigurations = {
        bastion = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/bastion/configuration.nix
            ./hosts/bastion/hardware-configuration.nix
            {
              nixpkgs.overlays = [
                inputs.ida-pro-overlay.overlays.default
              ];
            }
            inputs.determinate.nixosModules.default
          ];
          specialArgs = {
            inherit inputs;
          };
        };

        "zeitgeist.msanft.home" = inputs.nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/zeitgeist/configuration.nix
            ./hosts/zeitgeist/hardware-configuration.nix
            inputs.disko.nixosModules.disko
            ./hosts/zeitgeist/disko.nix
          ];
          specialArgs = {
            homepage = inputs.homepage.packages.${system}.default;
          };
        };
      };

      devShells.x86_64-linux.default =
        let
          pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
        in
        pkgs.mkShell {
          buildInputs = [
            pkgs.colmena
          ];
        };

      colmena = {
        meta = {
          nixpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
          nodeNixpkgs = builtins.mapAttrs (_: v: v.pkgs) nixosConfigurations;
          nodeSpecialArgs = builtins.mapAttrs (_: v: v._module.specialArgs) nixosConfigurations;
          specialArgs.lib = inputs.nixpkgs.lib;
        };
      }
      // builtins.mapAttrs
        (_: v: {
          imports = v._module.args.modules;
        })
        nixosConfigurations;
    };
}
