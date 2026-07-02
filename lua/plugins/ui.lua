-- Theme And Various UI Config --
require("tokyonight").setup({
	style = "night", -- => night / storm / moon / day ; "night" = same background as the terminal
})

vim.cmd.colorscheme("tokyonight")

-- LUALINE => status bar --
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
