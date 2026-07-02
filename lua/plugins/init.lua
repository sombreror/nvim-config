-- Plugin list => vim.pack downloads everything at the versions pinned in nvim-pack-lock.json
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig", -- => ready-made config for every lsp server
	"https://github.com/mason-org/mason.nvim", -- => installs the servers ; package manager
	"https://github.com/mason-org/mason-lspconfig.nvim", -- => bridge mason <-> lsp ; auto-enable
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") }, -- => completion
	"https://github.com/rafamadriz/friendly-snippets", -- => ready-made snippets
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
	"https://github.com/windwp/nvim-autopairs", -- => auto-closes () [] {} "" ''
	"https://github.com/lewis6991/gitsigns.nvim", -- => git signs in the gutter + blame
	"https://github.com/nvim-lua/plenary.nvim", -- => utility library (required by lazygit.nvim)
	"https://github.com/kdheepak/lazygit.nvim", -- => opens lazygit inside nvim
	"https://github.com/folke/tokyonight.nvim", -- => Tokyo Night theme ; matched to the terminal
	"https://github.com/nvim-tree/nvim-web-devicons", -- => filetype icons (needed by lualine ; requires a Nerd Font)
	"https://github.com/nvim-lualine/lualine.nvim", -- => lualine: status bar
	"https://github.com/nvim-telescope/telescope.nvim", -- => fuzzy finder to search files and text
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim", -- => faster telescope and search of files
	"https://github.com/nvim-telescope/telescope-file-browser.nvim", -- => telescope file browser (like oil.nvim)
	"https://github.com/stevearc/conform.nvim", -- => better formatter for code + more options
	"https://github.com/nvim-mini/mini.surround", -- => help for "", (), '', {}, []
	"https://github.com/nvim-mini/mini.move", -- => movement alt+hjkl for moving lines in visual and normal mode
	"https://github.com/folke/todo-comments.nvim", -- => TODO and all types of comments
	"https://github.com/rcarriga/nvim-notify", -- => vim.notify() as popups in the top-right corner
	"https://github.com/folke/which-key.nvim", -- => popup with the available keymaps after <leader>
	"https://github.com/folke/flash.nvim", -- => jump anywhere on screen with 2 chars + label
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" }, -- => bookmark hot files, 1-key switch
	"https://github.com/nvim-mini/mini.ai", -- => smarter textobjects: vif = inside function, via = inside argument
	"https://github.com/MagicDuck/grug-far.nvim", -- => project-wide search & replace (ripgrep) with live preview
	"https://github.com/brenoprata10/nvim-highlight-colors", -- => shows css colors inline (#ff5500, rgb()...)
	"https://github.com/folke/lazydev.nvim", -- => nvim API completion + docs when editing this config
	"https://github.com/brianhuster/live-preview.nvim", -- => live html/css/md preview in the browser (:LivePreview)
})

-- Setup modules => one file per area
require("plugins.completion") -- => blink.cmp (+ lazydev source)
require("plugins.treesitter") -- => tree-sitter-manager
require("plugins.editing") -- => conform, autopairs, mini.*, todo-comments, grug-far
require("plugins.git") -- => gitsigns + hunk keymaps
require("plugins.telescope") -- => telescope + fzf + file_browser
require("plugins.navigation") -- => flash, harpoon, which-key
require("plugins.ui") -- => tokyonight, lualine, nvim-notify, highlight-colors
require("plugins.lsp") -- => mason + servers + lazydev ; goes LAST: mason-lspconfig enables the servers
