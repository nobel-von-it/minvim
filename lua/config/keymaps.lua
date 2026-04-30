local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Files & Navigation
map("n", "<leader><leader>", require("fzf-lua").files, { desc = "Find Files" })
map("n", "<leader>b", require("fzf-lua").buffers, { desc = "Buffers" })
map("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Live Grep" })

-- Smart Move "gd"
-- 1. Try tags
-- 2. If fail, grep for word under cursor
local function smart_gd()
	local success, _ = pcall(vim.cmd, "tag " .. vim.fn.expand("<cword>"))
	if not success then
		print("Tag not found, grepping...")
		require("fzf-lua").grep_cword()
	end
end

map("n", "gd", smart_gd, { desc = "Smart Go to Definition" })

-- Quickfix Navigation
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev Quickfix" })
map("n", "<leader>q", "<cmd>copen<CR>", { desc = "Open Quickfix" })

-- Run/Make
map("n", "<leader>r", "<cmd>Make<CR>", { desc = "Run/Make (Dispatch)" })

-- Oil (File Explorer)
map("n", "<leader>e", function()
	local ok, oil = pcall(require, "oil")
	if not ok then return end
	if vim.bo.filetype == "oil" then
		oil.close()
	else
		oil.open()
	end
end, { desc = "Toggle Oil" })

-- Open Oil with '-' (standard)
map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })

-- Better Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
