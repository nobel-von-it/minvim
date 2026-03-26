vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.timeoutlen = 200

vim.opt.scrolloff = 12

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.clipboard = "unnamedplus"

if vim.g.neovide then
	vim.keymap.set('v', '<C-v>', '"+P')
	vim.keymap.set('i', '<C-v>', '<C-r>+')
	vim.keymap.set('c', '<C-v>', '<C-r>+')
end
