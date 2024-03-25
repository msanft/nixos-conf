{ pkgs, ... }:
let
  pythonPackages = ps: with ps; [
    # requests
    # beautifulsoup4
    # selenium
    # jupyter
    # ipython
    # numpy
    # z3
    # pwntools
  ];
in
{
  home.packages = with pkgs; [
    (python3.withPackages pythonPackages)
  ];
}
