return {
	"olimorris/onedarkpro.nvim",
	priority = 1000,
	config = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				local highlights = {
					"Normal",
					"LineNr",
					"Folded",
					"NonText",
					"SpecialKey",
					"VertSplit",
					"SignColumn",
					"EndOfBuffer",
					"TablineFill",
				}
				for _, name in pairs(highlights) do
					vim.cmd.highlight(name .. " guibg=none ctermbg=none")
				end
			end,
		})
		vim.cmd("colorscheme onedark")
	end,
}
