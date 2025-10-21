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

    # IDE
    vscode
    helix

    # Cloud Stuff
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    # awscli2
    # azure-cli # TODO(msanft): re-enable once https://github.com/NixOS/nixpkgs/issues/437525 is resolved
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

    (callPackage ida-pro {
      runfile = /nix/store/lrdbfymfpv633532pf6zx4hjngiy7gih-ida-pro_92_x64linux.run;
    })
  ];
}
