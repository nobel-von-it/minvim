-- Bootstrap lazy.nvim
-- This section checks if lazy.nvim is installed. If not, it clones the repository.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none', -- Clone only essential files (no blobs).
        '--branch=stable',    -- Clone the stable branch for reliability.
        lazyrepo,
        lazypath
    }
    -- If cloning fails, show an error message and exit Neovim.
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out,                            'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar() -- Wait for user input before exiting.
        os.exit(1)       -- Exit Neovim with error code 1.
    end
end
-- Prepend lazy.nvim's path to the runtime path.
vim.opt.rtp:prepend(lazypath)

-- Set up global leader keys.
-- `mapleader` is used for normal mode mappings and `maplocalleader` for buffer-specific mappings.
vim.g.mapleader = ' '      -- Use space as the leader key for easier keybindings.
vim.g.maplocalleader = ' ' -- Use space as the local leader key.

-- Load custom options from the configuration file.
require 'config.options'

-- Setup lazy.nvim
require 'lazy'.setup {
    spec = {
        -- Import plugins from the 'plugins' directory.
        { import = 'plugins' },
    },
    -- Configure plugin installation settings.
    install = {
        -- Specify a default colorscheme to use during plugin installation.
        colorscheme = { 'no-clown-fiesta' }
    },
    -- Enable automatic checking for plugin updates.
    checker = { enabled = true },
}

-- Load custom key mappings from the configuration file.
require 'config.keymaps'
