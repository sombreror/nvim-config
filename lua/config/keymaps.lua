-- paste without overwriting what you copied
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without overwriting the register" })

-- clear highlighting when you press esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>',  {desc= "clears all highlighting when you press esc"})


-- LAZYGIT => keymap config leader+gg --
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", {desc = "Open LazyGit"})


-- VSPLIT --
vim.keymap.set("n", "<leader>r", "<cmd>vsplit<CR>", {desc = "quick vertical split"})




-- MOVEMENTS => move across horizontal and vertical splits --

-- keymap: ctrl+w+l => ctrl+l --
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "quick switch to the right split"})

-- keymap: ctrl+w+h => ctrl+h --
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "quick switch to the left split"})

-- keymap: ctrl+w+k => ctrl+k --
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "quick switch to the split above"})

-- keymap: ctrl+w+j => ctrl+j --
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "quick switch to the split below"})




-- TELESCOPE Open -- 
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {desc = "Fast Telescope find files"})
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", {desc = "Open the last picker you were in"})
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {desc = "Open Telescope buffers"})


-- TELESCOPE GIT COMMANDS -- 
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", {desc = "Open with Telescope git_status"})
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", {desc = "Open with Telescope git_commits"})
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", {desc = "Open with Telescope git_branches"})



