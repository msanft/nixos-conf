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
      # Development
      gh
      go
      gopls
      gotools
      docker
      terraform

      # Cloud
      kubectl
      awscli2
      azure-cli
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])

      # Tools
      file
      htop
      jq

      # Fonts
      dejavu_fonts
      jetbrains-mono
    ];
}
