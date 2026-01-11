return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = {
			view = "cmdline_popup",
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			},
		},
		messages = {
			enabled = false,
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		lsp = {
			progress = { enabled = false },
			hover = { enabled = false },
			signature = { enabled = false },
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
		},
	},
}
