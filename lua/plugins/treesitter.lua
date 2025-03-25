-- nvim-treesitter Configuration
-- This script sets up the 'nvim-treesitter' plugin, which provides improved syntax highlighting,
-- better code folding, and many other features by utilizing tree-sitter parsers.

return {
    'nvim-treesitter/nvim-treesitter', -- Plugin repository for nvim-treesitter.

    build = ':TSUpdate',               -- Run ':TSUpdate' after installation to update the installed parsers.

    -- Configuration for nvim-treesitter setup.
    config = function()
        -- Set fold method to 'expr' and configure it to use treesitter's foldexpr.
        -- vim.wo.foldmethod = 'expr'                     -- Use treesitter-based folding.
        -- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()' -- Define the folding expression to use treesitter.

        -- Set up nvim-treesitter with specific options.
        require 'nvim-treesitter.configs'.setup {
            -- List of languages to install and configure.
            ensure_installed = {
                'vimdoc', 'rust', 'c', 'lua', 'html', 'css', 'bash', 'go', 'javascript', 'cpp', 'erlang', 'prolog'
            },

            -- Disable synchronous installation of parsers to improve startup time.
            sync_install = false, -- Do not block startup while parsers are being installed.

            -- Enable automatic installation of missing parsers.
            auto_install = true, -- Automatically install missing parsers on demand.

            -- Configure indentation using treesitter.
            indent = {
                enable = true, -- Enable treesitter-based indentation.
            },


            -- Enable syntax highlighting using treesitter.
            highlight = {
                enable = true, -- Enable highlighting.
            },

            -- Configure incremental selection (interactive navigation through tree nodes).
            -- Very useful for large code structures and fast movement.
            incremental_selection = {
                enable = true, -- Enable incremental selection.
                keymaps = {
                    -- Keymaps for initiating and modifying incremental selections.
                    init_selection = "<Enter>",       -- Start selection with Enter key.
                    node_incremental = "<Enter>",     -- Expand selection to the next node with Enter key.
                    scope_incremental = false,        -- Disable scope-based selection (for larger code structures).
                    node_decremental = "<Backspace>", -- Shrink selection to the previous node with Backspace.
                },
            },
        }
    end
}
