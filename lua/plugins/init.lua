vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",          -- => config pronte per ogni server lsp
    "https://github.com/mason-org/mason.nvim",           -- => installa i server ; gestore pacchetti
    "https://github.com/mason-org/mason-lspconfig.nvim", -- => ponte mason <-> lsp ; auto-enable
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") }, -- => completamento
    "https://github.com/rafamadriz/friendly-snippets",   -- => snippet pronti
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    "https://github.com/windwp/nvim-autopairs",          -- => chiude da sola () [] {} "" ''
    "https://github.com/lewis6991/gitsigns.nvim",        -- => segni git nel margine + blame
    "https://github.com/nvim-lua/plenary.nvim",          -- => libreria utility (richiesta da lazygit.nvim)
    "https://github.com/kdheepak/lazygit.nvim",          -- => apre lazygit dentro nvim
    "https://github.com/folke/tokyonight.nvim",          -- => tema Tokyo Night ; abbinato al terminale
    "https://github.com/nvim-tree/nvim-web-devicons",    -- => dependency for lualine 
    "https://github.com/nvim-lualine/lualine.nvim",      -- => lualine pl: status bar 
})



-- MASON --
require("mason").setup()


-- BLINK => solo le cose NON di default --
require("blink.cmp").setup({
    keymap = {preset = "super-tab"},
    completion = {
        documentation = { auto_show = true }, -- => mostra i docs da solo
        ghost_text = { enabled = true },      -- => anteprima grigia inline
    },
    signature = { enabled = true },         -- => aiuto sui parametri delle funzioni
})

-- LSP Config -- 
vim.diagnostic.config({
   virtual_text = true, -- => error text
   severity_sort = true, -- => livello del problema
})


-- LUA => "vim" globale ; niente warning --
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- tree-sitter-manager --
require("tree-sitter-manager").setup({
    auto_install = true,
    ensure_installed = {
        "lua", "python", "javascript", "php", "php_only",
        "html", "css", "typescript", "json",
    },
})

-- gitsigns -- 
require("gitsigns").setup()



-- AUTOPAIRS => chiude in automatico parentesi e virgolette --
require("nvim-autopairs").setup({
    check_ts = true,   -- => usa treesitter ; non chiude se non ha senso nel contesto
})



-- MASON-LSPCONFIG => va per ULTIMO ; installa + abilita --
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",                 -- => lua
    "pyright",                -- => python
    "ts_ls",                  -- => javascript + typescript
    "intelephense",           -- => php
    "html",                   -- => html
    "cssls",                  -- => css + scss + less
    "emmet_language_server",  -- => emmet ; abbreviazioni html/css
    "eslint",                 -- => linting js/ts
    "jsonls",                 -- => json ; package.json ecc
  },
})


-- Theme And Various UI Config-- 
require("tokyonight").setup({
    style = "night",         -- => night / storm / moon / day ; "night" = stesso sfondo del terminale
})

vim.cmd.colorscheme("tokyonight")


-- LUALINE => status bar  -- 
require("lualine").setup({
    options = {
        theme = "tokyonight",
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_y = { "selectioncount", "progress" },
        lualine_z = { "searchcount", "location" },
    },
})



