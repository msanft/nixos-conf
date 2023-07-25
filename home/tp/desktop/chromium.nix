{ pkgs, ... }: {
  programs.chromium = {
    enable = true;

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-features=WebRTCPipeWireCapturer"
    ];

    extensions = [
      { id = "cfhdojbkjhnklbpkdaibdccddilifddb"; } # adblock
      { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; } # JSON viewer
    ];
  };
}
