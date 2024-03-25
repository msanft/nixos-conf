{ pkgs, lib, ... }: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
    package = pkgs.nixVersions.nix_2_21;
    gc = {
      automatic = true;
      dates = lib.mkIf (pkgs.stdenv.isLinux) "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
