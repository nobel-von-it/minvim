return {
	"karb94/neoscroll.nvim",
	opts = {},
	-- 	neoscroll = require('neoscroll')
	-- local keymap = {
	--   ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
	--   ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
	--   ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end;
	--   ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end;
	--   ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
	--   ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
	--   ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end;
	--   ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end;
	--   ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end;
	-- }
	-- local modes = { 'n', 'v', 'x' }
	-- for key, func in pairs(keymap) do
	--   vim.keymap.set(modes, key, func)
	-- end
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
