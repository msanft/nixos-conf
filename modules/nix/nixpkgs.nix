{ pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      (import ../../overlays/mkDesktopApp.nix)
    ];
  };
}
