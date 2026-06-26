-- Cache Lua modules => load faster
vim.loader.enable()

-- Leader => space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Entry point: load the config modules
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.commands")
require("plugins")



-- experimental UI => redesigned cmdline and messages, no "Press ENTER"
require('vim._core.ui2').enable({})
