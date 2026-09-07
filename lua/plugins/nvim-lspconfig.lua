---@type table<string, vim.lsp.Config>
local servers = {
    clangd = {}, -- C/C++
    ruff = {}, -- Python
    pylsp = {},
    -- jedi_language_server = {},
    jsonls = {}, -- JSON
    ts_ls = {}, -- TypeScript/JavaScript
    biome = {},
    emmet_language_server = {
        init_options = { showSuggestionsAsSnippets = true },
    },
    -- somesass_ls = {},         -- CSS/SCSS
    cssls = {},
    bashls = {}, -- Bash
    -- lua_ls = {},              -- Lua
    emmylua_ls = {},
    fennel_ls = {},
    rust_analyzer = {}, -- Rust
    perlpls = {}, -- Perl
    marksman = {}, -- Markdown
    vala_ls = {}, -- Vala
    nil_ls = {}, -- Nix
    lemminx = {}, -- XML
    mesonlsp = {}, -- Meson
    jdtls = {}, -- Java
    groovyls = {},
    blueprint_ls = {}, -- Blueprint
    taplo = {}, -- TOML
    pasls = {},
    sqls = {}, -- SQL
    postgres_lsp = {},
    r_language_server = {},
    gopls = {
        settings = {
            gopls = {
                semanticTokens = true,
                usePlaceholders = true,
            },
        },
    }, -- Go
}

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
        'SmiteshP/nvim-navic',
        'saghen/blink.cmp',
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities(default_capabilities)
        -- local capabilities =
        --     require('cmp_nvim_lsp').default_capabilities(default_capabilities)

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
