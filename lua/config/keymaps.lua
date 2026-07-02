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

-- LSP --
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })

-- FORMAT (conform) => format then save --
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = false, lsp_format = "fallback" })
	vim.cmd("write")
end, { desc = "Format buffer/selection with conform, then save" })

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
