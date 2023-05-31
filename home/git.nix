{pkgs, ...}: {
    programs.git = {
        enable = true;

        userName = "Moritz Sanft";
        userEmail = "58110325+msanft@users.noreply.github.com";

        signing = {
            signByDefault = true;
        };

        difftastic.enable = true;
    };
}
