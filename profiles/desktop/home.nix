{ pkgs, ... }:
{
  imports = [
    ../../modules/home/browser/chromium
    ../../modules/home/browser/firefox
    ../../modules/home/git.nix
    ../../modules/home/nixvim.nix
    ../../modules/home/shell
    ../../modules/home/thunderbird.nix
    ../../modules/home/vscode.nix
  ];
}
