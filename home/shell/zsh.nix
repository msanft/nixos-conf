{config, pkgs, ...}: {
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;

        shellAliases = {
            update = "sudo nixos-rebuild switch";
        };

        history = {
            size = 10000;
            path = "${config.xdg.dataHome}/zsh/history";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "sudo" "colored-man-pages" ];
            theme = "robbyrussell";
        };
    };
}
