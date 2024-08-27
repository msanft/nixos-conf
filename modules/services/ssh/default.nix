{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.my.services.ssh;

  keys = {
    msanft = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHG4Gb4iiSrqLqrARn/2gmJvyBQ9I+qUN+TwdJDIJUZMrBA7cLNbX/qsyEgG9hMd7GqXVQW7USMu4Dl7S1h+3RUWVOM0QwAA35qjTUpulf4nSJvgIdCjp3DZ8yntHpfL7CeOpcQCi/d4TVHwXSvoPU1rMs566PLXMkJIlBc/Q86v6b+mBlsLRcecBoBWBXeIcABN3oUvBQ+O6A5HEBd+Ec2A2BLykRkBAeBpUSFEBF/5fDgnUsNgpa6lMMtSOCBjjko/PmGT7KuhMIdpdMtTSc3wc4QFKAFecddO5MgkPY0gAUVzVtEe1xlYen37+2sKzbfsQ2ZvW/tKxCVGc71SPTdtz+bhC6hIBLrT63RPUyXUmt1QiwveJHv8/tHYZmHDabAuVPqPnRw2mN37fx+oeWc4wE+B5GBQxdVDPM8M5IBbI6FB4IHA1SzGsBTOIaO1B+XSblxvk/8z1/BGM7ya0E2ilkGpD9C+4AH0yejT9ztFWqNf/JEvIedIXPqkptvvYKJTuhw+hsbsN2hAkF4yiEXko2cIV97btJJl3E9/M0dFSuh3Q3igejSIoDBZTl5Z73zJ4znKx/6FGUHk+Cq8JMU6X82Y3ULQaVPpaiCtXx+OJLlUeQ9K1WIn5wI3cdXj3A3gPXjks+lVxh4gUnzzv4jVDxP736TYJAXliR/d6Aaw==";
  };
in
{
  options.my.services.ssh = with lib; {
    enable = mkEnableOption "Build the SSH configuration.";
    server = mkEnableOption "Run an SSH server. (i.e. enable the SSH daemon)";
    allowedUsers = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Users who are allowed to log in via SSH.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = cfg.server;
    };

    environment.systemPackages = [ pkgs.openssh ];

    users.users = lib.mkIf cfg.server (
      lib.genAttrs cfg.allowedUsers (user: {
        openssh.authorizedKeys.keys = lib.attrValues keys;
      })
    );
  };
}
