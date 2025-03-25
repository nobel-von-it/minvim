-- Neovim Configuration
-- This file customizes Neovim's behavior using the vim.opt API.

-- Enable absolute and relative line numbers.
vim.opt.number = true -- Show absolute line numbers (default: false).
vim.opt.relativenumber = true -- Show relative numbers except for the current line (default: false).

-- Highlight the current line for better visibility.
vim.opt.cursorline = true -- Enable cursor line highlighting (default: false).

-- Configure timeout for key sequences.
vim.opt.timeoutlen = 200 -- Wait 200ms for a mapped sequence to complete (default: 1000).

-- Set scroll offset to keep context around the cursor.
vim.opt.scrolloff = 12 -- Keep 12 lines visible above and below the cursor (default: 0).

-- Tab and indentation settings.
vim.opt.expandtab = true -- Convert tabs to spaces (default: false).
vim.opt.tabstop = 4 -- Number of spaces for a tab character (default: 8).
vim.opt.shiftwidth = 4 -- Number of spaces for auto-indentation (default: 8).
vim.opt.softtabstop = 4 -- Number of spaces for <Tab> and <BS> (default: 0).
vim.opt.smarttab = true -- Enable smart tab behavior (default: false).
vim.opt.smartindent = true -- Enable smart indentation based on syntax (default: false).

-- Enable persistent undo to retain undo history between sessions.
vim.opt.undofile = true -- Save undo history to a file (default: false).

-- UI enhancements.
-- vim.opt.signcolumn = 'yes'  -- Always show the sign column (default: 'auto').
-- vim.opt.colorcolumn = '120' -- Highlight column 120 to indicate max line length (default: empty).
vim.opt.wrap = false -- Disable line wrapping (default: true).

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
