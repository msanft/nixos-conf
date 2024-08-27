{ pkgs, ... }:
{
  imports = [
    ../../modules/home/shell
    ../../modules/home/git.nix
    ../../modules/home/vscode.nix
  ];

  home.packages = with pkgs; [
    # Go
    go
    gopls
    gotools

    # Nix
    nixd
    nixpkgs-fmt
    nixpkgs-lint
    nix-output-monitor

    # Python
    python3

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
