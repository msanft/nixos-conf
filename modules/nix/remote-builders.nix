{ ... }:
{
  es-nix-remote-builder = {
    enable = true;
    useBuildersAsSubstituters = true;
    username = "msanft";
    identityFile = "/home/msanft/.ssh/nix_rb_x86";
  };
}
