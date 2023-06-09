{ pkgs, lib, ... }: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    package = pkgs.nix;
    gc = {
      automatic = true;
      dates = lib.mkIf (pkgs.stdenv.isLinux) "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # services.nix-daemon.enable = if (pkgs.stdenv.isDarwin) then true else false;
}
