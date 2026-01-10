local M = {}

M.setup = function()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.g.colors_name = "melancholy"

	-- 1. ПАЛИТРА (В точности как в Alacritty)
	local c = {
		bg = "#1a1c23",
		fg = "#aab1be",

		-- Акценты
		red = "#b07b7b",
		green = "#8da18d",
		yellow = "#bfb48f",
		blue = "#7a8ca3",
		magenta = "#9e8ba3",
		cyan = "#889ca6",

		-- Служебные
		grey = "#4b5263",
		dark_grey = "#2c323c",
		selection = "#3e4452",
		none = "NONE",
	}

	-- 2. ТАБЛИЦА ГРУПП
	local highlights = {
		-- == БАЗОВЫЕ ==
		Normal = { fg = c.fg, bg = c.none }, -- Прозрачный фон для интеграции с Alacritty
		NormalFloat = { fg = c.fg, bg = c.bg },
		FloatBorder = { fg = c.blue, bg = c.bg },
		ColorColumn = { bg = c.dark_grey },
		Cursor = { reverse = true },
		Visual = { bg = c.selection },
		Directory = { fg = c.blue },

		-- == UI (Gutter, Line numbers) ==
		LineNr = { fg = c.grey },
		CursorLine = { bg = c.dark_grey },
		CursorLineNr = { fg = c.blue, bold = true },
		SignColumn = { bg = c.none },
		VertSplit = { fg = c.dark_grey },
		WinSeparator = { fg = c.dark_grey },
		StatusLine = { fg = c.fg, bg = c.dark_grey },
		StatusLineNC = { fg = c.grey, bg = c.bg },

		-- == СИНТАКСИС (Code) ==
		Comment = { fg = c.grey, italic = true },
		String = { fg = c.green },
		Number = { fg = c.yellow },
		Boolean = { fg = c.yellow },

		-- Убираем шум: переменные просто текстом
		Identifier = { fg = c.fg },
		Function = { fg = c.blue },

		-- Ключевые слова
		Keyword = { fg = c.magenta },
		Statement = { fg = c.magenta },
		Conditional = { fg = c.magenta },
		Repeat = { fg = c.magenta },
		Operator = { fg = c.cyan },
		Type = { fg = c.cyan },

		-- Специальное
		PreProc = { fg = c.cyan },
		Special = { fg = c.blue },

		-- == ПОИСК И МЕНЮ ==
		Pmenu = { fg = c.fg, bg = c.dark_grey },
		PmenuSel = { fg = c.bg, bg = c.blue, bold = true },
		Search = { fg = c.bg, bg = c.yellow },
		IncSearch = { fg = c.bg, bg = c.yellow },

		-- == ДИАГНОСТИКА (LSP) ==
		DiagnosticError = { fg = c.red },
		DiagnosticWarn = { fg = c.yellow },
		DiagnosticInfo = { fg = c.blue },
		DiagnosticHint = { fg = c.cyan },

		-- == GIT SIGNS ==
		GitSignsAdd = { fg = c.green },
		GitSignsChange = { fg = c.blue },
		GitSignsDelete = { fg = c.red },

		-- == TREESITTER (Уточнения) ==
		["@variable"] = { link = "Identifier" },
		["@variable.builtin"] = { link = "Keyword" },
		["@function.builtin"] = { link = "Function" },
		["@keyword.function"] = { link = "Keyword" },
		["@constant"] = { link = "Number" },
		["@property"] = { fg = c.cyan },
		["@field"] = { fg = c.fg },
		["@parameter"] = { fg = c.fg },

		-- == TELESCOPE ==
		TelescopeBorder = { fg = c.grey },
		TelescopePromptBorder = { fg = c.blue },
		TelescopePromptTitle = { fg = c.blue },
		TelescopePromptPrefix = { fg = c.green },

		-- == RENDER-MARKDOWN (Общие) ==
		RenderMarkdownBullet = { fg = c.yellow },
		RenderMarkdownCode = { bg = c.dark_grey },
		RenderMarkdownCodeInline = { bg = c.dark_grey, fg = c.cyan },
		RenderMarkdownTableHead = { fg = c.blue, bold = true },
		RenderMarkdownTableRow = { fg = c.fg },
		RenderMarkdownTableFill = { fg = c.dark_grey },
		RenderMarkdownSuccess = { fg = c.green },
		RenderMarkdownInfo = { fg = c.blue },
		RenderMarkdownWarn = { fg = c.yellow },
		RenderMarkdownError = { fg = c.red },

		-- == ЗАГОЛОВКИ (Headings) ==
		-- Используем акценты палитры для уровней заголовков
		RenderMarkdownH1 = { fg = c.blue, bg = c.blue, bold = true },
		RenderMarkdownH1Bg = { bg = "#252b37", fg = c.blue, bold = true }, -- Чуть светлее базы для выделения
		RenderMarkdownH2 = { fg = c.magenta, bold = true },
		RenderMarkdownH2Bg = { bg = "#2b2537", fg = c.magenta, bold = true },
		RenderMarkdownH3 = { fg = c.cyan, bold = true },
		RenderMarkdownH4 = { fg = c.green, bold = true },
		RenderMarkdownH5 = { fg = c.yellow, bold = true },
		RenderMarkdownH6 = { fg = c.red, bold = true },

		-- == ЧЕКБОКСЫ (Checkboxes) ==
		RenderMarkdownTodo = { fg = c.yellow }, -- [ ]
		RenderMarkdownChecked = { fg = c.green }, -- [x]
		RenderMarkdownUnchecked = { fg = c.grey }, -- [ ] (пустой)

		-- == CALLOUTS (Obsidian style) ==
		-- Настройка блоков > [!INFO] и прочих
		["@markup.quote.markdown_inline"] = { fg = c.grey },
		RenderMarkdownCallout = { fg = c.blue },
		Conceal = { fg = c.grey },
	}

	-- 3. ПРИМЕНЕНИЕ
	for group, settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return M
