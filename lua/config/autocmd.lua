-- highlight copied text => useful to see if yank worked
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
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


-- trim all withspaces when after :w (saving a file) -- 
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Trim trailing whitespace on save",
    group = vim.api.nvim_create_augroup("trim-whitespace", { clear = true }),
    callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
})



