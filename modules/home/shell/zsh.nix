{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      cat = "${pkgs.bat}/bin/bat";
      ls = "${pkgs.exa}/bin/exa";
      ll = "ls -la";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
