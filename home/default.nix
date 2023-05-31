{config, pkgs, lib, ...}: {
    imports = [
        ./shell
        ./git.nix
        ./wm
        ./python
        ./desktop
    ];

    programs.vscode.enable = true;

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

      # Cloud
      kubectl
      awscli2
      azure-cli
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

      # Tools
      file
      htop
      jq
    ];
}
