return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'ibhagwan/fzf-lua',
    },
    opts = {},
    keys = {
        {
            "<leader>g",
            "<cmd>Neogit<cr>",
            desc = "Neogit",
        },
    }
}
