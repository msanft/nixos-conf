{
  ...
}:
{

  wayland.windowManager.sway = {
    extraOptions = ["--unsupported-gpu"];

    extraSessionCommands = ''
          export SDL_VIDEODRIVER=wayland
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export _JAVA_AWT_WM_NONREPARENTING=1
          export MOZ_ENABLE_WAYLAND=1
          export XDG_CURRENT_DESKTOP=sway
          export XDG_SESSION_DESKTOP=sway
          export XWAYLAND_NO_GLAMOR=1
          export WLR_RENDERER=vulkan
        '';
  };
  }
