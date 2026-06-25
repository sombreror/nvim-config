-- numbers --
vim.opt.number = true
vim.opt.relativenumber = true -- faster movement with hjkl

-- clipboard --
vim.opt.clipboard = "unnamedplus"

-- Theme -- 
vim.opt.termguicolors = true

-- keep undo history even after closing files
vim.opt.undofile = true


-- search --
vim.opt.ignorecase = true -- ignore uppercase/lowercase
vim.opt.smartcase = true -- unless uppercase is used

-- always reserve space for diagnostics/icons
vim.opt.signcolumn = "yes"

-- highlight current line => easier to track cursor position
vim.opt.cursorline = true

-- faster updates for plugins, diagnostics, etc.
vim.opt.updatetime = 250

-- splits --
vim.opt.splitright = true -- vertical splits open on the right
vim.opt.splitbelow = true -- horizontal splits open below

-- indentation --
vim.opt.expandtab = true -- convert TAB key into spaces
vim.opt.shiftwidth = 4 -- spaces used for auto-indent
vim.opt.tabstop = 4 -- visual width of a TAB

-- hide "-- INSERT --" message
-- useful when using a statusline plugin
vim.opt.showmode = false

-- keep some context around the cursor while scrolling
vim.opt.scrolloff = 999 -- => 999 so the cursor when navigating is always in the center 

-- preserve indentation when long lines wrap
vim.opt.breakindent = true



