{ ... }: {
  networking = {
    hostName = "tp";
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1    license.confidential.cloud
    '';

    #firewall = {
    #  allowedUDPPorts = [ 21842 ]; # Clients and peers can use the same port, see listenport
    #};

    # wireguard.interfaces = {
    #   fluxvpn = {
    #     # Determines the IP address and subnet of the client's end of the tunnel interface.
    #     ips = [ "10.1.8.18/32" ];
    #     listenPort = 21842; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

    #     privateKeyFile = "/home/moritzs/wireguard-keys/private"; # TODO: use Agenix

    #     peers = [
    #       {
    #         publicKey = "lWpULQEkTfwTwZ2zTIZhph9s8A4XKXO5SdU+FQP9kzg=";
    #         allowedIPs = [ "10.1.8.0/24" "10.13.37.0/29" ];
    #         endpoint = "vpn.fluxfingers.net:51820";
    #         # Send keepalives every 25 seconds. Important to keep NAT tables alive.
    #         persistentKeepalive = 25;
    #       }
    #     ];
    #   };
    # };
  };

}
