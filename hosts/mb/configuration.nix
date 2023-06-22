{ pkgs, system, ... }: {
  imports = [
    ../common
    ../../modules/darwin/brew
    ../../modules/darwin/yabai
    ../../modules/darwin/system
    ../../modules/darwin/fonts
  ];

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
