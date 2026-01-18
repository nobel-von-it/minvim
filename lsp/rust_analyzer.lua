return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	capatibilities = function()
		local success, blink = pcall(require, "blink.cmp")
		local capatibilities = success and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

		return capatibilities
	end,
	root_markers = { "Cargo.toml" },
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
			diagnostics = {
				enable = true,
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
}
