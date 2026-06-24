vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",          -- => ready-made config for every lsp server
    "https://github.com/mason-org/mason.nvim",           -- => installs the servers ; package manager
    "https://github.com/mason-org/mason-lspconfig.nvim", -- => bridge mason <-> lsp ; auto-enable
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") }, -- => completion
    "https://github.com/rafamadriz/friendly-snippets",   -- => ready-made snippets
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    "https://github.com/windwp/nvim-autopairs",          -- => auto-closes () [] {} "" ''
    "https://github.com/lewis6991/gitsigns.nvim",        -- => git signs in the gutter + blame
    "https://github.com/nvim-lua/plenary.nvim",          -- => utility library (required by lazygit.nvim)
    "https://github.com/kdheepak/lazygit.nvim",          -- => opens lazygit inside nvim
    "https://github.com/folke/tokyonight.nvim",          -- => Tokyo Night theme ; matched to the terminal
    "https://github.com/nvim-tree/nvim-web-devicons",    -- => filetype icons (needed by lualine ; requires a Nerd Font)
    "https://github.com/nvim-lualine/lualine.nvim",      -- => lualine: status bar
    "https://github.com/nvim-telescope/telescope.nvim",  -- => fuzzy finder to search files and text
})



-- MASON --
require("mason").setup()


-- BLINK => only the NON-default stuff --
require("blink.cmp").setup({
    keymap = {preset = "super-tab"},
    completion = {
        documentation = { auto_show = true }, -- => shows the docs automatically
        ghost_text = { enabled = true },      -- => inline grey preview
    },
    signature = { enabled = true },         -- => help on function parameters
})

-- LSP Config --
vim.diagnostic.config({
   virtual_text = true, -- => error text
   severity_sort = true, -- => severity of the problem
})


-- LUA => "vim" global ; no warnings --
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



-- AUTOPAIRS => auto-closes brackets and quotes --
require("nvim-autopairs").setup({
    check_ts = true,   -- => uses treesitter ; doesn't close when it makes no sense in context
})




-- TELESCOPE => to continue--
require("telescope").setup()











-- MASON-LSPCONFIG => goes LAST ; installs + enables --
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",                 -- => lua
    "pyright",                -- => python
    "ts_ls",                  -- => javascript + typescript
    "intelephense",           -- => php
    "html",                   -- => html
    "cssls",                  -- => css + scss + less
    "emmet_language_server",  -- => emmet ; html/css abbreviations
    "eslint",                 -- => linting js/ts
    "jsonls",                 -- => json ; package.json etc
  },
})


-- Theme And Various UI Config--
require("tokyonight").setup({
    style = "night",         -- => night / storm / moon / day ; "night" = same background as the terminal
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


-- OBSIDIAN NVIM => to setup -- 















