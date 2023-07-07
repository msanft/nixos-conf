{config, pkgs, ...}: {
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.packages = with pkgs; [
    ghidra
  ];
}
