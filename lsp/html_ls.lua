return {
	capatibilities = function()
		local success, blink = pcall(require, "blink.cmp")
		local capatibilities = success and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

		return capatibilities
	end,
	filetypes = {
		"html",
	},
	cmd = { "vscode-html-languageserver", "--stdio" },
}
