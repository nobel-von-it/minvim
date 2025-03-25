-- fzf-lua Configuration
-- This script sets up the 'fzf-lua' plugin for fuzzy finding in Neovim.
-- Provides file searching, live grep, command discovery, and help lookup with minimal configuration.
-- See https://github.com/ibhagwan/fzf-lua for more details about useful features.

return {
    "ibhagwan/fzf-lua", -- Plugin repository for fzf-lua, a Lua-based fuzzy finder for Neovim.

    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Optional dependency for file icons in search results.
    },

    opts = {}, -- Optional settings for fzf-lua (empty for default configuration).

    keys = {
        -- Key mappings for fzf-lua functions.

        -- Find files in the current directory and subdirectories.
        { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>",     desc = "[F]ind [F]iles" },

        -- Perform a live grep search for text across files.
        { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", desc = "[F]ind [G]rep" },

        -- Discover and execute builtin commands.
        { "<leader>fb", "<cmd>lua require('fzf-lua').builtin()<cr>",   desc = "[F]ind [B]uiltin commands" },

        -- Search help tags for documentation.
        { "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<cr>", desc = "[F]ind [H]elp" },

    }
}
