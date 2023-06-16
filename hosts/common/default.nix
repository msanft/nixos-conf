{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    package = pkgs.nix;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

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
