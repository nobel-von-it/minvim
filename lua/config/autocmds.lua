local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("MinVimUser", { clear = true })

-- Auto-generate tags on save (background)
au("BufWritePost", {
	group = group,
	pattern = "*",
	callback = function()
		local project_root = vim.fn.finddir(".git", ".;")
		if project_root ~= "" then
			-- Using .tags to avoid clutter
			vim.fn.jobstart({ "ctags", "-f", ".tags", "-R", "." }, { detach = true })
		end
	end,
})

-- Compiler Settings (makeprg & errorformat)
au("FileType", {
	group = group,
	pattern = "rust",
	callback = function()
		vim.opt_local.makeprg = "cargo build --release"
	end,
})

au("FileType", {
	group = group,
	pattern = { "c", "cpp" },
	callback = function()
		if vim.fn.filereadable("Makefile") == 1 then
			vim.opt_local.makeprg = "make"
		else
			vim.opt_local.makeprg = "gcc % -o %<"
		end
	end,
})

au("FileType", {
	group = group,
	pattern = "python",
	callback = function()
		vim.opt_local.makeprg = "python3 %"
	end,
})

au("FileType", {
	group = group,
	pattern = { "javascript", "typescript" },
	callback = function()
		if vim.fn.filereadable("package.json") == 1 then
			vim.opt_local.makeprg = "npm run build" -- or start
		else
			vim.opt_local.makeprg = "node %"
		end
	end,
})
