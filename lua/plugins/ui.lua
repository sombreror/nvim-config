-- Theme And Various UI Config --
require("tokyonight").setup({
	style = "night", -- => night / storm / moon / day ; "night" = same background as the terminal
})

vim.cmd.colorscheme("tokyonight")

-- NVIM-NOTIFY => notifications as popups in the top-right corner --
-- :Notifications => history of past notifications
require("notify").setup({
	render = "wrapped-compact", -- => compact single-block popup ; long text wraps instead of stretching
	stages = "fade", -- => fade in/out animation ; rounded border
	timeout = 3000, -- => ms before the popup disappears
	minimum_width = 20, -- => default is 50: that's why the popups were always huge
	max_width = 45, -- => wrap long messages at 45 columns
})
vim.notify = require("notify") -- => every vim.notify() call becomes a popup (ConfigUpdate, plugins...)

-- Notification border color by level => tokyonight dims them to 30% (all borders look the same) ;
-- full-strength colors instead: red = error, yellow = warning, green = all good
local palette = require("tokyonight.colors").setup()
for level, color in pairs({ ERROR = palette.red, WARN = palette.yellow, INFO = palette.green }) do
	vim.api.nvim_set_hl(0, "Notify" .. level .. "Border", { fg = color, bg = palette.bg })
	vim.api.nvim_set_hl(0, "Notify" .. level .. "Icon", { fg = color })
	vim.api.nvim_set_hl(0, "Notify" .. level .. "Title", { fg = color })
end

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
