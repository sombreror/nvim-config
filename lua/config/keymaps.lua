-- incolla senza sovrascrivere quello che hai copiato
vim.keymap.set("x", "p", [["_dP]], { desc = "Incolla senza sovrascrivere il registro" })

-- clear highlighting quando premi esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>',  {desc= "pulisce tutto quello evidenziato quando premi esc"})


-- LAZYGIT => keymaps config leader+gg -- 
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", {desc = "Apertura LazyGit"})




-- VSPLIT -- 
vim.keymap.set("n", "<leader>r", "<cmd>vsplit<CR>", {desc = "vsplit veloce pagina verticale"})




-- MOVEMENTS => movimenti con slipt orizzontali e verticali -- 

-- keymap: ctrl+w+l => ctrl+l -- 
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "switch pagina a destra veloce con split"})

-- keymap: ctrl+w+h => ctrl+h -- 
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "switch pagina a sinistra veloce con split"})

-- keymap: ctrl+w+k => ctrl+k -- 
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "switch pagina sopra veloce con split"})

-- keymap: ctrl+w+j => ctrl+j -- 
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "switch pagina sotto veloce con split"})
























