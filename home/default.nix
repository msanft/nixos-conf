{config, pkgs, lib, ...}: {
    imports = [
        ./shell
        ./git.nix
        ./wm
    ];

    programs.vscode.enable = true;
    programs.chromium.enable = true;

    home.packages = with pkgs; [
      gh
      go
      gopls
      gotools
      gdb
      pwndbg
      file
      python3
      nix-ld
    ];
}
