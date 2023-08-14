{ pkgs, ... }: {
  imports = [
    ../../modules/nix
    ../../modules/system/stylix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  programs.zsh.enable = true;

  environment.variables = {
    GOPRIVATE = "github.com/edgelesssys";
  };
}
