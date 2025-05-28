{ ... }:
{

  home.file = {
    
    ".config/nvim/lua.init" = {
      source = ...config/nvim/lua.init
    }
    ".config/starship.toml" = {
      source = ../config/starship.toml;
    };
    ".config/fastfetch/nixos.png" = {
      source = ../config/fastfetch/nixos.png;
    };
    ".config/waybar/config.jsonc" = {
      source = ../config/waybar/config.json;
    };
    ".config/waybar/style.css" = {
      source = ../config/waybar/style.css;
    };
      ".config/helix/config.toml" = {
      source =  ../config/helix/config.toml;
    };
      ".config/helix/keymap.toml" = {
      source = ../config/helix/keymap.toml;
    };
      ".config/yazi/yazi.toml" = {
        source = ../config/yazi/yazi.toml;
      };
  };
}
