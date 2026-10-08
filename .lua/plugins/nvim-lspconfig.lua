-- [nfnl] fnl/plugins/nvim-lspconfig.fnl
local servers = {astro = {}, bashls = {}, biome = {}, blueprint_ls = {}, clangd = {}, cssls = {}, emmet_language_server = {init_options = {showSuggestionsAsSnippets = true}}, emmylua_ls = {}, fennel_ls = {}, gopls = {settings = {gopls = {semanticTokens = true, usePlaceholders = true}}}, groovyls = {}, jdtls = {}, jsonls = {}, lemminx = {}, marksman = {}, mesonlsp = {}, nil_ls = {}, pasls = {}, perlpls = {}, postgres_lsp = {}, pylsp = {}, r_language_server = {}, ruff = {}, rust_analyzer = {}, sqls = {}, taplo = {}, ts_ls = {}, vala_ls = {}}
local default_capabilities = {textDocument = {completion = {completionItem = {snippetSupport = true}}, foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}}}
local function _1_()
  local capabilities = require("blink.cmp").get_lsp_capabilities(default_capabilities)
  for lsp, settings in pairs(servers) do
    local opts = {capabilities = capabilities}
    for k, v in pairs(settings) do
      opts[k] = v
    end
    vim.lsp.config(lsp, opts)
    vim.lsp.enable(lsp)
  end
  return nil
end
return {"neovim/nvim-lspconfig", config = _1_, dependencies = {"saghen/blink.cmp"}}
