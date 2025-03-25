-- nvim-treesitter-textobjects Configuration
-- This script sets up the 'nvim-treesitter-textobjects' plugin, which extends nvim-treesitter functionality
-- to allow easier manipulation of text objects. You can select, swap, and move around treesitter nodes
-- (like functions, comments, and conditionals) using custom keybindings.
-- See https://github.com/nvim-treesitter/nvim-treesitter-textobjects for more details about the plugin.

return {
    'nvim-treesitter/nvim-treesitter-textobjects',        -- Plugin repository for nvim-treesitter-textobjects.

    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Ensure nvim-treesitter is installed as a dependency.

    init = function()
        -- Configure nvim-treesitter-textobjects.
        require 'nvim-treesitter.configs'.setup {
            textobjects = {
                -- Setup for textobject selection
                select = {
                    enable = true,                  -- Enable selection of text objects.
                    lookahead = true,               -- Lookahead to prevent moving past text objects.
                    keymaps = {
                        ['af'] = '@function.outer', -- Select the outer part of a function.
                        ['if'] = '@function.inner', -- Select the inner part of a function.
                        ['ac'] = '@comment.outer',  -- Select the outer part of a comment.
                        ['ic'] = '@comment.inner',  -- Select the inner part of a comment.
                    },
                },

                -- Setup for textobject swapping (allows for swapping text objects).
                swap = {
                    enable = true,                           -- Enable swapping functionality.
                    swap_next = {
                        ['<leader>sp'] = '@parameter.inner', -- Swap the next parameter.
                    },
                    swap_previous = {
                        ['<leader>sP'] = '@parameter.inner', -- Swap the previous parameter.
                    },
                },

                -- Setup for moving between text objects.
                move = {
                    enable = true,    -- Enable moving functionality.
                    set_jumps = true, -- Enable jumps when moving between text objects.
                    -- Move to the next/previous function.
                    goto_next_start = {
                        [']m'] = '@function.outer', -- Go to the start of the next function.
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer', -- Go to the end of the next function.
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer', -- Go to the start of the previous function.
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer', -- Go to the end of the previous function.
                    },
                    -- Move to the next/previous conditional.
                    goto_next = {
                        ["]d"] = "@conditional.outer", -- Go to the next conditional block.
                    },
                    goto_previous = {
                        ["[d"] = "@conditional.outer", -- Go to the previous conditional block.
                    }
                }
            },
        }
    end
}

