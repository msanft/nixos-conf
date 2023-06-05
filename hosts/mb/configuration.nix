{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # explicitly set home directory until https://github.com/nix-community/home-manager/issues/4026 is resolved
  users.users.moritz.home = "/Users/moritz";
  home-manager.users.moritz = {pkgs, ...}: {
    home.stateVersion = "23.05";
    imports = [
      ../../home/hosts/mb.nix
    ];
  };
}
