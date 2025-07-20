{ ... }:
{
  programs.chromium = {
    enable = true;

    extensions = [
      { id = "cfhdojbkjhnklbpkdaibdccddilifddb"; } # adblock
      { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; } # JSON viewer
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
    ];
  };
}
