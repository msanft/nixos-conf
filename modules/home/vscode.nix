{ pkgs, lib, ... }:
{
  home.sessionVariables.NIXOS_OZONE_WL = "1"; # run natively under wayland

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
      "[python]" = {
        "editor.formatOnType" = true;
      };
      "explorer.confirmDragAndDrop" = false;
      "diffEditor.ignoreTrimWhitespace" = false;
      "security.workspace.trust.untrustedFiles" = "open";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
          };
        };
      };
      "editor.fontFamily" = "BerkeleyMono Nerd Font Mono";
      "editor.fontSize" = 15;
      "editor.lineHeight" = 0;
      "debug.console.fontSize" = 15;
      "debug.console.lineHeight" = 1;
      "editor.lineNumbers" = "relative";
      "terminal.integrated.fontSize" = 15;
      "terminal.integrated.lineHeight" = 1;
      "[nix]" = {
        "editor.formatOnSave" = true;
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
      };
      "window.zoomLevel" = -1;
      "workbench.colorTheme" = "GitHub Light Default";
      "remote.SSH.configFile" = "/home/moritzs/.ssh/config";
      # "remote.SSH.useLocalServer" = true;
      "remote.SSH.showLoginTerminal" = true;
      "git.enableCommitSigning" = true;
      "bazel.enableCodeLens" = true;
      "window.titleBarStyle" = "custom";
      "window.customTitleBarVisibility" = "auto";
    };

    mutableExtensionsDir = false;

    extensions =
      with pkgs.vscode-extensions;
      [
        github.vscode-github-actions
        golang.go
        hashicorp.terraform
        jnoortheen.nix-ide
        github.github-vscode-theme
        ms-vscode-remote.remote-ssh
        zxh404.vscode-proto3
        llvm-vs-code-extensions.vscode-clangd
        waderyan.gitblame
        github.vscode-pull-request-github
        ms-python.python
        ms-vsliveshare.vsliveshare
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vscodevim.vim
        mkhl.direnv
        skellock.just
        ms-toolsai.jupyter
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

  home.packages = with pkgs; [
    delve
    go-tools
    openssl
  ];
}
