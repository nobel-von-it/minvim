local ok_sm, sm = pcall(require, "supermaven-nvim")
if not ok_sm then
	return
end

sm.setup({
	disable_keymaps = true, -- Disable default keymaps to use our integrated ones
	color = {
		suggestion = "#808080", -- Grey color for ghost text suggestions
	},
})

-- Smart Tab keymap in insert mode:
-- 1. If Supermaven suggestion is visible, accept it
-- 2. Otherwise, insert regular Tab / indent
vim.keymap.set("i", "<Tab>", function()
	local ok_preview, preview = pcall(require, "supermaven-nvim.completion_preview")
	if ok_preview and preview.has_suggestion() then
		preview.on_accept_suggestion()
		return
	end
	local keys = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { silent = true, desc = "Smart Tab (Accept AI suggestion or indent)" })

-- Clear current suggestion using Ctrl + ]
vim.keymap.set("i", "<C-]>", function()
	local ok_preview, preview = pcall(require, "supermaven-nvim.completion_preview")
	if ok_preview and preview.has_suggestion() then
		preview.on_clear_suggestion()
	end
end, { desc = "Clear Supermaven Suggestion" })

-- Accept suggestion word-by-word using Ctrl + y
vim.keymap.set("i", "<C-y>", function()
	local ok_preview, preview = pcall(require, "supermaven-nvim.completion_preview")
	if ok_preview and preview.has_suggestion() then
		preview.on_accept_word()
	end
end, { desc = "Accept Supermaven Word" })

-- Accept autocomplete suggestions on Enter if the popup menu is open
vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	end
	return "<CR>"
end, { expr = true, replace_keycodes = true, desc = "Accept completion on Enter" })
