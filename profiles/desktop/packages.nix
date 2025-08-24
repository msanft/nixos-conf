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
    clangd
    gcc
    docker
    man-pages
    man-pages-posix
    python3
    bun
    nodejs
    direnv
    difftastic

    # IDE
    vscode
    neovim

    # Cloud Stuff
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    awscli2
    azure-cli
    kubectl
    k9s
    kubernetes-helm

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
  ];
}
