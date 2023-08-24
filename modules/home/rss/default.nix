{ pkgs, ... }: {
  home.packages = with pkgs; [
    feed2imap-go
  ];
}
