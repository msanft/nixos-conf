{ ... }: {
  networking = {
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1    license.confidential.cloud
    '';
  };

}
