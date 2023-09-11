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
      key = "BB8B30F5A024C31C";
      signByDefault = true;
    };

    difftastic.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      core.askPass = ""; # needs to be empty to use terminal for ask pass
    };
  };

}
