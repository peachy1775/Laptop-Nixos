-- Install packer if not present
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth", "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Plugin setup
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin-mocha")
    end
  }

  use { "junegunn/fzf", run = "./install --all" }
  use "junegunn/fzf.vim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Editor settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.mouse = "a"

-- FZF keymaps
vim.keymap.set("n", "<leader>ff", ":Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", ":GFiles<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>", { noremap = true, silent = true })
