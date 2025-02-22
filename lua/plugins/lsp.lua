return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'j-hui/fidget.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

        require 'fidget'.setup {}

        require 'mason-lspconfig'.setup {
            ensure_installed = {
                'lua_ls',
                'rust_analyzer',
                'gopls',
                'erlangls',
                'clangd',
                'ts_ls',
                'html',
                'cssls',
                'jdtls',
                'graphql',
                'jsonls',
                'pyright',
                'yamlls',
                'volar',
            },
            handlers = {
                function(server_name)
                    require 'lspconfig'[server_name].setup {
                        capabilities = capabilities,
                        settings = {
                            ['rust-analyzer'] = {
                                checkOnSave = {
                                    command = 'clippy'
                                }
                            }
                        }
                    }
                end,
            }
        }

        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

        for _, method in ipairs {
            'textDocument/diagnostic',
            'workspace/diagnostic'
        } do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, config)
                if err ~= nil and err.code == -32802 then
                    return
                end
                return default_diagnostic_handler(err, result, context, config)
            end
        end

        vim.diagnostic.config {
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            }
        }
    end
}
