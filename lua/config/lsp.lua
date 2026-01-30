vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("nerd-config", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local fzf = require("fzf-lua")
		map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gr", fzf.lsp_references, "[G]oto [R]eferences")
		map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")

		map("<leader>D", fzf.lsp_typedefs, "[G]oto [T]ype Definition")
		map("<leader>ds", fzf.lsp_document_symbols, "Goto [D]ocument [S]ymbols")
		map("<leader>ws", fzf.lsp_live_workspace_symbols, "Goto [W]orkspace [S]ymbols")

		map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

		if vim.bo[event.buf].filetype == "markdown" then
			map("<leader>x", function()
				local line = vim.api.nvim_get_current_line()
				local new_line

				if line:find("%- %[ %]") then
					new_line = (line:gsub("%- %[ %]", "- [x]", 1))
				else
					new_line = (line:gsub("%- %[x%]", "- [ ]", 1))
				end

				if new_line then
					vim.api.nvim_set_current_line(new_line)
				end
			end, "Toggle Checkbox")
		end

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("nerd-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("nerd-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "nerd-lsp-highlight", buffer = event2.buf })
				end,
			})
		end
		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"marksman",
	"basedpyright",
	"html_ls",
	"css_ls",
	"ts_ls",
	"gopls",
})
