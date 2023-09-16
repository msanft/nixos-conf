{ pkgs, ... }: {
  imports = [
    ../../modules/home/shell
    ../../modules/home/git
    ../../modules/home/python
    ../../modules/home/vscode
    ../../modules/home/rss
  ];

  home.packages = with pkgs; [
    # Development
    gh
    go
    gopls
    gotools
    terraform
    nixd
    nixpkgs-fmt
    nixpkgs-lint
    nix-output-monitor

    # Cloud
    kubectl
    awscli2
    azure-cli
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    k9s
    sonobuoy
    kubernetes-helm

    # Tools
    htop
    jq
    yq-go
    hugo
    texlive.combined.scheme-full
    exa
    bat
  ];
}
