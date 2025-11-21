return {
	"karb94/neoscroll.nvim",
	opts = {},
	keys = {
		{
			"<C-u>",
			function()
				require("neoscroll").ctrl_u({ duration = 250 })
			end,
			desc = "Scroll up",
			{ "n", "v", "x" },
		},
		{
			"<C-d>",
			function()
				require("neoscroll").ctrl_d({ duration = 250 })
			end,
			desc = "Scroll down",
			{ "n", "v", "x" },
		},
		{
			"<C-b>",
			function()
				require("neoscroll").ctrl_b({ duration = 450 })
			end,
			desc = "Scroll down",
			{ "n", "v", "x" },
		},
		{
			"zt",
			function()
				require("neoscroll").zt({ half_win_duration = 250 })
			end,
			desc = "Scroll to top",
			{ "n", "v", "x" },
		},
		{
			"zz",
			function()
				require("neoscroll").zz({ half_win_duration = 250 })
			end,
			desc = "Scroll to center",
			{ "n", "v", "x" },
		},
		{
			"zb",
			function()
				require("neoscroll").zb({ half_win_duration = 250 })
			end,
			desc = "Scroll to bottom",
			{ "n", "v", "x" },
		},
	},
}
