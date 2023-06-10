{ pkgs, system, ... }: {
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

  system.defaults.NSGlobalDomain = {
    "com.apple.swipescrolldirection" = false;
    AppleInterfaceStyleSwitchesAutomatically = true;
    NSAutomaticCapitalizationEnabled = false;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    NSScrollAnimationEnabled = true;
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;
  };

  system.defaults.LaunchServices.LSQuarantine = false;

  system.defaults.dock = {
    autohide = true;
    minimize-to-application = true;
    orientation = "left";
    show-recents = false;
  };

  system.defaults.finder = {
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;
    FXDefaultSearchScope = "SCcf"; # search current folder by default
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "clmv"; # column view
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  system.defaults.screencapture.location = "~/Pictures/Screenshots";
}
