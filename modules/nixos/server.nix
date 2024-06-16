{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/services/tailscale
  ];

  systemd = {
    watchdog = {
      runtimeTime = "20s";
      rebootTime = "30s";
    };
    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
    '';

    network = {
      enable = true;
    };

    services = {
      NetworkManager-wait-online.enable = false;
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };

  services.openssh.enable = true;

  my.services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  users.users =
    let
      sshKeys =
        [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHG4Gb4iiSrqLqrARn/2gmJvyBQ9I+qUN+TwdJDIJUZMrBA7cLNbX/qsyEgG9hMd7GqXVQW7USMu4Dl7S1h+3RUWVOM0QwAA35qjTUpulf4nSJvgIdCjp3DZ8yntHpfL7CeOpcQCi/d4TVHwXSvoPU1rMs566PLXMkJIlBc/Q86v6b+mBlsLRcecBoBWBXeIcABN3oUvBQ+O6A5HEBd+Ec2A2BLykRkBAeBpUSFEBF/5fDgnUsNgpa6lMMtSOCBjjko/PmGT7KuhMIdpdMtTSc3wc4QFKAFecddO5MgkPY0gAUVzVtEe1xlYen37+2sKzbfsQ2ZvW/tKxCVGc71SPTdtz+bhC6hIBLrT63RPUyXUmt1QiwveJHv8/tHYZmHDabAuVPqPnRw2mN37fx+oeWc4wE+B5GBQxdVDPM8M5IBbI6FB4IHA1SzGsBTOIaO1B+XSblxvk/8z1/BGM7ya0E2ilkGpD9C+4AH0yejT9ztFWqNf/JEvIedIXPqkptvvYKJTuhw+hsbsN2hAkF4yiEXko2cIV97btJJl3E9/M0dFSuh3Q3igejSIoDBZTl5Z73zJ4znKx/6FGUHk+Cq8JMU6X82Y3ULQaVPpaiCtXx+OJLlUeQ9K1WIn5wI3cdXj3A3gPXjks+lVxh4gUnzzv4jVDxP736TYJAXliR/d6Aaw=="
        ];

    in
    {
      root.openssh.authorizedKeys.keys = sshKeys;
      msanft = {
        isNormalUser = true;
        description = "Moritz Sanft";
        extraGroups = [ "wheel" ];
        shell = pkgs.bash;
        openssh.authorizedKeys.keys = sshKeys;
      };
    };

  zramSwap.enable = true;

  networking = {
    useDHCP = false;
    useNetworkd = true;
    wireless.enable = false;
  };

  services.earlyoom.enable = true;

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      timeout = 3;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd = {
      enable = true;
    };


    kernelPackages = pkgs.linuxPackages_latest;

    # See https://github.com/nix-community/srvos/blob/72956bfcd1a1e08f7202592751afc80eceaaf217/nixos/server/default.nix#L89
    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    tmp.cleanOnBoot = true;
  };

  time.timeZone = lib.mkDefault "UTC";

  fonts.fontconfig.enable = lib.mkDefault false;
  sound.enable = false;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
