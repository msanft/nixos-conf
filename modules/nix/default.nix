{ pkgs, ... }: {
  imports = [
    ./nix.nix
    ./nixpkgs.nix
    ./remote-builders.nix
  ];
}
