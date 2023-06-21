{ pkgs, ... }: {
  imports = [
    ../../modules/nix
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
