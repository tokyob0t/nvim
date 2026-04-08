local servers = {
    'clangd', -- C/C++
    'ruff', -- Python
    'pylsp',
    -- 'jedi_language_server',
    'jsonls', -- Json
    'ts_ls', -- TypeScript/JavaScript
    'biome',
    'biome',
    'emmet_language_server',
    'somesass_ls', -- CSS/SCSS
    'bashls', -- Bash
    'lua_ls', -- Lua
    'fennel_ls',
    'rust_analyzer', -- Rust
    'perlpls', -- Perl
    'marksman', -- Markdown
    'vala_ls', -- Vala
    'nil_ls', -- Nix
    'lemminx', -- xml
    'mesonlsp', -- meson
    'jdtls', -- Java
    'groovyls',
    'blueprint_ls', -- Blueprint
    'taplo', -- TOML
    'pasls',
    'sqlls', -- SQL
    'postgres_lsp',
    'r_language_server',
    'gopls', -- Go
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'SmiteshP/nvim-navic',
    },
    config = function()
        -- local navic = require('nvim-navic')

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        capabilities.textDocument.completion.completionItem.snippetSupport =
            true

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        local opts = {
            capabilities = capabilities,
            -- on_attach = function(client, bufnr)
            --     if client.server_capabilities.documentSymbolProvider then
            --         navic.attach(client, bufnr)
            --     end
            -- end,
        }

        for _, lsp in ipairs(servers) do
            if lsp == 'emmet_language_server' then
                opts.init_options = { showSuggestionsAsSnippets = true }
            end

            -- require('lspconfig')[lsp].setup(opts)
            vim.lsp.config(lsp, opts)
            vim.lsp.enable(lsp)
        end
    end,
}
