{ pkgs, username, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/stylixTargets.nix
    ./modules/fastfetch.nix
    ./modules/vscode.nix
    ./modules/neovim.nix
    ./modules/pkgs.nix
    ./modules/ghostty.nix
    ./modules/programs.nix
    ./modules/files.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/peaches";
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "vscode";
      GIT_EDITOR = "vscode";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GTK_USE_PORTAL = "1";

    };
    packages = with pkgs; [ ];
  };

}
