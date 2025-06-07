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
        ];

        userSettings = {
          "workbench.colorTheme" = "Catppuccin Mocha";
          "telemetry.enableTelemetry" = false;
          "telemetry.enableCrashReporter" = false;
          "telemetry.telemetryLevel" = "off";
          "explorer.compactFolders" = false;
          "editor.wordWrap" = "on";
          "editor.formatOnSave" = true;

          # Auto Save and Minimap
          "files.autoSave" = "onWindowChange";
          "editor.minimap.enabled" = false;

          # Nix formatting with nil
          "[nix]" = {
            "editor.defaultFormatter" = "unknown.formatter.nil";
          };
          "nix.formatterPath" = "nil";

          "[python]" = {
            "editor.defaultFormatter" = "ms-python.black-formatter";
          };
          "[cpp]" = {
            "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
          };
          "[c]" = {
            "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
          };
          nix.enableLanguageServer = true;
          nix.serverPath = "${pkgs.nixd}/bin/nixd";
        };
      };
    };
  };
}
