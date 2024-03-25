{ config, pkgs, ... }: {
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = if config.programs.bash.enable then true else false;
    enableZshIntegration = if config.programs.zsh.enable then true else false;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
