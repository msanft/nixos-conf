{ ... }: {
  stylix.targets.zellij.enable = false;
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "custom";
      themes.custom.fg = "#ffffff";
    };
  };
}
