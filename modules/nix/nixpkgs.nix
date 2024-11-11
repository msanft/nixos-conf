{ ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };

    overlays = [
      (import ../../overlays/mkDesktopApp.nix)
    ];
  };
}
