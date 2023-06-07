{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    casks = [
      # "docker" fails due to (probably) other packages depending on docker, homebrew refuses to replace it
    ];
  };
}
