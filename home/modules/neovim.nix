{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Theme plugin
    vimPlugins.catppuccin-nvim

    # Required by Telescope and cmp
    vimPlugins.telescope-nvim
    vimPlugins.plenary-nvim
    vimPlugins.nvim-cmp
    vimPlugins.nvim-treesitter
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.termguicolors = true
      vim.opt.mouse = "a"
      vim.g.mapleader = " "

      -- Theme
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
          cmp = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")

      -- Treesitter config
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- Keybind example
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    '';
  };
}
