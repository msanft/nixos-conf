{ pkgs, ... }: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../../overlays/mkChromiumDesktopApp.nix)
    ];
  };
}
