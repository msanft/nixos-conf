{ config, ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableNushellIntegration = if config.programs.nushell.enable then true else false;

    settings = {
      update_check = false;
      style = "compact";
      inline_height = 10;
      show_preview = true;
    };
  };
}
