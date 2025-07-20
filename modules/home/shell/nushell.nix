{ pkgs, ... }:
{
  home.shell.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;

    shellAliases = import ./aliases.nix { inherit pkgs; };

    extraConfig = ''
      $env.GPG_TTY = (tty)
      ${pkgs.gnupg}/bin/gpg-connect-agent --quiet updatestartuptty /bye | ignore
      $env.SSH_AUTH_SOCK = ($env.SSH_AUTH_SOCK? | default (${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket))
    '';

    extraEnv = ''
      $env.config.buffer_editor = "code"
      $env.config.show_banner = false
    '';
  };
}
