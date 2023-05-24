{pkgs, ...}: {
    imports = [
        ./sway.nix
    ];
    
    home.packages = with pkgs; [
      # Sway
      xdg-utils
      xwayland
      kanshi
    ];
}
