{
  pkgs,
  ...
}:
let
  emacsPkg = (
    pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-unstable;
      config = ./emacs.el;
    }
  );
in
{
  services.emacs = {
    enable = true;
    package = emacsPkg;
  };
}
