{ pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      permittedInsecurePackages = [ 1"nix-2.16.2" ];
    };

    overlays = [
      (import ../../overlays/mkDesktopApp.nix)
    ];
  };
}
