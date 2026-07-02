-- Theme And Various UI Config --
require("tokyonight").setup({
	style = "night", -- => night / storm / moon / day ; "night" = same background as the terminal
})

vim.cmd.colorscheme("tokyonight")

-- NVIM-NOTIFY => notifications as popups in the top-right corner --
-- :Notifications => history of past notifications
require("notify").setup({
	stages = "fade", -- => fade in/out animation
	timeout = 3000, -- => ms before the popup disappears
})
vim.notify = require("notify") -- => every vim.notify() call becomes a popup (ConfigUpdate, plugins...)

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
