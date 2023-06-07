{ pkgs, ... }: {
  imports = [
    ../common
    ./brew.nix
    ./yabai.nix
  ];
  services.nix-daemon.enable = true;

  # explicitly set home directory until https://github.com/nix-community/home-manager/issues/4026 is resolved
  users.users.moritz = {
    name = "moritz";
    home = "/Users/moritz";
  };
  home-manager.users.moritz = { pkgs, ... }: {
    home.stateVersion = "23.05";
    imports = [
      ../../home/mb
    ];
  };
}
