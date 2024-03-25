{ config, lib, pkgs, inputs, modulesPath, ... }: {
  imports = [
    ../../modules/services/tailscale
    ../../modules/nix
  ];

  networking.hostName = "zeitgeist";

  users.users.msanft = {
    isNormalUser = true;
    description = "Moritz Sanft";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHG4Gb4iiSrqLqrARn/2gmJvyBQ9I+qUN+TwdJDIJUZMrBA7cLNbX/qsyEgG9hMd7GqXVQW7USMu4Dl7S1h+3RUWVOM0QwAA35qjTUpulf4nSJvgIdCjp3DZ8yntHpfL7CeOpcQCi/d4TVHwXSvoPU1rMs566PLXMkJIlBc/Q86v6b+mBlsLRcecBoBWBXeIcABN3oUvBQ+O6A5HEBd+Ec2A2BLykRkBAeBpUSFEBF/5fDgnUsNgpa6lMMtSOCBjjko/PmGT7KuhMIdpdMtTSc3wc4QFKAFecddO5MgkPY0gAUVzVtEe1xlYen37+2sKzbfsQ2ZvW/tKxCVGc71SPTdtz+bhC6hIBLrT63RPUyXUmt1QiwveJHv8/tHYZmHDabAuVPqPnRw2mN37fx+oeWc4wE+B5GBQxdVDPM8M5IBbI6FB4IHA1SzGsBTOIaO1B+XSblxvk/8z1/BGM7ya0E2ilkGpD9C+4AH0yejT9ztFWqNf/JEvIedIXPqkptvvYKJTuhw+hsbsN2hAkF4yiEXko2cIV97btJJl3E9/M0dFSuh3Q3igejSIoDBZTl5Z73zJ4znKx/6FGUHk+Cq8JMU6X82Y3ULQaVPpaiCtXx+OJLlUeQ9K1WIn5wI3cdXj3A3gPXjks+lVxh4gUnzzv4jVDxP736TYJAXliR/d6Aaw=="
    ];
    initialPassword = "temp";
  };

  my.services.tailscale.enable = true;
  services.sshd.enable = true;
  services.earlyoom.enable = true;

  systemd = {
    # For more detail, see: https://0pointer.de/blog/projects/watchdog.html
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
      networks."10-lan" = {
        matchConfig.Name = "en*";
        networkConfig.DHCP = "yes";
        linkConfig.RequiredForOnline = "routable";
      };
    };

    services = {
      NetworkManager-wait-online.enable = false;
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };

  zramSwap.enable = true;

  networking = {
    useDHCP = false;
    useNetworkd = true;
    wireless.enable = false;
  };

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

    supportedFilesystems = [ "btrfs" ];

    kernelPackages = pkgs.linuxPackages_latest;

    # See https://github.com/nix-community/srvos/blob/72956bfcd1a1e08f7202592751afc80eceaaf217/nixos/server/default.nix#L89
    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    tmp.cleanOnBoot = true;
  };

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        echo "--- diff to current-system"
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
        echo "---"
      fi
    '';
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"

      # My Personal components
      "shelly"
      "hue"
    ];
    openFirewall = true;
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };
    };
  };

  time.timeZone = lib.mkDefault "UTC";

  fonts.fontconfig.enable = lib.mkDefault false;
  sound.enable = false;

  system.stateVersion = "22.11";
}
