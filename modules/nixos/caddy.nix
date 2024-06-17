{ ... }:
{
  config =
    {
      services.caddy = {
        enable = true;
        email = "certs@msanft.foo";
      };

      networking.firewall.allowedTCPPorts = [ 80 443 ];
    };
}
