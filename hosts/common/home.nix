{ pkgs, ... }: {
  imports = [
    ../../modules/home/shell
    ../../modules/home/git
    ../../modules/home/python
    ../../modules/home/vscode
    ../../modules/home/rss
  ];

  home.packages = with pkgs; [
    # Go
    go_1_21
    gopls
    gotools

    # Nix
    nixd
    nixpkgs-fmt
    nixpkgs-lint
    nix-output-monitor

    # Rust
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy

    # Cloud
    kubectl
    awscli2 # broken
    azure-cli
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    k9s
    sonobuoy
    kubernetes-helm
    terraform

    # Tools
    gh
    btop
    jq
    yq-go
    hugo
    eza
    bat
    tailscale
  ];
}
