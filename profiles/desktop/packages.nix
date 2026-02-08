{ pkgs
, ...
}:
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
    codeql
    claude-code

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

    ida-pro
  ];
}
