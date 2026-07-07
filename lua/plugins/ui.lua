-- Theme And Various UI Config --
-- tokyonight's annotations mark optional fields (on_colors...) as required => silence the false warning
---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
	style = "night", -- => night / storm / moon / day ; "night" = same background as the terminal
})

vim.cmd.colorscheme("tokyonight")

-- NVIM-NOTIFY => notifications as popups in the top-right corner --
-- :Notifications => history of past notifications
-- same story as tokyonight => merge_duplicates is optional, not required
---@diagnostic disable-next-line: missing-fields
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
local function notify_highlights()
	local palette = require("tokyonight.colors").setup()
	for level, color in pairs({ ERROR = palette.red, WARN = palette.yellow, INFO = palette.green }) do
		vim.api.nvim_set_hl(0, "Notify" .. level .. "Border", { fg = color, bg = palette.bg })
		vim.api.nvim_set_hl(0, "Notify" .. level .. "Icon", { fg = color })
		vim.api.nvim_set_hl(0, "Notify" .. level .. "Title", { fg = color })
	end
end
notify_highlights()

-- :colorscheme wipes every custom highlight => re-apply ours after each change
vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Re-apply the notify border colors after a colorscheme change",
	group = vim.api.nvim_create_augroup("notify-highlights", { clear = true }),
	callback = notify_highlights,
})

-- HIGHLIGHT COLORS => shows #ff5500, rgb(), hsl()... as the actual color, inline --
require("nvim-highlight-colors").setup({})

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
