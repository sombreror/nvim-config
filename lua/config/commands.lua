-- CONFIG UPDATE => pull the latest config from git, from inside nvim --
-- :ConfigUpdate  => fetch + rebase the config repo, auto-stashing local changes
vim.api.nvim_create_user_command("ConfigUpdate", function()
	local dir = vim.fn.stdpath("config") -- => config path ; works on any device/OS

	-- HEAD => current commit hash ; comparing it before/after the pull is language-proof
	-- (reading git's text would break if LANG is set to another language)
	local function head()
		return vim.system({ "git", "-C", dir, "rev-parse", "HEAD" }, { text = true }):wait().stdout
	end

	local before = head() -- => instant local call, safe to run sync
	vim.notify("Updating config...", vim.log.levels.INFO)

	-- run git async with vim.system => never freezes nvim while pulling
	vim.system({ "git", "-C", dir, "pull", "--rebase", "--autostash" }, { text = true }, function(res)
		-- vim.schedule => back on the main thread ; nvim API is unsafe inside this callback
		vim.schedule(function()
			if res.code ~= 0 then
				-- => git failed: conflict, no repo, no network...
				vim.notify(vim.trim((res.stdout or "") .. (res.stderr or "")), vim.log.levels.ERROR)
			elseif head() == before then
				vim.notify("Already up to date.", vim.log.levels.INFO) -- => HEAD didn't move
			else
				vim.notify("Config updated => restart nvim to apply.", vim.log.levels.WARN) -- => HEAD moved
			end
		end)
	end)
end, { desc = "Pull the latest config updates from git" })

-- PLUGIN UPDATE => the missing half of :ConfigUpdate --
-- :PackUpdate => vim.pack downloads the new versions and opens a review buffer
-- with the changelog of every plugin ; :write applies, :q discards.
-- Applying also refreshes nvim-pack-lock.json => commit it to pin the versions
vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update all plugins (review buffer, :write to apply)" })
