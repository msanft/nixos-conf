final: prev: {
  lib = prev.lib // {
    mkDesktopApp =
      {
        name,
        displayName,
        execScript,
        runtime,
        genericName ? "Web Application",
        comment ? "Web Application",
        ...
      }:
      rec {
        script = prev.writeShellApplication {
          name = name;
          runtimeInputs = [ runtime ];
          text = execScript;
        };
        desktopItem = prev.makeDesktopItem {
          name = name;
          exec = "${script}/bin/${name}";
          desktopName = displayName;
          genericName = genericName;
          comment = comment;
          startupWMClass = name;
          terminal = true;
        };
      };
  };
}
