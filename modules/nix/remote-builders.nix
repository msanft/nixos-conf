{ ... }:
{
  es-nix-remote-builder = {
    enable = true;
    useBuildersAsSubstituters = false;
    username = "msanft";
    identityFile = "/home/msanft/.ssh/nix_rb_x86";
  };
}
