local function get_fish_env(var_name)
	local cmd = string.format("fish -c 'unlock_vault > /dev/null; echo $%s'", var_name)
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result:gsub("%s+", "")
end

local gpg_home = get_fish_env("GNUPGHOME")
if gpg_home ~= "" then
	vim.env.GNUPGHOME = gpg_home
end

local ssh_auth = get_fish_env("SSH_AUTH_SOCK")
if ssh_auth ~= "" then
	vim.env.SSH_AUTH_SOCK = ssh_auth
end

-- ========================================================================== --
-- ==                         BOOTSTRAP PLUGINS                            == --
-- ========================================================================== --

local function bootstrap()
	local pack_path = vim.fn.stdpath("config") .. "/pack/bundle/start"
	local plugins = {
		["nvim-treesitter"] = "https://github.com/nvim-treesitter/nvim-treesitter",
		["fzf-lua"]         = "https://github.com/ibhagwan/fzf-lua",
		["mini.nvim"]       = "https://github.com/echasnovski/mini.nvim",
		["vim-dispatch"]    = "https://github.com/tpope/vim-dispatch",
		["oil.nvim"]        = "https://github.com/stevearc/oil.nvim",
		["nvim-dap"]        = "https://github.com/mfussenegger/nvim-dap",
		["gitsigns.nvim"]   = "https://github.com/lewis6991/gitsigns.nvim",
        ["tmux-navigator"]  = "https://github.com/alexghergh/nvim-tmux-navigation"
	}

	local cloned = false
	for name, url in pairs(plugins) do
		local path = pack_path .. "/" .. name
		if vim.fn.isdirectory(path) == 0 then
			print("Cloning " .. name .. "...")
			vim.fn.system({ "git", "clone", "--depth", "1", url, path })
			cloned = true
		end
	end

	if cloned then
		print("Plugins installed. PLEASE RESTART NEOVIM to apply changes.")
	end
end

bootstrap()

-- ========================================================================== --
-- ==                         CORE CONFIGURATION                           == --
-- ========================================================================== --

require("config.options")
require("config.keymaps")
require("config.autocmds")
pcall(require, "config.dap") -- New DAP config

-- Load Melancholy Theme
pcall(vim.cmd, "colorscheme melancholy")

-- Helper to safely setup plugins
local function safe_setup(module, opts)
	local ok, m = pcall(require, module)
	if ok then
		m.setup(opts or {})
	end
end

-- Plugin Setup (Minimalist)
safe_setup("mini.statusline", {
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git           = MiniStatusline.section_git({ trunc_width = 75 })
			local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location      = MiniStatusline.section_location({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl,                  strings = { mode } },
				{ hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
				'%<', -- Mark truncation point
				{ hl = 'MiniStatuslineFilename', strings = { filename } },
				'%=', -- End left alignment
				{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
				{ hl = mode_hl,                  strings = { location } },
			})
		end,
	},
})

safe_setup("mini.pairs")
safe_setup("mini.surround")
safe_setup("mini.icons")
safe_setup("oil", {
	keymaps = {
		["-"] = "actions.parent",
	},
})
safe_setup("gitsigns")

-- Tmux Navigation
local ok_tmux, ntn = pcall(require, "nvim-tmux-navigation")
if ok_tmux then
	ntn.setup({
		disable_when_zoomed = true,
	})
	vim.keymap.set("n", "<C-h>", ntn.NvimTmuxNavigateLeft)
	vim.keymap.set("n", "<C-j>", ntn.NvimTmuxNavigateDown)
	vim.keymap.set("n", "<C-k>", ntn.NvimTmuxNavigateUp)
	vim.keymap.set("n", "<C-l>", ntn.NvimTmuxNavigateRight)
	vim.keymap.set("n", "<C-\\>", ntn.NvimTmuxNavigateLastActive)
	vim.keymap.set("n", "<C-Space>", ntn.NvimTmuxNavigateNext)
end

-- Fzf-lua Setup
local ok_fzf, fzf = pcall(require, "fzf-lua")
if ok_fzf then
	fzf.setup({
		"fzf-native",
		winopts = {
			height = 0.85,
			width  = 0.80,
			row    = 0.35,
			col    = 0.50,
			border = "rounded",
		},
	})
end

-- Treesitter Setup
local ok_ts, ts = pcall(require, "nvim-treesitter.configs")
if ok_ts then
	ts.setup({
		ensure_installed = { "lua", "rust", "cpp", "python", "javascript", "c" },
		highlight = { enable = true },
	})
end
