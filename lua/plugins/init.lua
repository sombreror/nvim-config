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
})

-- MASON --
require("mason").setup()

-- BLINK => only the NON-default stuff --
require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	completion = {
		documentation = { auto_show = true }, -- => shows the docs automatically
		ghost_text = { enabled = true }, -- => inline grey preview
	},
	signature = { enabled = true }, -- => help on function parameters
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

-- EMMET + HTML => also attach inside .php files (php with embedded html) --
-- so Emmet abbreviations (e.g. ! ) and HTML completion work in .php too
vim.lsp.config("emmet_language_server", {
	filetypes = vim.list_extend(vim.deepcopy(vim.lsp.config.emmet_language_server.filetypes), { "php" }),
})
vim.lsp.config("html", {
	filetypes = vim.list_extend(vim.deepcopy(vim.lsp.config.html.filetypes), { "php" }),
})

-- tree-sitter-manager --
require("tree-sitter-manager").setup({
	auto_install = true,
	ensure_installed = {
		"lua",
		"python",
		"javascript",
		"php",
		"php_only",
		"html",
		"css",
		"typescript",
		"json",
	},
})

-- CONFORM => formatter (manual via <leader>cf) --
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		php = { "php_cs_fixer" },
		javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
		typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
		json = { "biome", "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
	},
	-- no format on save: formatting is manual via <leader>cf
})

-- gitsigns --
require("gitsigns").setup()

-- AUTOPAIRS => auto-closes brackets and quotes --
require("nvim-autopairs").setup({
	check_ts = true, -- => uses treesitter ; doesn't close when it makes no sense in context
})

-- MINI.MOVE => alt+hjkl --
require("mini.move").setup()

-- MINI.SURROUND --
-- sa{motion}{char} => ADD surround       e.g. saiw)  -> (word)
-- sd{char}         => DELETE surround     e.g. sd"    -> removes the " "
-- sr{old}{new}     => REPLACE surround    e.g. sr)]   -> from () to []
-- sf{char} / sF    => FIND to the right / to the left
-- sh{char}         => HIGHLIGHT the surround
-- suffix n / l     => act on the next / previous one   e.g. sdn) sdl)
-- (in Visual: select then press sa{char})
require("mini.surround").setup({
	search_method = "cover_or_next", -- => acts even if the cursor is before the target, not only inside
})

-- TELESCOPE--
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		-- initial_mode = "normal", -- => to change if it's not right for me --
		layout_config = { prompt_position = "top" },
		file_ignore_patterns = { "node_modules", ".git/", "vendor" },
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
	pickers = {
		find_files = { hidden = true },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

-- LOAD => load_extension fzf --
require("telescope").load_extension("fzf")

-- TELESCOPE => File Browser --
require("telescope").load_extension("file_browser")

-- MASON-LSPCONFIG => goes LAST ; installs + enables --
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls", -- => lua
		"pyright", -- => python
		"ts_ls", -- => javascript + typescript
		"intelephense", -- => php
		"html", -- => html
		"cssls", -- => css + scss + less
		"emmet_language_server", -- => emmet ; html/css abbreviations
		"eslint", -- => linting js/ts
		"jsonls", -- => json ; package.json etc
	},
})

-- Theme And Various UI Config--
require("tokyonight").setup({
	style = "night", -- => night / storm / moon / day ; "night" = same background as the terminal
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

-- TODO COMMENTS --
-- highlights keywords in comments: TODO: FIXME: HACK: WARN: PERF: NOTE: TEST:
-- :TodoTelescope  => fuzzy list of all comments in the project (mapped to <leader>ft)
-- :TodoQuickFix   => send them to the quickfix list
require("todo-comments").setup()
