{ pkgs, ... }:
{
  programs = {
    vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          ms-python.python
          ms-toolsai.jupyter
          esbenp.prettier-vscode
          eamodio.gitlens
          ms-vscode.cpptools
          llvm-vs-code-extensions.vscode-clangd
          ms-vscode.cmake-tools
          charliermarsh.ruff
          ms-python.black-formatter
          vscode-icons-team.vscode-icons
          jnoortheen.nix-ide
          catppuccin.catppuccin-vsc
          formulahendry.code-runner
        ];

        userSettings = {
          # Theme and UI
          "workbench.colorTheme" = "Catppuccin Mocha";
          "explorer.compactFolders" = false;
          "editor.wordWrap" = "on";
          "editor.formatOnSave" = true;
          "files.autoSave" = "onWindowChange";
          "editor.minimap.enabled" = false;

          # Privacy
          "telemetry.enableTelemetry" = false;
          "telemetry.enableCrashReporter" = false;
          "telemetry.telemetryLevel" = "off";

          # Language-specific formatters
          "[nix]" = {
            "editor.defaultFormatter" = "unknown.formatter.nil";
          };
          "nix.formatterPath" = "nil";
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

          "[python]" = {
            "editor.defaultFormatter" = "ms-python.black-formatter";
          };
          "[cpp]" = {
            "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
          };
          "[c]" = {
            "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
          };

          # Python config
          "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python3";
          "python.terminal.activateEnvironment" = true;
          "python.analysis.typeCheckingMode" = "basic";

          # Code Runner settings
          "code-runner.executorMap.python" = "${pkgs.python3}/bin/python3";
          "code-runner.runInTerminal" = true;
        };
      };
    };
  };
}

