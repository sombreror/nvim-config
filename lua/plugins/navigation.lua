-- FLASH => jump anywhere on screen: <leader>j + 2 chars, then the label key --
-- also upgrades native f/F/t/T with labels, out of the box
-- (jump is on <leader>j and NOT on the usual "s": s belongs to mini.surround here)
require("flash").setup({})

-- HARPOON => bookmark the files you are working on right now --
-- <leader>a  => add current file ; <leader>h => menu ; <leader>1..4 => jump to file 1..4
-- (telescope = search anything ; harpoon = instant switch between the 3-4 hot files)
require("harpoon"):setup() -- => colon call, as the harpoon README requires (self = the harpoon instance)

-- WHICH-KEY => press <leader> and wait: popup with every keymap and what it does --
require("which-key").setup({})
require("which-key").add({
	{ "<leader>f", group = "find (telescope)" },
	{ "<leader>g", group = "git" },
	{ "<leader>s", group = "search & replace" },
	{ "<leader>c", group = "code" },
})
