-- trouble.nvim Configuration
-- This script sets up the 'folke/trouble.nvim' plugin, which provides a pretty and user-friendly
-- way of showing diagnostics, LSP references, quickfixes, location lists, and more.
-- You can view and navigate through issues and errors in your project using the Trouble window.
-- May be removed in future because I learning fzf-lua and use it instead
-- But it's working for now and it's good choice for lazy.nvim

return {
    'folke/trouble.nvim', -- Plugin repository for trouble.nvim.

    opts = {},            -- Default options. You can customize the plugin settings here, for detailed configuration options refer to the official documentation.

    cmd = 'Trouble',      -- Command to trigger the Trouble plugin. Use :Trouble to open it.

    keys = {
        -- Keybinding to toggle diagnostics.
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics (Trouble)',
        },
        -- Keybinding to toggle buffer-specific diagnostics.
        {
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Buffer Diagnostics (Trouble)',
        },
        -- Keybinding to toggle symbol search in the Trouble window.
        {
            '<leader>cs',
            '<cmd>Trouble symbols toggle focus=false<cr>',
            desc = 'Symbols (Trouble)',
        },
        -- Keybinding to toggle LSP definitions, references, and other related information.
        {
            '<leader>cl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'LSP Definitions / references / ... (Trouble)',
        },
        -- Keybinding to toggle the location list (a list of positions from your project).
        {
            '<leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location List (Trouble)',
        },
        -- Keybinding to toggle the quickfix list in the Trouble window.
        {
            '<leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix List (Trouble)',
        },
    },
}

