{config, pkgs, lib, ...}: {
    imports = [
        ./shell
        ./git.nix
        ./wm
        ./python
    ];

    programs.vscode.enable = true;
    programs.chromium.enable = true;

    home.packages = with pkgs; [
      # Sway
      xdg-utils
      xwayland
      kanshi

      # Development
      gh
      go
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
