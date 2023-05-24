let
  dellG3223D = {
    name = "Dell Inc. DELL G3223D";
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
