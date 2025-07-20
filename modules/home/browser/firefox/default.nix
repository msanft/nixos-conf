{ config, ... }:
{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
      };
      work = {
        id = 1;
      };
    };
  };
}
