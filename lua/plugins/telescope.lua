-- TELESCOPE --
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		-- initial_mode = "normal", -- => to change if it's not right for me --
		layout_config = { prompt_position = "top" },
		-- lua patterns => escape the dot and anchor, or "vendor" also hides vendor.js
		file_ignore_patterns = { "node_modules/", "%.git/", "^vendor/" },
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
	pickers = {
		find_files = { hidden = true },
		-- rg skips hidden files by default => without this, files findable
		-- with <leader>ff would be invisible to <leader>fg
		live_grep = { additional_args = { "--hidden", "--glob", "!.git/" } },
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
-- pcall => if libfzf.so is missing, the error would abort every module loaded
-- after this one (navigation, ui, lsp...) ; degrade to the lua sorter instead
local fzf_ok = pcall(require("telescope").load_extension, "fzf")
if not fzf_ok then
	vim.notify("telescope-fzf-native is not built => using the slower lua sorter", vim.log.levels.WARN)
end

-- TELESCOPE => File Browser --
require("telescope").load_extension("file_browser")
