vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',          -- => config pronte per ogni server lsp
  'https://github.com/mason-org/mason.nvim',           -- => installa i server ; gestore pacchetti
  'https://github.com/mason-org/mason-lspconfig.nvim', -- => ponte mason <-> lsp ; auto-enable
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') }, -- => completamento
  'https://github.com/rafamadriz/friendly-snippets',   -- => snippet pronti
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

-- LUA => 'vim' globale ; niente warning --
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
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


-- future UI -- 






