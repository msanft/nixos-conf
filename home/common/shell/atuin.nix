{ ... }: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      update_check = false;
    };
  };
}
