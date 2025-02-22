return 	{
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
}

