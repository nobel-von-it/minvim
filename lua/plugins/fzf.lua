return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{ "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", desc = "[F]ind [F]iles" },
		{ "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", desc = "[F]ind [G]rep" },
		{ "<leader>fb", "<cmd>lua require('fzf-lua').builtin()<cr>", desc = "[F]ind [B]uiltin commands" },
		{ "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<cr>", desc = "[F]ind [H]elp" },
	},
}
