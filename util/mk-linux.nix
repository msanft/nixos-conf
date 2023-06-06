host: { nixpkgs, home-manager, system }:

nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    ../hosts/${host}/configuration.nix
    home-manager.darwinModules.home-manager
  ];
}
