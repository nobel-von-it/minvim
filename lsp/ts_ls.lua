return {
	capatibilities = function()
		local success, blink = pcall(require, "blink.cmp")
		local capatibilities = success and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

		return capatibilities
	end,
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
