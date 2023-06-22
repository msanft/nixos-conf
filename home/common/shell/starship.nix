{ config, pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;

      directory = {
        truncation_length = 1;
        read_only = "";
        format = "[$path]($style) [$read_only]($read_only_style)";
      };

      git_branch = {
        symbol = "";
        format = "on [$symbol $branch(:$remote_branch)]($style) ";
      };

      golang.symbol = "";

      kubernetes.disabled = false;

      line_break.disabled = true;

      python.symbol = "";

      terraform = {
        symbol = "󱁢";
        format = "via [$symbol $workspace]($style)";
      };
    };
  };
}
