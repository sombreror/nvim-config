-- TELESCOPE --
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		-- initial_mode = "normal", -- => to change if it's not right for me --
		layout_config = { prompt_position = "top" },
		file_ignore_patterns = { "node_modules", ".git/", "vendor" },
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
	pickers = {
		find_files = { hidden = true },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

-- LOAD => load_extension fzf --
require("telescope").load_extension("fzf")

-- TELESCOPE => File Browser --
require("telescope").load_extension("file_browser")
