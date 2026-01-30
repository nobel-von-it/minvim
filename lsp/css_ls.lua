return {
	capatibilities = function()
		local success, blink = pcall(require, "blink.cmp")
		local capatibilities = success and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

		return capatibilities
	end,
	cmd = { "vscode-css-languageserver", "--stdio" },
	filetypes = {
		"css",
		"scss",
		"less",
	},
	settings = {
		css = { validate = true },
		less = { validate = true },
		scss = { validate = true },
	},
}
