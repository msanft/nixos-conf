{ config, pkgs, lib, is-darwin, ... }: {
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
    gcc
    gopls
    gotools
    terraform
    gnumake
    cmake
    rnix-lsp
    nixpkgs-fmt
    nixpkgs-lint
    bazel-buildtools
    bazelisk
    bazel
    k9s
    sonobuoy

    # Cloud
    kubectl
    awscli2
    azure-cli
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])

    # Tools
    htop
    jq
  ];
}
