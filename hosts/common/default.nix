{ ... }: {
  imports = [
    ../../modules/nix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  environment.variables = {
    GOPRIVATE = "github.com/edgelesssys";
  };
}
