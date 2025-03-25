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
        -- somewhere in your config:
        vim.cmd("colorscheme onedark")
    end
}
