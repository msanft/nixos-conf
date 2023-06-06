{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    casks = [
      "amethyst"
      # "docker" fails due to (probably) other packages depending on docker, homebrew refuses to replace it
    ];
  };
}
