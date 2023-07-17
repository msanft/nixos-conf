{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      cat = "${pkgs.bat}/bin/bat";
      ls = "${pkgs.exa}/bin/exa";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
