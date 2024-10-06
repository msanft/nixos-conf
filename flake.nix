{
  description = "NixOS / Nix-Darwin Configuration of msanft";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    berkeley-mono = {
      url = "git+ssh://git@github.com/msanft/berkeley-mono";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    remote-builders = {
      url = "git+ssh://git@github.com/edgelesssys/nix-remote-builders";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homepage = {
      url = "github:msanft/homepage";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    rec {
      nixosConfigurations = {
        tp = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/tp/configuration.nix
            ./hosts/tp/hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            inputs.remote-builders.nixosModules.remote-builders
            inputs.lanzaboote.nixosModules.lanzaboote
            ./hosts/tp/disko.nix
            {
              home-manager.users.msanft.imports = [
                inputs.nixvim.homeManagerModules.nixvim
              ];
            }
          ];
          specialArgs = {
            inherit inputs;
          };
        };

        bastion = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/bastion/configuration.nix
            ./hosts/bastion/hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.users.msanft.imports = [
                inputs.nixvim.homeManagerModules.nixvim
              ];
            }
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

      colmena =
        {
          meta = {
            nixpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
            nodeNixpkgs = builtins.mapAttrs (_: v: v.pkgs) nixosConfigurations;
            nodeSpecialArgs = builtins.mapAttrs (_: v: v._module.specialArgs) nixosConfigurations;
            specialArgs.lib = inputs.nixpkgs.lib;
          };
        }
        // builtins.mapAttrs (_: v: {
          imports = v._module.args.modules;
        }) nixosConfigurations;

    }
    // inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {

        devShells.default = pkgs.mkShell {
          buildInputs = [
            inputs.colmena.packages.${system}.colmena
          ];
        };
      }
    );
}
