{ pkgs, ... }: {
  imports = [
    ./shell
    ./git.nix
    ./python.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    # Development
    gh
    go
    gcc13
    gopls
    gotools
    terraform
    gnumake
    cmake
    nil
    nixpkgs-fmt
    nixpkgs-lint
    nix-output-monitor
    bazel-buildtools
    bazelisk
    bazel
    nodejs_20
    kubernetes-helm
    rustup

    # Cloud
    kubectl
    awscli2
    azure-cli
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    k9s
    sonobuoy

    # Tools
    htop
    jq
    yq-go
    hugo
    texlive.combined.scheme-full
    exa
    bat
    feed2imap-go
  ];
}
