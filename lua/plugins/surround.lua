-- nvim-surround Configuration
-- This script sets up the 'nvim-surround' plugin for easier manipulation of surrounding characters in text.
-- It allows you to add, change, and delete surrounding characters such as parentheses, quotes, brackets, etc.

return {
    'kylechui/nvim-surround', -- Plugin repository for nvim-surround.

    version = '*',            -- Using the latest version of the plugin available.

    event = 'VeryLazy',       -- Load the plugin when the 'VeryLazy' event is triggered. This is typically after the editor has started.

    opts = {},                -- Optional settings for customizing the behavior of nvim-surround (empty for default configuration).
}
