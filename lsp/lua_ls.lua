return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	capatibilities = function()
		local success, blink = pcall(require, "blink.cmp")
		local capatibilities = success and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

		return capatibilities
	end,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			completion = { callSnippet = "Replace" },
		},
	},
}
