{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    brews = [
      "helm"
    ];
  };
}
