{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    image = ../config/.wallpapers/anom.jpg;
  cursor = {
    package = pkgs.catppuccin-cursors.mochaBlue;
    name = "catppuccin-mocha-blue-cursors";
    size = 24;
  };
    targets = {
      starship.enable = false;
      hyprland.enable = false;
      vscode.enable = false;
      helix.enable = false;
    # spicetify.enable = false;
    # qt.enable = false;
    # vencord.enable = false;
    # vesktop.enable = false;
    # nixcord.enable = true;
    
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      
    };
  };
}