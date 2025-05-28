{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      telescope-nvim
      plenary-nvim
      nvim-cmp
      cmp-nvim-lsp
      nvim-treesitter
      nvim-tree-lua
      lualine-nvim
      toggleterm-nvim
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      nvim-autopairs
      harpoon
      nvim-surround
      vim-illuminate
    ];

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

      -- Lualine statusline
      require("lualine").setup({
        options = { theme = "catppuccin" }
      })

      -- Treesitter
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Nvim-tree setup
      require("nvim-tree").setup({
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

      -- Auto open tree if started in a directory
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local dir = vim.fn.isdirectory(data.file) == 1
          if dir then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          end
        end
      })

      -- Telescope
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

      -- Terminal
      require("toggleterm").setup()
      vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })

      -- Mason LSP
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
      })

      -- LSP setup
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.pyright.setup({ capabilities = capabilities })

      -- Completion
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })

      -- Autopairs
      require("nvim-autopairs").setup()

      -- Surround
      require("nvim-surround").setup()

      -- Illuminate
      require("illuminate").configure({})

      -- Format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    '';
  };
}
