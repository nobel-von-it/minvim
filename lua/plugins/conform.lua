return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
			rust = { "rustfmt" },

			sh = { "shfmt" },
			toml = { "tombi" },

			json = { "jq" },

			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "gofumpt" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-l", "-w" },
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
