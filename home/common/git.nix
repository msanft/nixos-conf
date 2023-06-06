{ pkgs, ... }: {
  # home.packages = with pkgs; [
  #     # required for commit signing
  #     gnupg
  #     pinentry
  # ];

  programs.git = {
    enable = true;

    userName = "Moritz Sanft";
    userEmail = "58110325+msanft@users.noreply.github.com";

    # signing = {
    #     key = null;
    #     signByDefault = true;
    # };

    difftastic.enable = true;
  };
}
