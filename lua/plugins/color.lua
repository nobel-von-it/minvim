-- no-clown-fiesta.nvim Configuration
-- This script sets up the 'no-clown-fiesta' colorscheme for Neovim.
-- The theme provides a balanced and visually pleasing color palette without excessive saturation (in my opinion).

-- return {
--     'aktersnurra/no-clown-fiesta.nvim', -- Plugin repository for the colorscheme.
--
--     priority = 1000,                    -- High priority to ensure the colorscheme is loaded first.
--     lazy = false,                       -- Disable lazy loading to apply the theme immediately at startup.
--
--     -- Configuration function to apply the colorscheme.
--     config = function()
--         vim.cmd.colorscheme 'no-clown-fiesta' -- Activate the 'no-clown-fiesta' colorscheme.
--     end,
-- }

return {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function()
                local highlights = {
                    'Normal',
                    'LineNr',
                    'Folded',
                    'NonText',
                    'SpecialKey',
                    'VertSplit',
                    'SignColumn',
                    'EndOfBuffer',
                    'TablineFill', -- this is specific to how I like my tabline to look like
                }
                for _, name in pairs(highlights) do vim.cmd.highlight(name .. ' guibg=none ctermbg=none') end
            end,
        })
        -- somewhere in your config:
        vim.cmd("colorscheme onedark")
    end
}
