local M = {}

M.config = {
	root_dir = os.getenv("MO_BASE_PATH") .. "/",
	file_extensions = { "md", "txt", "org" },
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	vim.keymap.set("n", "gd", M.go_to_definition, { desc = "Wiki Go to Definition" })
end

local function push_to_tagstack()
	local from = { vim.fn.bufnr("%"), vim.fn.line("."), vim.fn.col("."), 0 }
	local items = { { tagname = vim.fn.expand("<cword>"), from = from } }
	vim.fn.settagstack(vim.fn.win_getid(), { items = items }, "a")
end

-- Основная логика gd
function M.go_to_definition()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1

	local prefix = line:sub(1, col)
	local start_bracket = prefix:match(".*%[%[()")

	local suffix = line:sub(col)
	local end_bracket_rel = suffix:find("%]%]")

	if start_bracket and end_bracket_rel then
		local end_bracket = col + end_bracket_rel - 2
		local content = line:sub(start_bracket, end_bracket)

		local filename = content:match("([^|]+)")

		if filename then
			filename = filename:gsub("^%s+", ""):gsub("%s+$", ""):gsub("%s+", " ")

			if filename ~= "" then
				push_to_tagstack()
				M.find_and_open_file(filename)
				return
			end
		end
	end
	local word = vim.fn.expand("<cWORD>")
	if word:match("^#") then
		push_to_tagstack()
		M.search_tag(word)
		return
	end

	vim.lsp.buf.definition()
end

-- Поиск файла с помощью fd
function M.find_and_open_file(name)
	name = name:gsub("[*?]", "")

	local has_fzf, fzf = pcall(require, "fzf-lua")
	if has_fzf then
		fzf.files({
			prompt = "Choose file >",
			query = name,
			cwd = M.config.root_dir,
		})
	else
		local cmd = string.format('fd -t f --fixed-strings "%s" "%s"', name, M.config.root_dir)
		local results = vim.fn.systemlist(cmd)

		if #results == 0 then
			print("Файл не найден: " .. name)
		elseif #results == 1 then
			vim.cmd("edit " .. vim.fn.fnameescape(results[1]))
		else
			vim.fn.setqflist({}, "r", { title = "Результаты поиска " .. name, lines = results })
			vim.cmd("copen")
		end
	end
end

-- Поиск тега с помощью ripgrep
function M.search_tag(tag)
	local has_fzf, fzf = pcall(require, "fzf-lua")
	if has_fzf then
		fzf.grep({
			search = tag,
			cwd = M.config.root_dir,
		})
	else
		local cmd = string.format('rg --vimgrep --fixed-strings "%s" "%s"', tag, M.config.root_dir)

		local results = vim.fn.systemlist(cmd)

		if #results == 0 then
			print("Тег не найден: " .. tag)
		else
			vim.fn.setqflist({}, "r", { title = "Упоминания тега " .. tag, lines = results })
			vim.cmd("copen")
		end
	end
end

return M
