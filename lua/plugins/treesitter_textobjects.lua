return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	init = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@comment.outer",
						["ic"] = "@comment.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sp"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>sP"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,

					goto_next_start = {
						["]m"] = "@function.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
					},

					goto_next = {
						["]d"] = "@conditional.outer",
					},
					goto_previous = {
						["[d"] = "@conditional.outer",
					},
				},
			},
		})
	end,
}
