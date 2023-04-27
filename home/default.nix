{config, pkgs, lib, ...}: {
    imports = [
        ./shell
    ];

    programs.git.enable = true;
    programs.vscode.enable = true;
    programs.chromium.enable = true;

    home.packages = with pkgs; [
      gh
      go
      gopls
      gotools
    ];
}
