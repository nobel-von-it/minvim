return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.3
				end
			end,
			open_mapping = nil,
			direction = 'vertical',
			shade_terminals = true,
			persist_size = true,
			start_in_insert = true,
			close_on_exit = true,
		})

		local function toggle_v_term()
			toggleterm.toggle(1, nil, nil, 'vertical')
		end

		local opts = { noremap = true, silent = true }

		vim.keymap.set('n', '<C-\\>', toggle_v_term, opts)
		vim.keymap.set('i', '<C-\\>', '<Esc><Cmd>lua require("toggleterm").toggle()<CR>', opts)
		vim.keymap.set('t', '<C-\\>', '<Cmd>ToggleTerm<CR>', opts)

		function _G.set_terminal_keymaps()
			local t_opts = { buffer = 0 }
			vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], t_opts)
			vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], t_opts)
			vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], t_opts)
			vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], t_opts)

			vim.keymap.set('t', '<C-\\>', [[<Cmd>ToggleTerm<CR>]], t_opts)
		end

		vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
	end
}
