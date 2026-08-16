local map = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick Escape
map("i", "jk", "<Esc>", { desc = "Escape Insert Mode" })

-- Files & Navigation
map("n", "<leader><leader>", require("fzf-lua").files, { desc = "Find Files" })
map("n", "<leader>b", require("fzf-lua").buffers, { desc = "Buffers" })
map("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Live Grep" })

-- Fallback "gd" (when LSP is not attached)
local function fallback_gd()
	require("fzf-lua").grep_cword()
end

map("n", "gd", fallback_gd, { desc = "Fallback Go to Definition (Grep)" })

-- Quickfix Navigation
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev Quickfix" })
map("n", "<leader>q", "<cmd>copen<CR>", { desc = "Open Quickfix" })

-- Run/Make
map("n", "<leader>r", "<cmd>Make<CR>", { desc = "Run/Make (Dispatch)" })

-- Format
map("n", "<leader>f", function()
	if vim.bo.filetype == "rust" then
		vim.cmd("!cargo fmt")
	end
end, { desc = "Format File" })

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

-- Git
map("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Git Status (Neogit)" })

-- Better Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
