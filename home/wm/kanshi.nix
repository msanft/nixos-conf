let
  dellG3223D = {
    name = "Dell Inc. DELL G3223D H916XG3";
    sizeX = "2560";
    sizeY = "1440";
    refreshRate = "120Hz";
  };
in {
  services.kanshi = {
    enable = true;
    profiles = {

        docked.outputs = [
            {
                criteria = "DP-4";
                status = "enable";
                mode = "${dellG3223D.sizeX}x${dellG3223D.sizeY}@${dellG3223D.refreshRate}";
                position = "0,0";
            }
            {
                criteria = "DP-3";
                status = "enable";
                mode = "${dellG3223D.sizeX}x${dellG3223D.sizeY}@${dellG3223D.refreshRate}";
                position = "${dellG3223D.sizeX},0";
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
