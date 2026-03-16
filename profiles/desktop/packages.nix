{ pkgs
, ...
}:
let
  ida-patched = (pkgs.callPackage ../../packages/ida-patched {
    ida-package = pkgs.ida-pro;
    patch = (pkgs.fetchurl {
      url = "https://gist.github.com/ReaJason/466ab4f35171b2dcca1c075ce5ee1195/raw/599773699a663b6e5eac6e06552b7597244bd4dc/patch.py";
      hash = "sha256-p4HqJctK550XEkOH4WraQZE16e+3AYlG0LFFyCI503s=";
    });
  });
in
{
  environment.systemPackages = with pkgs; [
    # Dev Tooling
    git
    jj
    uv
    gh
    nixd
    nixpkgs-fmt
    nix-output-monitor
    go
    clang
    clang-tools
    gcc
    docker
    man-pages
    man-pages-posix
    python3
    bun
    nodejs
    direnv
    difftastic
    wget
    bun

    # IDE
    vscode
    helix

    # Cloud Stuff
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    kubectl
    k9s
    kubernetes-helm
    k6 # to satisfy the IDE extension

    # Shell
    bash
    nushell
    starship
    atuin
    carapace

    # Toolies
    bat
    btop
    eza
    file
    gnupg
    jq
    unzip
    wireguard-tools
    yq-go
    zip
    p7zip
    wget
    xxd
    patchelf
    wormhole-rs
    dig
    net-tools
    ripgrep
    claude-code
    fd

    # Desktop Applications
    vscode
    ghostty
    obsidian
    slack
    discord
    teams-for-linux
    firefox
    google-chrome
    _1password-gui
    thunderbird
    signal-desktop

    # Gnome extensions
    gnomeExtensions.appindicator

    ida-patched
  ];

  systemd.tmpfiles.rules = [
    "L+ /var/lib/idapro.hexlic - - - - ${ida-patched}/share/idapro.hexlic"
  ];
}
