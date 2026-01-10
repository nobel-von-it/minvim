-- This keymaps are non-reliance with lazy.nvim and plugins
vim.keymap.set("n", "<leader>e", vim.cmd.Explore, { desc = "Open vim Explorer" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Remap escape to jk", silent = true, noremap = true })
vim.keymap.set(
	"n",
	"<leader>n",
	vim.cmd.nohl,
	{ desc = "Shortcut for nohl (uncolor searched)", silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Режим фокуса (ZenMode)" })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Переместить блок вверх" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Переместить блок вниз" })
