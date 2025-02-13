{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    awscli2
    azure-cli
    bat
    bluetuith
    brightnessctl
    btop
    docker
    eza
    file
    gh
    gnupg
    jq
    k9s
    kubectl
    kubernetes-helm
    man-pages
    man-pages-posix
    nix-output-monitor
    nixd
    nixpkgs-fmt
    obsidian
    pass
    pavucontrol
    python3
    slack
    unzip
    wireguard-tools
    yazi
    yq-go
    zathura
    zip
    slack
    (callPackage ida-pro {
      runfile = /nix/store/vpyzqrrlild2y2622bcj7prlm2pcsn74-ida-pro_90sp1_x64linux.run;
    })
    zulip
  ];
}
