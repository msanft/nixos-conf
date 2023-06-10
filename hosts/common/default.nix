{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    package = pkgs.nix;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  programs.zsh.enable = true;

  environment.variables = {
    GOPRIVATE = "github.com/edgelesssys";
  };
}
