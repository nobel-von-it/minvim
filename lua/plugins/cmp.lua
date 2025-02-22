return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
    },

    config = function()
        local cmp = require 'cmp'
        local select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup {
            snippet = {
                expand = function(args)
                    require 'luasnip'.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-p>'] = cmp.mapping.select_prev_item(select),
                ['<C-n>'] = cmp.mapping.select_next_item(select),
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                ['<CR>'] = cmp.mapping.confirm { select = true },
                ['<C-Space>'] = cmp.mapping.complete(),
            },
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },
                { name = 'codeium' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            }
        }
    end
}
