# https://github.com/mitchellh/nixos-config/blob/main/lib/mkdarwin.nix
host: { darwin, nixpkgs, home-manager, system }:

darwin.lib.darwinSystem rec {
  inherit system;

  modules = [
    ../hosts/${host}/configuration.nix
    home-manager.darwinModules.home-manager
  ];
}
