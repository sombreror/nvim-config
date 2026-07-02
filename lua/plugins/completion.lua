-- BLINK => only the NON-default stuff --
require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	completion = {
		documentation = { auto_show = true }, -- => shows the docs automatically
		ghost_text = { enabled = true }, -- => inline grey preview
	},
	signature = { enabled = true }, -- => help on function parameters
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			-- lazydev => nvim API results (vim.*) above the generic lua_ls ones
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
})
