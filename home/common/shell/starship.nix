{ config, pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;
      cmake.disabled = true;
      python.disabled = true;
      golang.disabled = true;
      terraform.disabled = true;

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

      line_break.disabled = true;
    };
  };
}
