{ pkgs, config, ... }: {
  cat = "${pkgs.bat}/bin/bat";
  ls = "${pkgs.eza}/bin/eza";
  ll = "ls -la";
}
