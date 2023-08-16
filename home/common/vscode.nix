{ pkgs, lib, ... }: {

  stylix.targets.vscode.enable = false;
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = false;

    userSettings = {
      "editor.inlineSuggest.enabled" = true;
      "git.autofetch" = true;
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";
      "git.confirmSync" = false;
      "omnisharp.monoPath" = "/Library/Frameworks/Mono.framework/Versions/Current";
      "omnisharp.useModernNet" = false;
      "files.autoSave" = "afterDelay";
      "go.toolsManagement.autoUpdate" = true;
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = false;
        "scminput" = false;
      };
      "git.enableSmartCommit" = true;
      "protoc" = { };
      "editor.formatOnSave" = true;
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;
      "git.ignoreRebaseWarning" = true;
      "go.languageServerFlags" = [ ];
      "go.formatTool" = "gofumpt";
      "explorer.confirmDelete" = false;
      "[javascript]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "vs-kubernetes" = {
        "vs-kubernetes.ignore-recommendations" = true;
      };
      "[python]" = {
        "editor.formatOnType" = true;
      };
      "explorer.confirmDragAndDrop" = false;
      "diffEditor.ignoreTrimWhitespace" = false;
      "security.workspace.trust.untrustedFiles" = "open";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [              "nixpkgs-fmt"
            ];
          };
        };
      };
      "editor.fontFamily" = "JetBrains Mono";
      "[nix]" = {
        "editor.formatOnSave" = true;
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
      };
      "window.zoomLevel" = -1;
      "workbench.colorTheme" = "GitHub Light Default";
    };

    extensions = with pkgs.vscode-extensions;
      [
        github.vscode-github-actions
        github.vscode-pull-request-github
        golang.go
        hashicorp.terraform
        jnoortheen.nix-ide
        github.github-vscode-theme
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "copilot";
          publisher = "GitHub";
          version = "1.96.257";
          sha256 = "1hgj3847g3z3rh6s1kfqk0pjs7qv7li3njl6wfgzv65f6hkn27rp";
        }
        {
          name = "vscode-bazel";
          publisher = "bazelbuild";
          version = "0.7.0";
          sha256 = "05wvih09184bsp4rv2m55z0sasra2qrvch5m3bkbrjq7rcqgibgx";
        }
      ];
  };
}
