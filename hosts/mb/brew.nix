{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    brews = [
      "helm"
    ];

    casks = [
      "docker"
      "cron"
    ];
  };
}
