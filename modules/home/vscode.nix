{ pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
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
      "editor.fontLigatures" = true;
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
      "remote.SSH.configFile" = "/home/msanft/.ssh/config";
      # "remote.SSH.useLocalServer" = true;
      "remote.SSH.showLoginTerminal" = true;
      "git.enableCommitSigning" = true;
      "bazel.enableCodeLens" = true;
      "window.titleBarStyle" = "custom";
      "window.customTitleBarVisibility" = "auto";
      "direnv.restart.automatic" = true;
    };

    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions; [
      bazelbuild.vscode-bazel
      github.copilot
      github.copilot-chat
      github.github-vscode-theme
      github.vscode-github-actions
      github.vscode-pull-request-github
      golang.go
      hashicorp.terraform
      jnoortheen.nix-ide
      llvm-vs-code-extensions.vscode-clangd
      mkhl.direnv
      ms-python.python
      ms-toolsai.jupyter
      ms-vscode-remote.remote-ssh
      rust-lang.rust-analyzer
      skellock.just
      tamasfe.even-better-toml
      usernamehw.errorlens
      waderyan.gitblame
      zxh404.vscode-proto3
    ];
  };
}
