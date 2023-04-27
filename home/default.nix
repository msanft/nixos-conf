{config, pkgs, lib, ...}: {
    imports = [
        ./shell
    ];

    programs.git.enable = true;

    home.packages = with pkgs; [
      gh
      go
      gopls
      gotools
    ];
}
