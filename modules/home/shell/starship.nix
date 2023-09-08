{ config, ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableZshIntegration = if config.programs.zsh.enable then true else false;

    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;

      username = {
        format = "[$user]($style)@";
        show_always = true;
      };

      hostname = {
        ssh_only = false;
      };

      directory = {
        truncation_length = 1;
        read_only = "";
        format = "[$path]($style) [$read_only]($read_only_style)";
      };

      git_branch = {
        symbol = "";
        format = "on [$symbol $branch(:$remote_branch)]($style) ";
      };

      kubernetes.disabled = false;

      line_break.disabled = false;
    };
  };
}
