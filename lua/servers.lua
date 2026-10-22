---@type table<string, vim.lsp.Config>
return {
    clangd = {}, -- C/C++
    ruff = {}, -- Python
    -- pylsp = {},
    jedi_language_server = {},
    jsonls = {}, -- JSON
    ts_ls = {}, -- TypeScript/JavaScript
    astro = {},
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
    qmlls = {
        on_init = function(client)
            vim.lsp.semantic_tokens.enable(false, {
                client_id = client.id,
            })
        end,
    },
    rust_analyzer = {}, -- Rust
    -- perlpls = {}, -- Perl
    marksman = {}, -- Markdown
    -- vala_ls = {}, -- Vala
    -- nil_ls = {}, -- Nix
    lemminx = {}, -- XML
    mesonlsp = {}, -- Meson
    jdtls = {}, -- Java
    -- groovyls = {},
    -- blueprint_ls = {}, -- Blueprint
    taplo = {}, -- TOML
    -- pasls = {},
    sqls = {}, -- SQL
    postgres_lsp = {},
    -- r_language_server = {},
    gopls = { -- Go
        settings = {
            gopls = {
                semanticTokens = true,
                usePlaceholders = true,
            },
        },
    },
}
