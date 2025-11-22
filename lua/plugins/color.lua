return {
	-- Название нашего локального плагина
	"melancholy",

	-- Указываем путь к папке (относительно корня конфига)
	dir = vim.fn.stdpath("config") .. "/themes/melancholy",

	lazy = false,    -- Грузим сразу
	priority = 1000, -- Грузим первым

	config = function()
		-- Просто активируем тему стандартной командой
		vim.cmd("colorscheme melancholy")
	end,
}
