final: prev: {
  lib = prev.lib // {
    mkChromiumDesktopApp = { name, displayName, execScript, genericName ? "Web Application", comment ? "Web Application", ... }:
      rec {
        script = prev.writeShellApplication {
          name = name;
          runtimeInputs = [ prev.chromium ];
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
