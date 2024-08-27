{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = import ./aliases.nix { inherit pkgs; };
  };
}
