{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 240;
        command = "swaylock -f";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * power off'";
        resumeCommand = "swaymsg 'output * power on'";
      }
    ];
  };
}
