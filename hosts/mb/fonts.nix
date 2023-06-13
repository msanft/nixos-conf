{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;

    fonts = with pkgs; [
      jetbrains-mono
    ];
  };
}
