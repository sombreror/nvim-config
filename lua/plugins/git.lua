-- gitsigns => git signs in the gutter + hunk actions --
-- keymaps are buffer-local (on_attach) => they exist only inside git-tracked files
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function map(l, r, desc)
			vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc })
		end

		-- move between changes --
		map("]c", function()
			gs.nav_hunk("next")
		end, "Next git hunk")
		map("[c", function()
			gs.nav_hunk("prev")
		end, "Previous git hunk")

		-- act on the hunk under the cursor => half of lazygit without leaving the file --
		map("<leader>gp", gs.preview_hunk, "Preview hunk (see the diff)")
		map("<leader>ga", gs.stage_hunk, "Stage hunk (git add)")
		map("<leader>gr", gs.reset_hunk, "Reset hunk (discard change)")

		-- same keys in visual mode => stage/reset only the SELECTED lines of a hunk --
		local function vmap(l, r, desc)
			vim.keymap.set("v", l, r, { buffer = bufnr, desc = desc })
		end
		vmap("<leader>ga", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage the selected lines")
		vmap("<leader>gr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset the selected lines")
	end,
})

-- (lazygit.nvim needs no setup: it only defines :LazyGit, mapped to <leader>gg in keymaps.lua)
