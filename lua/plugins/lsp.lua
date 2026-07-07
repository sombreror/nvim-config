-- MASON --
require("mason").setup()

-- Diagnostics --
vim.diagnostic.config({
	virtual_text = true, -- => error text
	severity_sort = true, -- => severity of the problem
	signs = { -- => nerd font icons in the gutter instead of the default E/W/I/H letters
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

-- LAZYDEV => teaches lua_ls the nvim API when editing this config --
-- real completion + docs (K) for vim.* ; also makes the "vim" global known,
-- so the old `globals = { "vim" }` workaround is no longer needed
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- => types for vim.uv (libuv)
	},
})

-- EMMET + HTML => also attach inside .php files (php with embedded html) --
-- so Emmet abbreviations (e.g. ! ) and HTML completion work in .php too
vim.lsp.config("emmet_language_server", {
	filetypes = vim.list_extend(vim.deepcopy(vim.lsp.config.emmet_language_server.filetypes or {}), { "php" }),
})
vim.lsp.config("html", {
	filetypes = vim.list_extend(vim.deepcopy(vim.lsp.config.html.filetypes or {}), { "php" }),
})

-- MASON-LSPCONFIG => goes LAST ; installs + enables --
-- (must run after every vim.lsp.config override above)
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

-- MASON-TOOL-INSTALLER => formatters (conform) --
-- mason-lspconfig's ensure_installed only covers LSP servers ;
-- without this, a fresh machine has no formatters and <leader>cf fails
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua", -- => lua
		"black", -- => python
		"php-cs-fixer", -- => php
		"biome", -- => js/ts/json (first choice)
		"prettierd", -- => html/css/scss + fallback for js/ts/json
		"prettier", -- => last-resort fallback
	},
})
