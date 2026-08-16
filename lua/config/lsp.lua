-- Diagnostic signs and configuration
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Filter out noisy LSP showMessage notifications (like transient Go package metadata warnings)
local orig_show_message = vim.lsp.handlers["window/showMessage"]
vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
	if result and result.message then
		if result.message:match("no package metadata") or
		   result.message:match("getting file for InlayHint") or
		   result.message:match("InlayHint") then
			return
		end
	end
	if orig_show_message then
		orig_show_message(err, result, ctx, config)
	end
end

-- Go interface implementation helper functions
local std_interfaces = {
	"io.Reader",
	"io.Writer",
	"io.Closer",
	"io.ReadCloser",
	"io.WriteCloser",
	"io.ReadWriteCloser",
	"io.Seeker",
	"io.ReadSeeker",
	"io.WriteSeeker",
	"io.ReadWriteSeeker",
	"fs.FS",
	"fs.FileInfo",
	"fs.File",
	"fs.DirEntry",
	"fmt.Stringer",
	"fmt.State",
	"fmt.Formatter",
	"fmt.Scanner",
	"error",
	"sort.Interface",
	"context.Context",
	"net.Conn",
	"net.Listener",
	"net.Addr",
	"http.Handler",
	"http.ResponseWriter",
	"http.RoundTripper",
	"database/sql.Scanner",
	"driver.Valuer",
}

local function get_struct_under_cursor()
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	-- Read up to 100 lines above the cursor (or from the start of the file)
	local start_line = math.max(1, cursor_line - 100)
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, cursor_line, false)

	-- Search backwards from the current line upwards
	for i = #lines, 1, -1 do
		local line = lines[i]

		-- Stop searching if we cross a function boundary
		if line:match("^%s*func%s+") then
			return nil, nil
		end

		-- Ensure the line contains "struct" and isn't a function or interface
		if line:match("struct") and not line:match("func") and not line:match("interface") then
			-- Match: type MyStruct struct, type MyStruct[T] struct, or MyStruct struct (inside type block)
			local struct_name = line:match("type%s+([%w_]+)%s+struct") or
			                    line:match("type%s+([%w_]+)%b[]%s+struct") or
			                    line:match("^%s*([%w_]+)%s+struct") or
			                    line:match("^%s*([%w_]+)%b[]%s+struct")
			if struct_name then
				local absolute_line_num = start_line + i - 1
				return struct_name, absolute_line_num
			end
		end
	end
	return nil, nil
end

-- Find the line number where the struct definition block ends (1-indexed)
local function find_struct_end_line(start_line_num)
	local total_lines = vim.api.nvim_buf_line_count(0)
	local brace_count = 0
	local has_opened = false

	for l = start_line_num, total_lines do
		local line = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1]
		if not line then break end

		for col = 1, #line do
			local char = line:sub(col, col)
			if char == "{" then
				brace_count = brace_count + 1
				has_opened = true
			elseif char == "}" then
				brace_count = brace_count - 1
			end

			if has_opened and brace_count == 0 then
				return l
			end
		end
	end
	return start_line_num
end

local function get_receiver_name(struct_name)
	local first_char = struct_name:sub(1, 1):lower()
	return string.format("%s *%s", first_char, struct_name)
end

local function get_local_interfaces()
	local interfaces = {}
	local seen = {}
	-- Try git grep first, then rg
	local cmds = {
		"git grep --no-color -h -E 'type [a-zA-Z0-9_]+ interface' -- '*.go' 2>/dev/null",
		"rg --no-heading --no-line-number -go -N 'type [a-zA-Z0-9_]+ interface' 2>/dev/null"
	}
	for _, cmd in ipairs(cmds) do
		local handle = io.popen(cmd)
		if handle then
			for line in handle:lines() do
				local name = line:match("type%s+([%w_]+)%s+interface")
				if name and not seen[name] then
					seen[name] = true
					table.insert(interfaces, name)
				end
			end
			handle:close()
			if #interfaces > 0 then
				break
			end
		end
	end
	return interfaces
end

local function run_impl(receiver, interface, struct_line)
	-- Run: impl 'r *Receiver' interface
	local cmd = string.format("impl %q %q", receiver, interface)
	local handle = io.popen(cmd)
	if not handle then
		vim.notify("Failed to run impl command", vim.log.levels.ERROR)
		return
	end
	local output = handle:read("*a")
	local success, _, exit_code = handle:close()

	if not success or (exit_code and exit_code ~= 0) then
		vim.notify(string.format("Error running impl: %s", output), vim.log.levels.ERROR)
		return
	end

	-- Split output by lines
	local lines = {}
	for line in output:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	if #lines == 0 then
		vim.notify("No methods generated by impl", vim.log.levels.WARN)
		return
	end

	-- Find the line where the struct block ends
	local end_line = find_struct_end_line(struct_line)

	-- Prepend an empty line for clean spacing
	table.insert(lines, 1, "")

	-- Insert below the end of the struct definition
	vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines)

	-- Format the file afterwards using LSP
	vim.lsp.buf.format({ async = true })
end

local function prompt_implement_interface(struct_name, struct_line)
	local receiver = get_receiver_name(struct_name)
	local local_ints = get_local_interfaces()

	local items = {}
	-- Add local interfaces first (prioritized)
	for _, name in ipairs(local_ints) do
		table.insert(items, name .. " (local)")
	end

	-- Add standard library interfaces
	for _, name in ipairs(std_interfaces) do
		table.insert(items, name)
	end

	-- Add an option to input a custom interface at the top
	table.insert(items, 1, "<Type custom interface...>")

	local ok_fzf, fzf = pcall(require, "fzf-lua")
	if ok_fzf then
		fzf.fzf_exec(items, {
			prompt = string.format("Implement interface for %s❯ ", struct_name),
			actions = {
				["default"] = function(selected)
					if not selected or #selected == 0 then return end
					local choice = selected[1]
					if choice == "<Type custom interface...>" then
						vim.ui.input({ prompt = "Interface name (e.g. io.Reader): " }, function(input)
							if input and input ~= "" then
								run_impl(receiver, input, struct_line)
							end
						end)
					else
						-- Strip the " (local)" suffix if present
						local interface = choice:gsub("%s+%(local%)$", "")
						run_impl(receiver, interface, struct_line)
					end
				end
			}
		})
	else
		-- Fallback to standard vim.ui.select
		vim.ui.select(items, {
			prompt = string.format("Implement interface for %s:", struct_name),
		}, function(choice)
			if not choice then return end
			if choice == "<Type custom interface...>" then
				vim.ui.input({ prompt = "Interface name: " }, function(input)
					if input and input ~= "" then
						run_impl(receiver, input, struct_line)
					end
				end)
			else
				local interface = choice:gsub("%s+%(local%)$", "")
				run_impl(receiver, interface, struct_line)
			end
		end)
	end
end

-- Global LSP Attach callback for buffer-local keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(event)
		local bufnr = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Enable inlay hints if supported by the server
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- Enable completion triggered by <c-x><c-o>
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
		end

		-- Try to use fzf-lua for LSP navigations, fall back to built-in LSP functions
		local ok_fzf, fzf = pcall(require, "fzf-lua")

		if ok_fzf then
			map("n", "gd", fzf.lsp_definitions, "Go to Definition (Fzf)")
			map("n", "gr", fzf.lsp_references, "Go to References (Fzf)")
			map("n", "gi", fzf.lsp_implementations, "Go to Implementation (Fzf)")
		else
			map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
			map("n", "gr", vim.lsp.buf.references, "Go to References")
			map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
		end

		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
		map("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "Format File")

		-- Diagnostic keymaps
		map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
		map("n", "<leader>d", vim.diagnostic.open_float, "Show Diagnostic Line")

		-- Go-specific mappings
		if client.name == "gopls" then
			map("n", "<leader>ci", function()
				local struct_name, struct_line = get_struct_under_cursor()
				if not struct_name then
					vim.notify("Cursor is not on a struct definition", vim.log.levels.WARN)
					return
				end
				prompt_implement_interface(struct_name, struct_line)
			end, "Implement Interface (Go)")
		end
	end,
})

-- Configure gopls
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- Enable gopls
vim.lsp.enable("gopls")

-- Configure rust_analyzer
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			check = {
				command = "clippy",
			},
		},
	},
})

-- Enable rust_analyzer
vim.lsp.enable("rust_analyzer")

-- Configure nil_ls (Nix LSP)
vim.lsp.config("nil_ls", {
	settings = {
		["nil"] = {
			nix = {
				flake = {
					autoArchive = true,
				},
			},
			formatting = {
				command = { "nixfmt" }, -- You can change this to "alejandra" or "nixpkgs-fmt" if needed
			},
		},
	},
})
vim.lsp.enable("nil_ls")

-- Configure nixd (Nix LSP)
vim.lsp.config("nixd", {
	settings = {
		nixd = {
			formatting = {
				command = { "nixfmt" }, -- You can change this to "alejandra" or "nixpkgs-fmt" if needed
			},
		},
	},
})
vim.lsp.enable("nixd")

-- Auto-format and organize imports on save for Go files
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	pattern = "*.go",
	callback = function()
		-- Organize imports
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
				elseif r.command then
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
		-- Format
		vim.lsp.buf.format({ async = false })
	end,
})

-- Auto-format on save for Rust files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Auto-format on save for Nix files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	pattern = "*.nix",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
