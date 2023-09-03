{ ... }: {
  programs.chromium = {
    enable = true;

    commandLineArgs = [
      # "--enable-features=UseOzonePlatform"
      # "--ozone-platform=wayland"
      # "--ozone-platform-hint=auto"
      "--enable-features=WebRTCPipeWireCapturer"
    ];

    extensions = [
      { id = "cfhdojbkjhnklbpkdaibdccddilifddb"; } # adblock
      { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; } # JSON viewer
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
    ];
  };
}
