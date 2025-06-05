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
      which-key-nvim
      bufferline-nvim
      nvim-web-devicons
    ];

    extraLuaConfig = ''
      -- ##################################
      -- ####   CORE EDITOR OPTIONS    ####
      -- ##################################

      vim.opt.clipboard = "unnamedplus"
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.termguicolors = true
      vim.opt.mouse = "a"
      vim.opt.timeoutlen = 250
      vim.g.mapleader = " "

      -- ##################################
      -- ####        WHICH-KEY         ####
      -- ##################################
      
      require("which-key").setup()

      -- ##################################
      -- ####        THEME SETUP       ####
      -- ##################################

      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
          cmp = true,
        },
      })
      vim.o.background = ("dark")
      vim.cmd.colorscheme("catppuccin")

      -- ##################################
      -- ####        LUALINE SETUP     ####
      -- ##################################

      require("lualine").setup({
        options = { theme = "catppuccin" }
      })

      -- ##################################
      -- ####     BUFFERLINE SETUP     ####
      -- ##################################

      require("bufferline").setup({})
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

      -- ##################################
      -- ####    TREESITTER CONFIG     ####
      -- ##################################

      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- ##################################
      -- ####     NVIM-TREE SETUP      ####
      -- ##################################

      require("nvim-tree").setup({
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local dir = vim.fn.isdirectory(data.file) == 1
          if dir then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          end
        end
      })

      -- ##################################
      -- ####     TELESCOPE CONFIG     ####
      -- ##################################

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = true })
      end, {})

      -- ##################################
      -- ####     TOGGLETERM CONFIG     ####
      -- ##################################

      require("toggleterm").setup()
      vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })

      -- ##################################
      -- ####    MASON & LSP CONFIG    ####
      -- ##################################

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = false,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.pyright.setup({ capabilities = capabilities })

      -- ##################################
      -- ####       NVIM-CMP SETUP     ####
      -- ##################################

      local ok, cmp = pcall(require, "cmp")
      if not ok then return end

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "spell" },
        }),
      })

      -- ##################################
      -- ####      AUTOPAIRS CONFIG    ####
      -- ##################################

      require("nvim-autopairs").setup({ check_ts = true })
      vim.keymap.set("i", "<C-l>", function()
        local col = vim.fn.col(".")
        local char = vim.fn.getline("."):sub(col, col)
        if vim.tbl_contains({ ")", "]", "}", '"', "'", "`", ";" }, char) then
          return "<Right>"
        else
          return "<C-l>"
        end
      end, { expr = true, noremap = true })

      -- ##################################
      -- ####    FAST ESC & BINDINGS   ####
      -- ##################################

      vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
      vim.keymap.set("i", "<A-o>", "<C-o>", { noremap = true })
      vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<CR>", { noremap = true, silent = true, desc = "Show keymaps" })


      -- ##################################
      -- ####    NVIM-SURROUND SETUP   ####  
      -- ##################################

      require("nvim-surround").setup()

      -- ##################################
      -- #### ILLUMINATE HIGHLIGHTING  ####
      -- ##################################

      require("illuminate").configure({})

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local word = vim.fn.expand("<cword>")
          if not vim.fn.spellbadword(word)[1]:match("%S") then return end

          local suggestions = vim.fn.spellsuggest(word, 5)
          if #suggestions == 0 then return end

          local message = "Spelling suggestions:\n- " .. table.concat(suggestions, "\n- ")
          vim.lsp.util.open_floating_preview({ message }, "plaintext", { border = "rounded" })
        end
      })

      -- ##################################
      -- ####    FORMAT ON SAVE BLOCK  ####
      -- ##################################

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    '';
  };
}
