let
  dellG3223D = {
    name = "Dell Inc. DELL G3223D";
    sizeX = "2560";
    sizeY = "1440";
    refreshRate = "120Hz";
  };
  dellP2720D = {
    name = "Dell Inc. DELL P2720D";
    sizeX = "2560";
    sizeY = "1440";
    refreshRate = "59.951Hz";
  };
in
{
  services.kanshi = {
    enable = true;
    profiles = {
      docked.outputs = [
        {
          criteria = "${dellG3223D.name} H916XG3";
          status = "enable";
          mode = "${dellG3223D.sizeX}x${dellG3223D.sizeY}@${dellG3223D.refreshRate}";
          position = "0,0";
        }
        {
          criteria = "${dellG3223D.name} HBN6XG3";
          status = "enable";
          mode = "${dellG3223D.sizeX}x${dellG3223D.sizeY}@${dellG3223D.refreshRate}";
          position = "${dellG3223D.sizeX},0";
        }
        {
          criteria = "eDP-1";
          status = "disable";
          position = "0,0";
        }
      ];

      office.outputs = [
        {
          criteria = "${dellP2720D.name} JJMJK53";
          status = "enable";
          mode = "${dellP2720D.sizeX}x${dellP2720D.sizeY}@${dellP2720D.refreshRate}";
          position = "0,0";
        }
        {
          criteria = "${dellP2720D.name} 2SMJK53";
          status = "enable";
          mode = "${dellP2720D.sizeX}x${dellP2720D.sizeY}@${dellP2720D.refreshRate}";
          position = "${dellP2720D.sizeX},0";
        }
        {
          criteria = "eDP-1";
          status = "enable";
          position = "5120,0"; # dellP2720D.sizeX * 2
        }
      ];

      undocked.outputs = [
        {
          criteria = "eDP-1";
          status = "enable";
          position = "0,0";
        }
      ];
    };
  };
}
