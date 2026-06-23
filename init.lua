-- Cache dei moduli Lua => load more fast
vim.loader.enable()

-- Leader => spazio 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Punto d'ingresso: carica i moduli del config
require("config.options")
require("config.keymaps")
require("plugins")




-- UI sperimentale => cmdline e messaggi ridisegnati, niente "Press ENTER"
require('vim._core.ui2').enable({})











