{ config, ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableZshIntegration = if config.programs.zsh.enable then true else false;

    settings = {
      update_check = false;
      style = "compact";
      inline_height = 10;
      show_preview = true;
    };
  };
}
