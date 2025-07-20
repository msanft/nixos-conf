{ config, ... }:
{
  imports = [
    ./atuin.nix
    ./ghostty.nix
    ./nushell.nix
    ./tmux.nix
    ./starship.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableNushellIntegration = if config.programs.nushell.enable then true else false;
  };

  programs.nix-your-shell = {
    enable = true;
    enableNushellIntegration = if config.programs.nushell.enable then true else false;
  };

  programs.ripgrep.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
  };

  programs.carapace = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableNushellIntegration = if config.programs.nushell.enable then true else false;
  };
}
