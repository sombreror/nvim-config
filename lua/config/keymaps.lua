-- paste without overwriting what you copied
-- native P (nvim 0.10+) already pastes without yanking the replaced text,
-- and handles end-of-line correctly (unlike the old "_dP trick)
vim.keymap.set("x", "p", "P", { desc = "Paste without overwriting the register" })

-- clear highlighting when you press esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clears all highlighting when you press esc" })

-- LAZYGIT => keymap config leader+gg --
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

-- VSPLIT --
vim.keymap.set("n", "<leader>r", "<cmd>vsplit<CR>", { desc = "quick vertical split" })

-- MOVEMENTS => move across horizontal and vertical splits --

-- keymap: ctrl+w+l => ctrl+l --
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "quick switch to the right split" })

-- keymap: ctrl+w+h => ctrl+h --
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "quick switch to the left split" })

-- keymap: ctrl+w+k => ctrl+k --
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "quick switch to the split above" })

-- keymap: ctrl+w+j => ctrl+j --
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "quick switch to the split below" })

-- TELESCOPE Open --
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fast Telescope find files" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Open the last picker you were in" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Open Telescope buffers" })
vim.keymap.set(
	"n",
	"<leader>fe",
	"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ desc = "Open Telescope file browser (current file dir)" }
)
-- TELESCOPE TODO --
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Open TodoTelescope to search TODO comments" })

-- TELESCOPE LIVE GREP => search TEXT in the whole project (needs ripgrep) --
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep: search text in the project" })

-- TELESCOPE GIT COMMANDS --
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Open with Telescope git_status" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Open with Telescope git_commits" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Open with Telescope git_branches" })

-- DIAGNOSTICS => vim.diagnostic, works even without an LSP server --
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })

-- LSP => buffer-local via LspAttach (same pattern as gitsigns) --
-- the keymaps exist only where a server is attached ; elsewhere the native
-- gd (local declaration) and grr (quickfix references) keep working
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Buffer-local LSP keymaps",
	group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
	callback = function(args)
		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = args.buf, desc = desc })
		end
		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol in the whole project")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action (fix, refactor...)")
		-- grr => native since 0.11, but the quickfix list is bare ; telescope picker instead
		map("n", "grr", "<cmd>Telescope lsp_references<CR>", "References of the symbol (telescope)")
		map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", "Symbols in the file (telescope)")
	end,
})

-- FORMAT (conform) => format then save --
-- (in visual mode formatters without range support, e.g. black, format the whole file)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = false, lsp_format = "fallback" })
	vim.cmd("write")
end, { desc = "Format buffer/selection with conform, then save" })

-- ESLINT => apply every auto-fixable lint fix (js/ts) ; manual like the formatter --
-- :LspEslintFixAll exists only in buffers where the eslint server is attached
vim.keymap.set("n", "<leader>ce", function()
	if vim.fn.exists(":LspEslintFixAll") == 2 then
		vim.cmd("LspEslintFixAll")
	else
		vim.notify("eslint is not attached to this buffer", vim.log.levels.WARN)
	end
end, { desc = "ESLint: fix all auto-fixable problems" })

-- TERMINAL --> integrated terminal in nvim --
vim.keymap.set("n", "<leader>t", "<cmd>terminal<CR>", { desc = "Open the terminal inside nvim" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode with a double Esc" })

-- FLASH => jump anywhere on screen: <leader>j + 2 chars + label key --
-- (not on "s": that prefix belongs to mini.surround)
vim.keymap.set({ "n", "x", "o" }, "<leader>j", function()
	require("flash").jump()
end, { desc = "Flash: jump anywhere with 2 chars" })
vim.keymap.set({ "n", "x", "o" }, "<leader>J", function()
	require("flash").treesitter()
end, { desc = "Flash: select treesitter node" })

-- HARPOON => hot files: add, menu, jump --
vim.keymap.set("n", "<leader>a", function()
	require("harpoon"):list():add()
end, { desc = "Harpoon: add current file" })
vim.keymap.set("n", "<leader>h", function()
	local harpoon = require("harpoon")
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: open the menu" })
for i = 1, 4 do
	vim.keymap.set("n", "<leader>" .. i, function()
		require("harpoon"):list():select(i)
	end, { desc = "Harpoon: jump to file " .. i })
end

-- GRUG-FAR => search & replace in the whole project --
vim.keymap.set("n", "<leader>sr", "<cmd>GrugFar<CR>", { desc = "Search & replace in the project (grug-far)" })

-- MINI.TRAILSPACE => trim trailing whitespace on demand --
-- (the formatters via <leader>cf already trim it ; this covers everything else)
vim.keymap.set("n", "<leader>cw", function()
	require("mini.trailspace").trim()
	require("mini.trailspace").trim_last_lines()
end, { desc = "Trim trailing whitespace + empty last lines" })
