{ config, pkgs, ... }: {
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };

  home.packages = with pkgs; [
    pinentry-curses
  ];
}
