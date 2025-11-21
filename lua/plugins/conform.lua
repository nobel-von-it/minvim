return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			rust = { "rustfmt" },

			sh = { "shfmt" },
			toml = { "tombi" },

			javascript = { "prettierd", "prettier" },
			typescirpt = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			scss = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			yaml = { "prettierd", "prettier" },
			markdown = { "prettierd", "prettier" },

			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "gofumpt" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-l", "-w" }
			},
			-- tombi = {
			-- 	prepend_args = { "format" }
			-- }
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
			stop_after_first = true,
		},
	},
}
