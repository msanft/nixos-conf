{ ... }: {
  networking = {
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1    license.confidential.cloud
      127.0.0.1    mastodon.local
    '';

    firewall = {
      allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
    };

    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.1.8.20/32" ];
        listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
        privateKeyFile = "/etc/wireguard/privatekey";
        peers = [
          {
            publicKey = "lWpULQEkTfwTwZ2zTIZhph9s8A4XKXO5SdU+FQP9kzg=";
            allowedIPs = [ "10.1.8.0/24" "10.13.37.0/29" ];
            endpoint = "vpn.fluxfingers.net:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
