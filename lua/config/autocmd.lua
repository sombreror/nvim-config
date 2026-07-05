-- highlight copied text => useful to see if yank worked
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return last position of cursor after reopening a buffer --
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Return to last cursor position when reopening a file",
	group = vim.api.nvim_create_augroup("last-cursor", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- stop auto-continuing comments on a new line => r (Enter) and o (o/O) --
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable comment continuation on new line",
	group = vim.api.nvim_create_augroup("no-comment-continuation", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- reload files changed outside nvim => lazygit, git checkout, another editor... --
-- checktime compares the file on disk with the buffer and reloads it if it changed
-- (getcmdwintype() => skip when the command-line window is open: checktime errors there)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
	desc = "Reload the buffer when the file changes on disk",
	group = vim.api.nvim_create_augroup("auto-reload", { clear = true }),
	callback = function()
		if vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})

-- terminal => no line numbers/signs, start already in insert mode --
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Clean look + insert mode when opening a terminal",
	group = vim.api.nvim_create_augroup("term-open", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.cmd.startinsert()
	end,
})

-- rebalance the splits when the terminal window is resized --
vim.api.nvim_create_autocmd("VimResized", {
	desc = "Equalize split sizes on window resize",
	group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
	command = "wincmd =",
})
