{ config, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableZshIntegration = if config.programs.zsh.enable then true else false;

    settings = {
      format = "$time$all";
      add_newline = false;

      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;
      golang.disabled = true;
      nix_shell.disabled = true;
      c.disabled = true;
      direnv.disabled = true;
      docker_context.disabled = true;
      nodejs.disabled = true;

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✖](bold red)";
      };

      username = {
        format = "[$user]($style):(grey)";
        show_always = true;
      };

      git_branch = {
        format = "@ [$branch(:$remote_branch)]($style) ";
      };

      time = {
        disabled = false;
        format = "[\\[$time\\]](bold dark grey) ";
        time_format = "%R";
      };

      line_break.disabled = false;

      kubernetes.disabled = false;
    };
  };
}
