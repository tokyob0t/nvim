local servers = require('servers')

local default_capabilities = {
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = true,
            },
        },
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'saghen/blink.cmp',
        'saghen/blink.lib',
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities(default_capabilities)

        for lsp, settings in pairs(servers) do
            local opts = { capabilities = capabilities }

            for k, v in pairs(settings) do
                opts[k] = v
            end

            vim.lsp.config(lsp, opts)
            vim.lsp.enable(lsp)
        end
    end,
}
