-- which-key.nvim Configuration
-- This plugin provides a keybinding popup to show available keymaps and their descriptions.
-- It allows for better discoverability of keymaps and can be configured to display keymaps locally or globally.

return {
    'folke/which-key.nvim', -- Plugin repository for which-key.nvim.

    event = 'VeryLazy',     -- The plugin will be loaded after a "VeryLazy" event (i.e., lazy loading when needed).

    opts = {},              -- Default options for the plugin. You can customize the options here for global settings.
    -- For more detailed configuration, refer to the plugin's documentation.

    keys = {
        -- Keybinding to show the keymap for the current buffer.
        {
            '<leader>?',
            function()
                require 'which-key'.show { global = false }
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}

