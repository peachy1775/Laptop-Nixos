{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;

    settings = {
      theme = "catppuccin-mocha";
      background-opacity = 0.8;
      background-blur = true;
    };
  };
}
