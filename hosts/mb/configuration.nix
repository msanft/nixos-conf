{ pkgs, ... }: {
  imports = [
    ../common
    ./brew.nix
    ./yabai.nix
  ];
  services.nix-daemon.enable = true;

  # explicitly set home directory until https://github.com/nix-community/home-manager/issues/4026 is resolved
  users.users.msanft = {
    name = "msanft";
    home = "/Users/msanft";
  };
  home-manager.users.msanft = { pkgs, ... }: {
    home.stateVersion = "23.05";
    imports = [
      ../../home/mb
    ];
  };
}
