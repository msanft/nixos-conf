{ pkgs, ... }: {
  home.packages = with pkgs; [
    # required for commit signing
    gnupg
    pinentry
  ];

  programs.git = {
    enable = true;

    userName = "Moritz Sanft";
    userEmail = "58110325+msanft@users.noreply.github.com";

    signing = {
      key = "899A193768C34EEA";
      signByDefault = true;
    };

    difftastic.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      core.askPass = ""; # needs to be empty to use terminal for ask pass
    };
  };



}
