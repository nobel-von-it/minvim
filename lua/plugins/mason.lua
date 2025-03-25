-- mason.nvim Configuration
-- This script sets up the 'mason.nvim' plugin for managing LSP (Language Server Protocol) servers, linters, and formatters in Neovim.
-- It simplifies installing and configuring external tools without requiring system-wide installations.

return {
    'williamboman/mason.nvim', -- Plugin repository for mason.nvim.

    dependencies = {
        'williamboman/mason-lspconfig.nvim', -- Dependency for seamless integration with LSP configuration.
    },

    opts = {}, -- Optional settings for mason.nvim (empty for default configuration).
}

