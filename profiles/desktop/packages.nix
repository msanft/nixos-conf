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
    pavucontrol
    python3
    slack
    unzip
    wireguard-tools
    yq-go
    zip
    slack
    (callPackage ida-pro {
      runfile = /nix/store/s9gq70w56355yrg33054g97zscr3r64i-ida-pro_91_x64linux.run;
    })
    zulip
    discord
    teams-for-linux
    jj
    uv
  ];
}
