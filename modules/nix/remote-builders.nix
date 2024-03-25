{ ... }:
{
  es-nix-remote-builder = {
    enable = true;
    useBuildersAsSubstituters = true;
    username = "msanft";
    identityFile = "/home/moritzs/.ssh/nix_rb_x86";
  };
}
