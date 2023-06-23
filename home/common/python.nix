{ pkgs, ... }:
let
  pythonPackages = ps: with ps; [
    requests
    beautifulsoup4
    selenium
    jupyter
    ipython
    numpy
  ];
in
{
  home.packages = with pkgs; [
    (python3.withPackages pythonPackages)
  ];
}
