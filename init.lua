vim.g.mapleader = ' '
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.timeoutlen = 200
vim.opt.scrolloff = 12
vim.opt.swapfile = false
vim.opt.backup = false

local opts = { silent = true, noremap = true }

vim.keymap.set('i', 'jk', '<ESC>', opts)

vim.keymap.set('n', '<leader>n', vim.cmd.nohl, opts)
vim.keymap.set('n', '<leader>e', vim.cmd.Explore, opts)
vim.keymap.set('n', '<leader>g', vim.cmd.Neogit, opts)

vim.keymap.set('v', '<Tab>', ':<C-u>exec "\'<,\'>normal! I\\t"<CR>', opts)
vim.keymap.set('v', '<S-Tab>', ':<C-u>exec "\'<,\'>normal! x"<CR>', opts)

-- Rust (rustfmt)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.rs",
--   command = "silent !cargo fmt",
-- })

-- C/C++ (clang-format)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.c,*.cpp,*.h",
--   command = "silent !clang-format -i %",
-- })

-- Lua (lua-format)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.lua",
--   command = "silent !lua-format -i %",
-- })

-- HTML (prettier)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.html",
--   command = "silent !prettier --write %",
-- })

-- CSS (prettier)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.css",
--   command = "silent !prettier --write %",
-- })

-- JavaScript (prettier)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.js",
--   command = "silent !prettier --write %",
-- })

-- Go (gofmt)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   command = "silent !gofmt -w %",
-- })

-- Erlang (erlang-format)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.erl",
--   command = "!erlang-format -i %",
-- })


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup{
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			vim.wo.foldmethod = 'expr'
			vim.wo.foldexpr = 'nvim_treesitter#foedexpr()'
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = {
					'vimdoc', 'rust', 'c', 'lua', 'html', 'css', 'bash', 'go', 'javascript', 'cpp', 'erlang', 'prolog'
				},
				sync_install = false,
				auto_install = true,
				indent = {
					enable = true
				},
				highlight = {
					enable = true,
				},
			}
		end
	},
	{
		'NeogitOrg/neogit',
    		dependencies = {
      			'nvim-lua/plenary.nvim',
      			'sindrets/diffview.nvim',
      			'ibhagwan/fzf-lua',
    		},
    		config = true
	},
	{
    		'Exafunction/codeium.vim',
    		event = 'BufEnter',
  	},
	{ 
		'akinsho/toggleterm.nvim', 
		version = '*', 
		config = function()
    			require('toggleterm').setup()
    			vim.keymap.set('n', '<C-/>', ':ToggleTerm direction=float<CR>', opts)
    			vim.keymap.set('t', '<C-/>', '<C-\\><C-n>:ToggleTerm direction=float<CR>', opts)
  		end 
	},
	{ 
		"catppuccin/nvim", 
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'catppuccin'
		end

	}
}
