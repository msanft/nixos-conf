{ config, pkgs, lib, is-darwin, ... }: {
  imports = [
    ./shell
    ./git.nix
    ./python.nix
  ];

  home.packages = with pkgs; [
    # Development
    gh
    go
    gcc
    gopls
    gotools
    docker
    terraform
    gnumake
    cmake
    nil
    nixpkgs-fmt
    nixpkgs-lint

    # Cloud
    kubectl
    awscli2
    azure-cli
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])

    # Tools
    file
    htop
    jq
  ];
}
