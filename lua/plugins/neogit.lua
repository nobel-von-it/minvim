-- neogit Configuration
-- This script sets up the 'neogit' plugin for Git integration inside Neovim.
-- Neogit provides a fast and intuitive Git interface with support for staging, commits, and diff viewing.

return {
    'NeogitOrg/neogit', -- Plugin repository for neogit.

    dependencies = {
        'nvim-lua/plenary.nvim',  -- Required dependency for utility functions used by neogit.
        'sindrets/diffview.nvim', -- Diff viewer integration to show Git diffs in a side-by-side view.
        'ibhagwan/fzf-lua',       -- Fuzzy finder integration for Git file search.
    },

    opts = {}, -- Optional settings for neogit (empty for default configuration).

    -- Key mappings for launching neogit UI.
    keys = {
        -- Map <leader>g to open Neogit interface.
        { '<leader>g', '<cmd>Neogit<cr>', desc = 'Open Neo[g]it', },
    },
}

