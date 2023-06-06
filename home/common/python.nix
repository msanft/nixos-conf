{ pkgs, ... }:
let
  pythonPackages = ps: with ps; [
    requests
    beautifulsoup4
    selenium
  ];
in
{
  home.packages = with pkgs; [
    (python3.withPackages pythonPackages)
  ];
}
