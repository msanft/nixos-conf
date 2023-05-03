{config, pkgs, lib, ...}: {
    imports = [
        ./shell
        ./git.nix
    ];


    programs.vscode.enable = true;
    programs.chromium.enable = true;

    home.packages = with pkgs; [
      neofetch
      gh
      go
      gopls
      gotools
    ];
}
