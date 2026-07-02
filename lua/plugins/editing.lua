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

-- TODO COMMENTS --
-- highlights keywords in comments: TODO: FIXME: HACK: WARN: PERF: NOTE: TEST:
-- :TodoTelescope  => fuzzy list of all comments in the project (mapped to <leader>ft)
-- :TodoQuickFix   => send them to the quickfix list
require("todo-comments").setup()
