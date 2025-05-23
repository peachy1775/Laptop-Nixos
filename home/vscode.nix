{ pkgs, ... }:
{
  programs = {
    vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          ms-python.python
          ms-python.vscode-pylance
          ms-toolsai.jupyter
          charliermarsh.ruff
          ms-python.black-formatter
          ms-vscode.cpptools
          llvm-vs-code-extensions.vscode-clangd
          esbenp.prettier-vscode
          eamodio.gitlens
          mhutchie.git-graph
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
        };
      };
    };
  };
}
