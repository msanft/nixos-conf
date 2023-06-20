{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    casks = [
      "docker"
      "cron"
      "zotero"
    ];
  };
}
