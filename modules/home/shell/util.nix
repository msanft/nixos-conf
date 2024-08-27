{ pkgs, config, ... }:
{
  programs.ripgrep.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableZshIntegration = if config.programs.zsh.enable then true else false;
  };
}
