-- Cache Lua modules => load faster
vim.loader.enable()

-- Leader => space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Entry point: load the config modules
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.commands")
require("plugins")

-- experimental UI => redesigned cmdline and messages, no "Press ENTER"
-- pcall => private module ("_"), its name can change between nvim versions ;
-- without pcall a rename would break the whole config at startup
-- (but warn instead of failing silently => a rename would go unnoticed forever)
local ui2_ok = pcall(function()
	require("vim._core.ui2").enable({})
end)
if not ui2_ok then
	vim.notify("vim._core.ui2 not found => experimental UI disabled (renamed upstream?)", vim.log.levels.WARN)
end
